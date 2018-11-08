defmodule MachineMonitor.Settings.Deployment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "deployments" do
    field :end_date, :utc_datetime
    field :start_date, :utc_datetime
    field :status, :integer, default: 1

    belongs_to :center , MachineMonitor.Settings.Center

    many_to_many :printers, MachineMonitor.Settings.Printer, join_through: "deployed_printers"
    many_to_many :machines, MachineMonitor.Accounts.Machine, join_through: "deployed_machines"

    timestamps()
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, [:start_date, :end_date, :status, :center_id])
    |> validate_required([:start_date, :end_date, :status, :center_id])
  end
end
