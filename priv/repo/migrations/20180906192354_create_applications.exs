defmodule MachineMonitor.Repo.Migrations.CreateApplications do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :name, :string
      add :path, :string
      add :display, :string

      timestamps()
    end

  end
end
