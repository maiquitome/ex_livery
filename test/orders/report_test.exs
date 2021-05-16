defmodule ExLivery.Orders.ReportTest do
  @moduledoc false

  use ExUnit.Case

  import ExLivery.Factory

  alias ExLivery.Orders.Agent, as: OrdersAgent
  alias ExLivery.Orders.Report

  describe "create_report/1" do
    test "create the report file" do
      OrdersAgent.start_link()

      :order
      |> build()
      |> OrdersAgent.save()

      :order
      |> build()
      |> OrdersAgent.save()

      Report.create_report("report_test.csv")

      response = File.read!("report_test.csv")

      expected_response =
        "0123456789,pizza,1,35.5japonesa,2,20.50,76.50\n" <>
          "0123456789,pizza,1,35.5japonesa,2,20.50,76.50\n"

      assert response == expected_response
    end
  end
end
