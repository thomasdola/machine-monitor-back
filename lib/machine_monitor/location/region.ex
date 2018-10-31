defmodule MachineMonitor.Location.Region do
  use Ecto.Schema
  import Ecto.Changeset


  schema "regions" do
    field :code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(region, attrs) do
    region
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
  end
end
