defmodule MachineMonitor.Accounts.Entity do
  use Ecto.Schema
  import Ecto.Changeset

  @entities [MACHINE, USER, POLICY, ROLE, LOG, CENTER]

  schema "entities" do
    field :name, :string
    field :gate_id, :id

    timestamps()
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
