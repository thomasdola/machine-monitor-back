defmodule MachineMonitor.Settings.Application do
  use Ecto.Schema
  import Ecto.Changeset


  schema "applications" do
    field :name, :string
    field :display, :string
    field :path, :string

    timestamps()
  end

  @doc false
  def changeset(application, attrs) do
    application
    |> cast(attrs, [:name, :path, :display])
    |> validate_required([:name, :path, :display])
  end
end
