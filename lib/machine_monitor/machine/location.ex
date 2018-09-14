defmodule MachineMonitor.Machine.Location do
  use Ecto.Schema
  import Ecto.Changeset


  schema "locations" do
    field :latitude, :float
    field :longitude, :float
    field :timestamp, :integer
    field :machine_id, :id

    belongs_to :machine, MachineMonitor.Accounts.Machine, define_field: false

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:timestamp, :longitude, :latitude, :machine_id])
    |> validate_required([:timestamp, :longitude, :latitude, :machine_id])
  end
end
