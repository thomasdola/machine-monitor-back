defmodule MachineMonitor.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :name, :string
      add :gate_id, references(:gates, on_delete: :nothing)

      timestamps()
    end

    create index(:entities, [:gate_id])
  end
end
