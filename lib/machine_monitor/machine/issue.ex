defmodule MachineMonitor.Machine.Issue do
  use Ecto.Schema
  import Ecto.Changeset


  schema "issues" do
    field :description, :string
    field :observation, :string
    field :occurred_on, :naive_datetime
    field :reported_on, :naive_datetime
    field :resolved, :boolean
    field :resolved_on, :naive_datetime
    field :reported_to, :string
    field :machine_id, :id

    belongs_to :machine, MachineMonitor.Accounts.Machine, define_field: false

    timestamps()
  end

  @doc false
  def changeset(issue, attrs) do
    issue
    |> cast(attrs, [:occurred_on, :reported_on, :description, :resolved, :resolved_on, :resolved, :observation, :reported_to, :machine_id])
    |> validate_required([:occurred_on, :reported_on, :description, :resolved, :resolved_on, :resolved, :observation, :reported_to, :machine_id])
  end
end
