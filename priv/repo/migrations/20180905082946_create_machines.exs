defmodule MachineMonitor.Repo.Migrations.CreateMachines do
  use Ecto.Migration

  def change do
    create table(:machines) do
      add :name, :string
      add :password, :string
      add :uuid, :string

      timestamps()
    end

    create unique_index(:machines, [:name])
    create index(:machines, [:uuid])
  end
end
