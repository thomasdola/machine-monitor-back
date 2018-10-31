defmodule MachineMonitor.Settings.Network do
  use Ecto.Schema
  import Ecto.Changeset


  schema "networks" do
    field :operator, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(network, attrs) do
    network
    |> cast(attrs, [:operator, :type])
    |> validate_required([:operator, :type])
  end
end
