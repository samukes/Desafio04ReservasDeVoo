defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(filename \\ "report.csv") do
    booking_list = build_booking_list()

    case File.write(filename, booking_list) do
      :ok -> {:ok, "Report generated successfully"}
      {:error, reason} -> reason
    end
  end

  def build_booking_list do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  def booking_string(%Booking{
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id
      }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
