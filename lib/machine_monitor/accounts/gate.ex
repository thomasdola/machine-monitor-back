defmodule MachineMonitor.Accounts.Gate do
  use Ecto.Schema
  import Ecto.Changeset

  @gates [USERS, LOGS, REPORTS, MACHINES, ROLES]

  schema "gates" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(gate, attrs) do
    gate
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
