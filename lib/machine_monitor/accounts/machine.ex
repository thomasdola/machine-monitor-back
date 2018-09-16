defmodule MachineMonitor.Accounts.Machine do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt
  alias Comeonin.Pbkdf2

  schema "machines" do
    field :name, :string
    field :password, :string
    field :uuid, :string

    has_one :monitor, MachineMonitor.Machine.Monitor

    timestamps()
  end

  @doc false
  def changeset(machine, attrs) do
    machine
    |> cast(attrs, [:name, :password, :uuid])
    |> put_uuid()
    |> validate_required([:name, :password, :uuid])
    |> put_password_hash()
    |> unique_constraint(:name)
  end

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
