defmodule MachineMonitor.Repo.Migrations.AddEntityActions do
  use Ecto.Migration

  def change do
    create table(:entity_actions, primary_key: false) do
      add :entity_id, references(:entities)
      add :action_id, references(:actions)
    end
  end
end
