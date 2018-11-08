defmodule MachineMonitor.Settings.Printer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "printers" do
    field :laminator, :string
    field :serial, :string

    many_to_many :deployments, MachineMonitor.Settings.Deployment, join_through: "deployed_printers"

    timestamps()
  end

  @doc false
  def changeset(printer, attrs) do
    printer
    |> cast(attrs, [:serial, :laminator])
    |> validate_required([:serial, :laminator])
  end
end
