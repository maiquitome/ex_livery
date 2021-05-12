defmodule ExLivery.Orders.Item do
  @categories [
    :pizza,
    :hamburguer,
    :carne,
    :prato_feito,
    :japonesa,
    :sobremesa
  ]

  @keys [:description, :category, :unity_price, :quantity]

  defstruct @keys

  def build do
    {:error, "Informs all fiels: description, category, unity_price, quantity"}
  end

  def build(_description, category, _unity_price, _quantity) when category not in @categories do
    {:error, "Category must be one of these:#{getCategories()}"}
  end

  def build(_description, _category, _unity_price, quantity) when quantity <= 0 do
    {:error, "Quantity must have a value greater than 0!"}
  end

  def build(description, category, unity_price, quantity) do
    unity_price
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  defp build_item(:error, _description, _category, _quantity) do
    {:error, "invalid price!"}
  end

  defp build_item({:ok, unity_price}, description, category, quantity) do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unity_price: unity_price,
       quantity: quantity
     }}
  end

  defp getCategories(), do: Enum.map(@categories, &" :#{Atom.to_string(&1)}")
end
