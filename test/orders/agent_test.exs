defmodule ExLivery.Orders.AgentTest do
  @moduledoc false

  use ExUnit.Case
  doctest ExLivery.Orders.Agent

  import ExLivery.Factory

  alias ExLivery.Orders.Agent, as: OrderAgent

  describe "save/1" do
    test "saves the order" do
      order = build(:order)

      OrderAgent.start_link()

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link()

      :ok
    end

    test "when the order uuid is found, returns the order" do
      order = build(:order)

      {:ok, uuid} = OrderAgent.save(order)

      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert response == expected_response
    end

    test "when the order is not found, returns an error" do
      uuid = UUID.uuid4()

      response = OrderAgent.get(uuid)

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end
