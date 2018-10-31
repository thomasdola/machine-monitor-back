defmodule MachineMonitor.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :timestamp, :integer
      add :longitude, :float
      add :latitude, :float
      add :out_of_zone, :boolean
      add :machine_id, references(:machines, on_delete: :nothing)

      timestamps()
    end

    create index(:locations, [:machine_id])
  end
end
