defmodule MachineMonitor.Settings.Printer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "printers" do
    field :laminator, :string
    field :serial, :string

    timestamps()
  end

  @doc false
  def changeset(printer, attrs) do
    printer
    |> cast(attrs, [:serial, :laminator])
    |> validate_required([:serial, :laminator])
  end
end
