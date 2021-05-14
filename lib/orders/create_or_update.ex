defmodule ExLivery.Orders.CreateOrUpdate do
  @moduledoc false

  alias ExLivery.Orders.Agent, as: OrderAgent
  alias ExLivery.Orders.Item
  alias ExLivery.Orders.Order
  alias ExLivery.Users.Agent, as: UserAgent

  def call(%{user_cpf: user_cpf, items: items}) do
    with {:ok, user} <- UserAgent.get(user_cpf),
         {:ok, items} <- build_items(items),
         {:ok, order} <- Order.build(user, items) do
      OrderAgent.save(order)
    else
      error -> error
    end
  end

  defp build_items(items) do
    items
    |> Enum.map(&build_item/1)
    |> handle_build()
  end

  defp build_item(%{
         description: description,
         category: category,
         unity_price: unity_price,
         quantity: quantity
       }) do
    case Item.build(description, category, unity_price, quantity) do
      {:ok, item} -> item
      {:error, _reason} = error -> error
    end
  end

  defp handle_build(items) do
    all_items_are_structs = Enum.all?(items, &is_struct/1)

    if all_items_are_structs do
      {:ok, items}
    else
      {:error, "Invalid items!"}
    end
  end
end
