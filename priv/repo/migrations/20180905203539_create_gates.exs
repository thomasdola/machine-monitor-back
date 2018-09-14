defmodule MachineMonitor.Repo.Migrations.CreateGates do
  use Ecto.Migration

  def change do
    create table(:gates) do
      add :name, :string

      timestamps()
    end

  end
end
