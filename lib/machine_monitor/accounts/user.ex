defmodule MachineMonitor.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt
  alias Comeonin.Pbkdf2

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :uuid, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :uuid])
    |> put_uuid()
    |> validate_required([:name, :email, :password, :uuid])
    |> put_password_hash()
    |> unique_constraint(:email)
  end

  defp hasher() do
    case :os.type() do
      {:unix, :linux} -> Bcrypt
      _ -> Pbkdf2
    end
  end

  defp put_uuid(%Ecto.Changeset{data: %{uuid: nil}} = changeset) do
    change(changeset, uuid: Nanoid.generate(64))
  end
  defp put_uuid(changeset), do: changeset

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: hasher.hashpwsalt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
