defmodule MachineMonitor.Repo.Migrations.CreateActions do
  use Ecto.Migration

  def change do
    create table(:actions) do
      add :name, :string

      timestamps()
    end
  end
end
