defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case, async: false

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Users.Agent, as: UsersAgent
  alias Flightex.Bookings.CreateOrUpdate

  describe "call/1" do
    setup do
      BookingsAgent.start_link(%{})
      UsersAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, returns a valid tuple" do
      {:ok, user_id} =
        :user
        |> build()
        |> UsersAgent.save()

      params = %{
        complete_date: NaiveDateTime.local_now(),
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: user_id
      }

      assert {:ok, _uuid} = CreateOrUpdate.call(params)
    end

    test "when user does not exist, returns error" do
      params = %{
        complete_date: NaiveDateTime.local_now(),
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: UUID.uuid4()
      }

      assert {:error, _reason} = CreateOrUpdate.call(params)
    end
  end
end
