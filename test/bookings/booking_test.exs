defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.Booking

  describe "build/4" do
    test "when all params are valid, returns a booking" do
      complete_date = NaiveDateTime.local_now()

      {:ok, response} =
        Booking.build(
          complete_date,
          "Brasilia",
          "ilha das bananas",
          "12345678900"
        )

      expected_response = %Flightex.Bookings.Booking{
        complete_date: complete_date,
        id: response.id,
        local_destination: "ilha das bananas",
        local_origin: "Brasilia",
        user_id: "12345678900"
      }

      assert response == expected_response
    end

    test "when complete_date is not NaiveDateTime" do
      complete_date = "10/05/2022"

      assert {:error, _reason} =
               Booking.build(
                 complete_date,
                 "Brasilia",
                 "ilha das bananas",
                 "12345678900"
               )
    end
  end
end
