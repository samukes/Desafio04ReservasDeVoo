defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  import Flightex.Factory

  describe "build/3" do
    test "when all params are valid, returns the user" do
      assert {:ok, _user} =
               User.build(
                 "Jp",
                 "jp@banana.com",
                 "12345678900"
               )
    end
  end
end
