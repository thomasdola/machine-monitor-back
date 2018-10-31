defmodule MachineMonitor.Repo.Migrations.CreateNetworks do
  use Ecto.Migration

  def change do
    create table(:networks) do
      add :operator, :string
      add :type, :string

      timestamps()
    end

  end
end
