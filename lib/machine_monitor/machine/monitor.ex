defmodule MachineMonitor.Machine.Monitor do
  use Ecto.Schema
  import Ecto.Changeset


  schema "monitors" do
    field :applications, {:array, :map}
    field :network, {:array, :map}, default: []
    field :services, {:array, :map}
    field :status, :integer
    field :machine_id, :id

    belongs_to :machine, MachineMonitor.Accounts.Machine, define_field: false

    timestamps()
  end

  @doc false
  def changeset(monitor, attrs) do
    monitor
    |> cast(attrs, [:status, :network, :applications, :services, :machine_id])
    |> validate_required([:status, :applications, :services, :machine_id])
  end
end
