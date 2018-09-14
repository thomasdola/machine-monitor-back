defmodule MachineMonitor.Repo.Migrations.CreateActions do
  use Ecto.Migration

  def change do
    create table(:actions) do
      add :name, :string
      add :entity_id, references(:entities, on_delete: :nothing)

      timestamps()
    end

    create index(:actions, [:entity_id])
  end
end
