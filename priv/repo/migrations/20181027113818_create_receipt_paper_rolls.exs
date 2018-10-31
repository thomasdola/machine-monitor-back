defmodule MachineMonitor.Repo.Migrations.CreateReceiptPaperRolls do
  use Ecto.Migration

  def change do
    create table(:receipt_paper_rolls) do
      add :date, :utc_datetime
      add :transaction_type, :integer
      add :amount, :integer
      add :stock_before_transaction, :integer
      add :stock_after_transaction, :integer

      timestamps()
    end

  end
end
