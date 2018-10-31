defmodule MachineMonitor.Machine.Location do
  use Ecto.Schema
  import Ecto.Changeset


  schema "locations" do
    field :latitude, :float
    field :longitude, :float
    field :timestamp, :integer
    field :machine_id, :id

    field :out_of_zone, :boolean, default: false

    belongs_to :machine, MachineMonitor.Accounts.Machine, define_field: false

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:timestamp, :longitude, :latitude, :machine_id, :out_of_zone])
    |> validate_required([:timestamp, :longitude, :latitude, :machine_id])
  end
end
