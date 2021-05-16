defmodule ExLivery.Orders.Report do
  @moduledoc false

  alias ExLivery.Orders.Agent, as: OrdersAgent
  alias ExLivery.Orders.{Item, Order}

  def create_report(file_name \\ "report.csv") do
    order_list = build_order_list()

    File.write(file_name, order_list)
  end

  defp build_order_list do
    OrdersAgent.list_all()
    |> Map.values()
    |> Enum.map(fn order -> order_to_string(order) end)
  end

  defp order_to_string(%Order{
         user_cpf: cpf,
         total_price: total_price,
         items: items
       }) do
    items_string = Enum.map(items, fn item_map -> item_to_string(item_map) end)

    "#{cpf},#{items_string},#{total_price}\n"
  end

  defp item_to_string(%Item{
         category: category,
         quantity: quantity,
         unity_price: unity_price
       }) do
    "#{category},#{quantity},#{unity_price}"
  end
end
