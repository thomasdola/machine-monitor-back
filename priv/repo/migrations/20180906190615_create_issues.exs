defmodule MachineMonitor.Repo.Migrations.CreateIssues do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :occurred_on, :naive_datetime
      add :reported_on, :naive_datetime
      add :description, :string
      add :resolved, :boolean
      add :resolved_on, :naive_datetime
      add :resolved_by, :string
      add :observation, :string
      add :reported_to, :string
      add :machine_id, references(:machines, on_delete: :delete_all)

      timestamps()
    end

    create index(:issues, [:machine_id])
  end
end
