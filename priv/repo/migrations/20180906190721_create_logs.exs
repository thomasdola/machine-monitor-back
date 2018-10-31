defmodule MachineMonitor.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :action, :string
      add :user, :string
      add :date, :naive_datetime
      add :machine_id, references(:machines, on_delete: :delete_all)

      timestamps()
    end

    create index(:logs, [:machine_id])
  end
end
