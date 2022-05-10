defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UsersAgent
  alias Flightex.Users.User

  def call(%{
        name: name,
        email: email,
        cpf: cpf
      }) do
    name
    |> User.build(email, cpf)
    |> get_user()
    |> UsersAgent.save()
  end

  defp get_user({:ok, user}), do: user
end
