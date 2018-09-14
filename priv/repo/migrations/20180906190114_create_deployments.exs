defmodule MachineMonitor.Repo.Migrations.CreateDeployments do
  use Ecto.Migration

  def change do
    create table(:deployments) do
      add :started_on, :naive_datetime
      add :ended_on, :naive_datetime
      add :center_id, references(:centers, on_delete: :nothing)
      add :machine_id, references(:machines, on_delete: :delete_all)

      timestamps()
    end

    create index(:deployments, [:center_id])
    create index(:deployments, [:machine_id])
  end
end
