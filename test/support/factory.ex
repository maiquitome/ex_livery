defmodule ExLivery.Factory do
  use ExMachina

  alias ExLivery.Users.User
  alias ExLivery.Orders.{Item, Order}

  def user_factory do
    %User{
      name: "Maiqui",
      email: "maiquitome@gmail.com",
      cpf: "0123456789",
      age: 28,
      address: "Rua das Cerejeiras, 263"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de peperoni",
      category: :pizza,
      quantity: 1,
      unity_price: Decimal.new("35.5")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Rua das Cerejeiras, 263",
      items: [
        build(:item),
        build(:item,
          description: "Temaki de atum",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("20.50")
        )
      ],
      total_price: Decimal.new("76.50"),
      user_cpf: "0123456789"
    }
  end
end
