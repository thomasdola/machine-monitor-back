defmodule MachineMonitor.Accounts.Entity do
  use Ecto.Schema
  import Ecto.Changeset

  @entities [MACHINE, USER, POLICY, ROLE, LOG, CENTER]

  schema "entities" do
    field :name, :string
    field :gate_id, :id

    many_to_many :actions, MachineMonitor.Accounts.Action, join_through: "entity_actions"

    timestamps()
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [:name, :gate_id])
    |> validate_required([:name, :gate_id])
  end
end
