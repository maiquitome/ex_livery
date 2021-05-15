defmodule ExLivery.Users.AgentTest do
  @moduledoc false

  use ExUnit.Case
  doctest ExLivery.Users.Agent

  import ExLivery.Factory

  alias ExLivery.Users.Agent, as: UserAgent

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link()
      response = UserAgent.save(user)

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link()

      cpf_value = "0111.0111.0111"

      {:ok, cpf: cpf_value}
    end

    test "when the user is found, it returns the user", %{cpf: user_cpf} do
      user = build(:user)

      user = %{user | cpf: user_cpf}

      UserAgent.save(user)

      response = UserAgent.get(user_cpf)

      expected_response = {:ok, user}

      assert response == expected_response
    end

    test "when the user isn't found, it returns an error" do
      response = UserAgent.get("000.000.000-00")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
