defmodule MachineMonitor.Settings.Service do
  use Ecto.Schema
  import Ecto.Changeset


  schema "services" do
    field :name, :string
    field :display, :string
    field :path, :string

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:name, :path, :display])
    |> validate_required([:name, :path, :display])
  end
end
