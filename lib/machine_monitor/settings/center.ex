defmodule MachineMonitor.Settings.Center do
  use Ecto.Schema
  import Ecto.Changeset


  schema "centers" do
    field :code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(center, attrs) do
    center
    |> cast(attrs, [:code, :name])
    |> validate_required([:code, :name])
  end
end
