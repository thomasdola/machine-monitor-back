defmodule MachineMonitor.Repo.Migrations.CreateDeployedPrinters do
  use Ecto.Migration

  def change do
    create table(:deployed_printers, primary_key: false) do
      add :deployment_id, references(:deployments)
      add :printer_id, references(:printers)
    end
  end
end
