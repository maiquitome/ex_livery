defmodule ExLivery.Orders.Order do
  @moduledoc false

  alias ExLivery.Orders.Item
  alias ExLivery.Users.User

  @keys [:user_cpf, :delivery_address, :items, :total_price]

  @enforce_keys @keys

  defstruct @keys

  @doc """
  Builds the user order.

  ## Examples

      iex> {:ok, item1} = ExLivery.Orders.Item.build("pizza teste", :pizza, 50.00, 1)
      {:ok,
      %ExLivery.Orders.Item{
        category: :pizza,
        description: "pizza teste",
        quantity: 1,
        unity_price: #Decimal<50.0>
      }}

      iex> {:ok, item2} = ExLivery.Orders.Item.build("sorvete", :sobremesa, 50.00, 2)
      {:ok,
      %ExLivery.Orders.Item{
        category: :sobremesa,
        description: "sorvete",
        quantity: 2,
        unity_price: #Decimal<50.0>
      }}

      iex> items = [item1, item2]
      [
        %ExLivery.Orders.Item{
          category: :pizza,
          description: "pizza teste",
          quantity: 1,
          unity_price: #Decimal<50.0>
        },
        %ExLivery.Orders.Item{
          category: :sobremesa,
          description: "sorvete",
          quantity: 2,
          unity_price: #Decimal<50.0>
        }
      ]

      iex> {:ok, user} = ExLivery.Users.User.build("Rua das cerejeiras", "Maiqui", "maiquitome@gmail.com", "1234566", 28)
      {:ok,
      %ExLivery.Users.User{
        address: "Rua das cerejeiras",
        age: 28,
        cpf: "1234566",
        email: "maiquitome@gmail.com",
        name: "Maiqui"
      }}

      iex> ExLivery.Orders.Order.build(user, items)
      {:ok,
      %ExLivery.Orders.Order{
        delivery_address: "Rua das cerejeiras",
        items: [
          %ExLivery.Orders.Item{
            category: :pizza,
            description: "pizza teste",
            quantity: 1,
            unity_price: #Decimal<50.0>
          },
          %ExLivery.Orders.Item{
            category: :sobremesa,
            description: "sorvete",
            quantity: 2,
            unity_price: #Decimal<50.0>
          }
        ],
        total_price: #Decimal<150.00>,
        user_cpf: "1234566"
      }}

      iex> ExLivery.Orders.Order.build(user, [])
      {:error, "Invalid parameters!"}

      iex> ExLivery.Orders.Order.build("banana", items)
      {:error, "Invalid parameters!"}
  """
  def build(%User{address: address, cpf: cpf}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculates_total_price(items)
     }}
  end

  def build(_user, _items), do: {:error, "Invalid parameters!"}

  defp calculates_total_price(items) do
    acc_initial_value = Decimal.new("0.00")

    Enum.reduce(items, acc_initial_value, &sum_prices(&1, &2))
  end

  defp sum_prices(%Item{unity_price: price, quantity: quantity}, acc) do
    price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
