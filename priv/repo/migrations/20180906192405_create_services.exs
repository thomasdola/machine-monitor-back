defmodule MachineMonitor.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :display, :string
      add :path, :string

      timestamps()
    end

  end
end
