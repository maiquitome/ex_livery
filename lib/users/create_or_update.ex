defmodule ExLivery.Users.CreateOrUpdate do
  @moduledoc false

  alias ExLivery.Users
  alias Users.Agent, as: UserAgent
  alias Users.User

  def call(%{
        name: name,
        address: address,
        email: email,
        cpf: cpf,
        age: age
      }) do
    address
    |> User.build(name, email, cpf, age)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, "User created or updated succesfully!"}
  end

  defp save_user({:error, _reason} = error), do: error
end
