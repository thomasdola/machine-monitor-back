defmodule MachineMonitor.Repo.Migrations.CreateDeployedMachines do
  use Ecto.Migration

  def change do
    create table(:deployed_machines, primary_key: false) do
      add :deployment_id, references(:deployments)
      add :machine_id, references(:machines)
    end
  end
end
