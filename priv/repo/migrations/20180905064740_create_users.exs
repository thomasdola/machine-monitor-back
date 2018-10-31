defmodule MachineMonitor.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :root, :boolean
      add :password, :string
      add :uuid, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create index(:users, [:uuid])
  end
end
