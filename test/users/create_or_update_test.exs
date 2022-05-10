defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case, async: true

  alias Flightex.Users.{Agent, CreateOrUpdate}

  describe "call/1" do
    setup do
      Agent.start_link(%{})

      :ok
    end

    test "when all params are valid, return a tuple" do
      params = %{
        name: "Jp",
        email: "jp@banana.com",
        cpf: "12345678900"
      }

      assert {:ok, _user_id} = CreateOrUpdate.call(params)
    end
  end
end
