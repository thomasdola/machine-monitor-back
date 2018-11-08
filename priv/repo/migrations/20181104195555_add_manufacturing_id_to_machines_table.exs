defmodule MachineMonitor.Repo.Migrations.AddManufacturingIdToMachinesTable do
  use Ecto.Migration

  def change do
    alter table(:machines) do
      add :manufacturing_id, :string
    end

    create unique_index(:machines, [:manufacturing_id])
  end
end
