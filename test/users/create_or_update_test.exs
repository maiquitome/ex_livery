defmodule ExLivery.Users.CreateOrUpdateTest do
  @moduledoc false
  use ExUnit.Case
  doctest ExLivery.Users.CreateOrUpdate

  alias ExLivery.Users.Agent, as: UserAgent
  alias ExLivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link()

      params = %{
        name: "Maiqui",
        email: "maiquitome@gmail.com",
        cpf: "0123456789",
        age: 28,
        address: "Rua das Cerejeiras, 263"
      }

      {:ok, params: params}
    end

    test "when all params are valid, saves the user", %{params: params} do
      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User created or updated succesfully!"}

      assert response == expected_response
    end

    test "when the user is under age, returns an error", %{params: params} do
      response = CreateOrUpdate.call(%{params | age: 15})

      expected_response = {:error, "Invalid age!"}

      assert response == expected_response
    end
  end
end
