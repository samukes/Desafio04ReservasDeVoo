defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory(params) do
    User.build(
      "Jp",
      "jp@banana.com",
      "12345678900"
    )
    |> get_map()
    |> Map.merge(params)
  end

  def booking_factory(params) do
    Booking.build(
      NaiveDateTime.local_now(),
      "Brasilia",
      "Bananeiras",
      ""
    )
    |> get_map()
    |> Map.merge(params)
  end

  defp get_map({:ok, map}), do: map
end
