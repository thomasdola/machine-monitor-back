defmodule MachineMonitor.Repo.Migrations.CreatePolicies do
  use Ecto.Migration

  def change do
    create table(:policies) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
