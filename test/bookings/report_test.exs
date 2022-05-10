defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: true

  alias Flightex.Bookings.Report

  describe "generate/1" do
    test "when called, return the content" do
      Flightex.start_agents()

      user = %{
        name: "User",
        email: "user@mail.com",
        cpf: "usercpf"
      }

      {:ok, user_id} = Flightex.create_or_update_user(user)

      complete_date = NaiveDateTime.local_now()

      params = %{
        complete_date: complete_date,
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: user_id
      }

      content = "#{user_id},Brasilia,Bananeiras,#{NaiveDateTime.to_string(complete_date)}"

      Flightex.create_or_update_booking(params)
      Report.generate("report-test.csv")
      {:ok, file} = File.read("report-test.csv")

      assert file =~ content
    end
  end
end
