defmodule MachineMonitor.Repo.Migrations.CreateCenters do
  use Ecto.Migration

  def change do
    create table(:centers) do
      add :code, :string
      add :name, :string

      timestamps()
    end

    create index(:centers, [:name])
  end
end
