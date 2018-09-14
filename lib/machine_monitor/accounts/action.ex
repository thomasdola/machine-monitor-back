defmodule MachineMonitor.Accounts.Action do
  use Ecto.Schema
  import Ecto.Changeset

  @actions [CREATE, EDIT, DELETE, EXPORT, GENERATE, STOP, SHUTDOWN, RESTART, START, CHANGE]

  schema "actions" do
    field :name, :string
    field :entity_id, :id

    timestamps()
  end

  @doc false
  def changeset(action, attrs) do
    action
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
