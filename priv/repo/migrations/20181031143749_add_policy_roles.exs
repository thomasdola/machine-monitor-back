defmodule MachineMonitor.Repo.Migrations.AddPolicyRoles do
  use Ecto.Migration

  def change do
    create table(:policy_roles, primary_key: false) do
      add :policy_id, references(:policies)
      add :role_id, references(:roles)
    end
  end
end
