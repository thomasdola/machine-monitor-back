defmodule MachineMonitor.Repo.Migrations.CreateMonitors do
  use Ecto.Migration

  def change do
    create table(:monitors) do
      add :status, :integer
      add :network, {:array, :map}
      add :applications, {:array, :map}
      add :services, {:array, :map}
      add :machine_id, references(:machines, on_delete: :nothing)

      timestamps()
    end

    create index(:monitors, [:machine_id])
  end
end
