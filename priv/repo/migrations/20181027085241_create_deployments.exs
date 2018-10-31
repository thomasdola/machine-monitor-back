defmodule MachineMonitor.Repo.Migrations.CreateDeployments do
  use Ecto.Migration

  def change do
    create table(:deployments) do
      add :start_date, :utc_datetime
      add :end_date, :utc_datetime
      add :status, :integer
      add :center_id, references(:centers, on_delete: :delete_all)

      timestamps()
    end

    create index(:deployments, [:center_id])
  end
end
