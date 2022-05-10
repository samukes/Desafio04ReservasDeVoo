defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent

  setup do
    UserAgent.start_link(%{})

    :ok
  end

  describe "save/1" do
    test "when the user is saved, returns an UUID" do
      {:ok, user_id} =
        :user
        |> build()
        |> UserAgent.save()

      assert {:ok, _result} = UUID.info(user_id)
    end
  end

  describe "get/1" do
    test "when the user is found, returns the user" do
      {:ok, user_id} =
        :user
        |> build()
        |> UserAgent.save()

      assert {:ok, _user} = UserAgent.get(user_id)
    end

    test "when the user isn't found, returns an error" do
      assert {:error, _reason} = UserAgent.get(UUID.uuid4())
    end
  end
end
