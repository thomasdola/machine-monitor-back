defmodule MachineMonitor.Machine.Log do
  use Ecto.Schema
  import Ecto.Changeset


  schema "logs" do
    field :action, :string
    field :date, :naive_datetime
    field :user, :string
    field :machine_id, :id

    belongs_to :machine, MachineMonitor.Accounts.Machine, define_field: false

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:action, :user, :date, :machine_id])
    |> validate_required([:action, :user, :date, :machine_id])
  end
end
