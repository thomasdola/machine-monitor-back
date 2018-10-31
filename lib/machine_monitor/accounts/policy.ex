defmodule MachineMonitor.Accounts.Policy do
  use Ecto.Schema
  import Ecto.Changeset


  schema "policies" do
    field :description, :string
    field :name, :string

    many_to_many :actions, MachineMonitor.Accounts.Action, join_through: "policy_actions"
    many_to_many :roles, MachineMonitor.Accounts.Role, join_through: "policy_roles"

    timestamps()
  end

  @doc false
  def changeset(policy, attrs) do
    policy
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
