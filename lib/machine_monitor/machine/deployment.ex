defmodule MachineMonitor.Machine.Deployment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "deployments" do
    field :ended_on, :naive_datetime
    field :started_on, :naive_datetime
    field :center_id, :id
    field :machine_id, :id

    belongs_to :machine, MachineMonitor.Accounts.Machine, define_field: false

    timestamps()
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, [:started_on, :ended_on, :center_id, :machine_id])
    |> validate_required([:started_on, :ended_on, :center_id, :machine_id])
  end
end
