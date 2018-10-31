defmodule MachineMonitor.Location.District do
  use Ecto.Schema
  import Ecto.Changeset


  schema "district" do
    field :code, :string
    field :name, :string
    field :region_id, :id

    timestamps()
  end

  @doc false
  def changeset(district, attrs) do
    district
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
  end
end
