defmodule MachineMonitor.Repo.Migrations.CreateDistrict do
  use Ecto.Migration

  def change do
    create table(:district) do
      add :name, :string
      add :code, :string
      add :region_id, references(:regions, on_delete: :nothing)

      timestamps()
    end

    create index(:district, [:region_id])
  end
end
