defmodule Flightex.Users.Agent do
  alias Flightex.Users.User

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, &update_state(&1, user))

    {:ok, user.id}
  end

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  def list_all, do: Agent.get(__MODULE__, & &1)

  defp update_state(state, %User{} = user), do: Map.put(state, user.id, user)

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
