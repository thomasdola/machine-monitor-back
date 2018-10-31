defmodule MachineMonitor.Consumables.Laminate do
  use Ecto.Schema
  import Ecto.Changeset


  schema "laminates" do
    field :amount, :integer
    field :date, :utc_datetime
    field :stock_after_transaction, :integer
    field :stock_before_transaction, :integer
    field :transaction_type, :integer

    timestamps()
  end

  @doc false
  def changeset(laminate, attrs) do
    laminate
    |> cast(attrs, [:date, :transaction_type, :amount, :stock_before_transaction, :stock_after_transaction])
    |> validate_required([:date, :transaction_type, :amount, :stock_before_transaction, :stock_after_transaction])
  end
end
