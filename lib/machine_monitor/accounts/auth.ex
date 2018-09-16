defmodule MachineMonitor.Accounts.Auth do

  import Ecto.Query, warn: false
  alias MachineMonitor.Repo

  alias MachineMonitor.Accounts.{User, Machine}
  alias Comeonin.Bcrypt
  alias Comeonin.Pbkdf2

  defp hasher() do
    case :os.type() do
      {:unix, :linux} -> Bcrypt
      _ -> Pbkdf2
    end
  end

  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email
    case Repo.one(query) do
      nil ->
        hasher.dummy_checkpw()
        {:error, :invalid_credentials}
      user ->
        if hasher.checkpw(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def authenticate_machine(name, plain_text_password) do
    query = from m in Machine, where: m.name == ^name
    case Repo.one(query) do
      nil ->
        hasher.dummy_checkpw()
        {:error, :invalid_credentials}
      machine ->
        if hasher.checkpw(plain_text_password, machine.password) do
          {:ok, machine}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end