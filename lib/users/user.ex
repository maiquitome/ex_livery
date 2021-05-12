defmodule ExLivery.Users.User do
  @moduledoc false

  @message "Inform all fields: address, name, email, cpf and age."

  @keys [:address, :name, :email, :cpf, :age]

  @enforce_keys @keys

  defstruct @keys

  @spec build(String, String, String, String, Integer) ::
          {:error, String}
          | {:ok,
             %ExLivery.Users.User{
               address: String,
               age: Integer,
               cpf: String,
               email: String,
               name: String
             }}
  @doc """
  Builds the user struct.

  ## Examples

      iex> ExLivery.Users.User.build("Rua das Cerejeiras", "Maiqui", "maiquitome@gmail.com", "123456677", 18)
      {:ok,
      %ExLivery.Users.User{
        address: "Rua das Cerejeiras",
        age: 18,
        cpf: "123456677",
        email: "maiquitome@gmail.com",
        name: "Maiqui"
      }}

  """

  def build(_address, name, _email, _cpf, _age) when not is_bitstring(name) do
    {:error, "Invalid name!"}
  end

  def build(_address, _name, email, _cpf, _age) when not is_bitstring(email) do
    {:error, "Invalid email!"}
  end

  def build(_address, _name, _email, cpf, _age) when not is_bitstring(cpf) do
    {:error, "Invalid cpf!"}
  end

  def build(_address, _name, _email, _cpf, age) when age <= 17, do: {:error, "Invalid age!"}

  def build(address_value, name_value, email_value, cpf_value, age_value) do
    {:ok,
     %__MODULE__{
       address: address_value,
       name: name_value,
       email: email_value,
       cpf: cpf_value,
       age: age_value
     }}
  end

  def build(_, _, _, _), do: {:error, @message}

  def build(_, _, _), do: {:error, @message}

  def build(_, _), do: {:error, @message}

  def build(_), do: {:error, @message}

  def build, do: {:error, @message}
end
