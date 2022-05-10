defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Users.Agent, as: UsersAgent
  alias Flightex.Bookings.CreateOrUpdate, as: BookingCreateUpdate
  alias Flightex.Users.CreateOrUpdate, as: UserCreateUpdate

  def start_agents do
    BookingsAgent.start_link(%{})
    UsersAgent.start_link(%{})
  end

  def create_or_update_booking(params), do: BookingCreateUpdate.call(params)

  def create_or_update_user(params), do: UserCreateUpdate.call(params)
end
