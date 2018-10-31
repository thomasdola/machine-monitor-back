defmodule MachineMonitor.Repo.Migrations.CreatePrinters do
  use Ecto.Migration

  def change do
    create table(:printers) do
      add :serial, :string
      add :laminator, :string

      timestamps()
    end

  end
end
