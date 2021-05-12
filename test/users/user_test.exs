defmodule ExLivery.Users.UserTest do
  use ExUnit.Case
  # doctest ExLivery.Users.User

  alias ExLivery.Users.User

  import ExLivery.Factory

  describe "build/5" do
    test "when all parameters are valid, returns the user" do
      response =
        User.build(
          "Rua das Cerejeiras, 263",
          "Maiqui",
          "maiquitome@gmail.com",
          "0123456789",
          28
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when the user is under age, returns an error" do
      response =
        User.build(
          "Rua das Cerejeiras",
          "Maiqui Jr",
          "maiquitome@gmail.com",
          "0912891892",
          15
        )

      expected_response = {:error, "Invalid age!"}

      assert response == expected_response
    end
  end
end
