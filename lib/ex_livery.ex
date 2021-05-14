defmodule ExLivery do
  @moduledoc false
  alias ExLivery.Orders
  alias ExLivery.Users

  alias Orders.Agent, as: OrderAgent
  alias Orders.CreateOrUpdate, as: CreateOrUpdateOrder

  alias Users.Agent, as: UserAgent
  alias Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    UserAgent.start_link()
    OrderAgent.start_link()
  end

  @doc """
  Creates or updates the user.

  ## Examples

      iex> user_params = %{name: "Maiqui", email: "maiquitome@gmail.com", address: "Rua das Cerejeiras, 263", cpf: "123456789", age: 28}

      iex> ExLivery.Users.Agent.start_link

      iex> ExLivery.create_or_update_user(user_params)
      :ok

      iex> ExLivery.create_or_update_user(user_params)
      {:error, "Invalid age!"}

  """
  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call

  @doc """
  Creates or updates the order.

  ## Examples

    iex> {:ok, order_id} = ExLivery.create_or_update_order(%{user_cpf: "123456789", items: items})

  """
  defdelegate create_or_update_order(params), to: CreateOrUpdateOrder, as: :call
end
