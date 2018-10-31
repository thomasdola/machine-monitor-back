defmodule MachineMonitor.Repo.Migrations.CreateRegions do
  use Ecto.Migration

  def change do
    create table(:regions) do
      add :name, :string
      add :code, :string

      timestamps()
    end

  end
end
