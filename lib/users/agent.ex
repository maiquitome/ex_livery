defmodule ExLivery.Users.Agent do
  @moduledoc false

  use Agent

  alias ExLivery.Users.User

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, fn state -> update_state(state, user) end)
  end

  def get(cpf) do
    Agent.get(__MODULE__, fn state -> get_user(state, cpf) end)
  end

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{cpf: cpf} = user) do
    Map.put(state, cpf, user)
  end
end
