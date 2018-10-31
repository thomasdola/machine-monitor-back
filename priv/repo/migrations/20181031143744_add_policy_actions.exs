defmodule MachineMonitor.Repo.Migrations.AddPolicyActions do
  use Ecto.Migration

  def change do
    create table(:policy_actions, primary_key: false) do
      add :policy_id, references(:policies)
      add :action_id, references(:actions)
    end
  end
end
