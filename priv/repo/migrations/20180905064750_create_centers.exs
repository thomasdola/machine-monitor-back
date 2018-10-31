defmodule MachineMonitor.Repo.Migrations.CreateCenters do
  use Ecto.Migration

  def change do
    create table(:centers) do
      add :code, :string
      add :name, :string
      add :status, :integer

      add :location, {:map, {:map, :string}}
      add :contact, {:map, {:map, :string}}
      add :recomendation, {:map, {:map, :string}}

      timestamps()
    end

    create index(:centers, [:name])
    create index(:centers, [:code])
  end
end
