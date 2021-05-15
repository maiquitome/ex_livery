defmodule ExLivery.Orders.CreateOrUpdateTest do
  @moduledoc false
  use ExUnit.Case
  doctest ExLivery.Orders.CreateOrUpdate

  import ExLivery.Factory

  alias ExLivery.Orders.Agent, as: OrdersAgent
  alias ExLivery.Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias ExLivery.Users.Agent, as: UsersAgent

  describe "call/1" do
    setup do
      ExLivery.start_agents()

      cpf = "123.456.789-10"
      user = build(:user, cpf: cpf)
      UsersAgent.save(user)

      item1 = %{
        description: "Pizza de peperoni",
        category: :pizza,
        quantity: 1,
        unity_price: Decimal.new("35.5")
      }

      item2 = %{
        description: "Sorvete",
        category: :sobremesa,
        quantity: 2,
        unity_price: Decimal.new("10.5")
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      assert {:ok, _uuid} = CreateOrUpdateOrder.call(params)
    end

    test "when there is no user with the given cpf, returns an error", %{
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: "000.000.000-00", items: [item1, item2]}

      response = CreateOrUpdateOrder.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "when something item is invalid, returns an error", %{
      user_cpf: cpf,
      item1: item1
    } do
      item1 = %{item1 | quantity: 0}

      params = %{user_cpf: cpf, items: [item1]}

      response = CreateOrUpdateOrder.call(params)

      expected_response = {:error, "Invalid items!"}

      assert response == expected_response
    end

    test "when there are no items, returns an error", %{user_cpf: cpf} do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdateOrder.call(params)

      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end
  end
end
