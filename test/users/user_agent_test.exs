defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent

  describe "save/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when the user is saved, returns an UUID" do
      {:ok, user_id} =
        :user
        |> build()
        |> UserAgent.save()

      assert {:ok, _result} = UUID.info(user_id)
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

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

  describe "list/0" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "returns list of users" do
      :user
      |> build()
      |> UserAgent.save()

      :user
      |> build()
      |> UserAgent.save()

      :user
      |> build()
      |> UserAgent.save()

      users_list = UserAgent.list_all()

      assert length(Map.keys(users_list)) == 3
    end

    test "when the user isn't found, returns an error" do
      assert {:error, _reason} = UserAgent.get(UUID.uuid4())
    end
  end
end
