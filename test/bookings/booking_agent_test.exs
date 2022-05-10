defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingsAgent

  describe "save/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when the param are valid, return a booking uuid" do
      user = build(:user)
      user_id = user.id

      {:ok, uuid} =
        :booking
        |> build(user_id: user_id)
        |> BookingsAgent.save()

      assert {:ok, _result} = UUID.info(uuid)
    end
  end

  describe "get/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when the booking is found, return a booking" do
      user = build(:user)

      booking = build(:booking, user_id: user.id)
      {:ok, uuid} = BookingsAgent.save(booking)

      {:ok, booking} = BookingsAgent.get(uuid)

      assert {:ok, _result} = UUID.info(booking.id)
    end

    test "when the booking wasn't found, returns an error" do
      assert {:error, _result} = BookingsAgent.get(UUID.uuid4())
    end
  end

  describe "list/0" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "return a list of bookings" do
      user = build(:user)

      booking = build(:booking, user_id: user.id)
      {:ok, _uuid} = BookingsAgent.save(booking)

      booking = build(:booking, user_id: user.id)
      {:ok, _uuid} = BookingsAgent.save(booking)

      booking = build(:booking, user_id: user.id)
      {:ok, _uuid} = BookingsAgent.save(booking)

      bookings = BookingsAgent.list_all()

      assert length(Map.keys(bookings)) == 3
    end
  end
end
