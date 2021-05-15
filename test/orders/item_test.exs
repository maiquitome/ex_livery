defmodule ExLivery.Orders.ItemTest do
  @moduledoc false

  use ExUnit.Case

  alias ExLivery.Orders.Item

  import ExLivery.Factory

  describe "build/4" do
    test "when all params are valid, returns an item" do
      response = Item.build("Pizza de peperoni", :pizza, "35.5", 1)

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when there is an invalid category, returns an error" do
      response = Item.build("Pizza de peperoni", :banana, "35.5", 1)

      expected_response =
        {:error,
         "Category must be one of these: :pizza :hamburguer :carne :prato_feito :japonesa :sobremesa"}

      assert response == expected_response
    end

    test "when there is an invalid price, returns an error" do
      response = Item.build("Pizza de peperoni", :pizza, "price", 1)

      expected_response = {:error, "invalid price!"}

      assert response == expected_response
    end

    test "when there is an invalid quantity, returns an error" do
      response = Item.build("Pizza de peperoni", :pizza, "35.5", 0)

      expected_response = {:error, "Quantity must have a value greater than 0!"}

      assert response == expected_response
    end
  end
end
