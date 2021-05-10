defmodule ExLivery.Users.User do
  @moduledoc false

  @keys [:name, :email, :cpf, :age]

  @enforce_keys @keys

  defstruct @keys

  @spec build(String, String, String, Integer) ::
          {:error, String}
          | {:ok, %ExLivery.Users.User{age: Integer, cpf: String, email: String, name: String}}
  @doc """
  Builds the user struct.

  ## Examples

      iex> ExLivery.Users.User.build("Maiqui", "maiquitome@gmail.com", "123456677", 18)
      {:ok,
      %ExLivery.Users.User{
        age: 18,
        cpf: "123456677",
        email: "maiquitome@gmail.com",
        name: "Maiqui"
      }}

  """

  def build(name, _email, _cpf, _age) when not is_bitstring(name), do: {:error, "Invalid name!"}
  def build(_name, email, _cpf, _age) when not is_bitstring(email), do: {:error, "Invalid email!"}
  def build(_name, _email, cpf, _age) when not is_bitstring(cpf), do: {:error, "Invalid cpf!"}
  def build(_name, _email, _cpf, age) when age <= 17, do: {:error, "Invalid age!"}

  def build(name_value, email_value, cpf_value, age_value) do
    {:ok,
     %__MODULE__{
       name: name_value,
       email: email_value,
       cpf: cpf_value,
       age: age_value
     }}
  end

  def build(_, _, _), do: {:error, "Inform all fields: name, email, cpf and age."}

  def build(_, _), do: {:error, "Inform all fields: name, email, cpf and age."}

  def build(_), do: {:error, "Inform all fields: name, email, cpf and age."}

  def build, do: {:error, "Inform all fields: name, email, cpf and age."}
end
