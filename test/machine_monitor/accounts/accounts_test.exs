defmodule MachineMonitor.AccountsTest do
  use MachineMonitor.DataCase

  alias MachineMonitor.Accounts

  describe "users" do
    alias MachineMonitor.Accounts.User

    @valid_attrs %{email: "some email", name: "some name", password: "some password"}
    @update_attrs %{email: "some updated email", name: "some updated name", password: "some updated password"}
    @invalid_attrs %{email: nil, name: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
#      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
#      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "machines" do
    alias MachineMonitor.Accounts.Machine

    @valid_attrs %{name: "some name", password: "some password"}
    @update_attrs %{name: "some updated name", password: "some updated password"}
    @invalid_attrs %{name: nil, password: nil}

    def machine_fixture(attrs \\ %{}) do
      {:ok, machine} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_machine()

      machine
    end

    test "list_machines/0 returns all machines" do
      machine_fixture()
      assert Accounts.list_machines() |> Enum.count() == 1
    end

    test "get_machine!/1 returns the machine with given id" do
      machine = machine_fixture()
      assert Accounts.get_machine!(machine.id) == machine
    end

    test "create_machine/1 with valid data creates a machine" do
      assert {:ok, %Machine{} = machine} = Accounts.create_machine(@valid_attrs)
      assert machine.name == "some name"
#      assert machine.password == "some password"
    end

    test "create_machine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_machine(@invalid_attrs)
    end

    test "update_machine/2 with valid data updates the machine" do
      machine = machine_fixture()
      assert {:ok, updated_machine} = Accounts.update_machine(machine, @update_attrs)
      assert %Machine{} = machine
      assert updated_machine.name == "some updated name"
      assert updated_machine.uuid == machine.uuid
    end

    test "update_machine/2 with invalid data returns error changeset" do
      machine = machine_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_machine(machine, @invalid_attrs)
      assert machine == Accounts.get_machine!(machine.id)
    end

    test "delete_machine/1 deletes the machine" do
      machine = machine_fixture()
      assert {:ok, %Machine{}} = Accounts.delete_machine(machine)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_machine!(machine.id) end
    end

    test "change_machine/1 returns a machine changeset" do
      machine = machine_fixture()
      assert %Ecto.Changeset{} = Accounts.change_machine(machine)
    end
  end

  describe "roles" do
    alias MachineMonitor.Accounts.Role

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Accounts.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Accounts.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Accounts.create_role(@valid_attrs)
      assert role.description == "some description"
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, role} = Accounts.update_role(role, @update_attrs)
      assert %Role{} = role
      assert role.description == "some updated description"
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_role(role, @invalid_attrs)
      assert role == Accounts.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Accounts.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Accounts.change_role(role)
    end
  end

  describe "gates" do
    alias MachineMonitor.Accounts.Gate

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def gate_fixture(attrs \\ %{}) do
      {:ok, gate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_gate()

      gate
    end

    test "list_gates/0 returns all gates" do
      gate = gate_fixture()
      assert Accounts.list_gates() == [gate]
    end

    test "get_gate!/1 returns the gate with given id" do
      gate = gate_fixture()
      assert Accounts.get_gate!(gate.id) == gate
    end

    test "create_gate/1 with valid data creates a gate" do
      assert {:ok, %Gate{} = gate} = Accounts.create_gate(@valid_attrs)
      assert gate.name == "some name"
    end

    test "create_gate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_gate(@invalid_attrs)
    end

    test "update_gate/2 with valid data updates the gate" do
      gate = gate_fixture()
      assert {:ok, gate} = Accounts.update_gate(gate, @update_attrs)
      assert %Gate{} = gate
      assert gate.name == "some updated name"
    end

    test "update_gate/2 with invalid data returns error changeset" do
      gate = gate_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_gate(gate, @invalid_attrs)
      assert gate == Accounts.get_gate!(gate.id)
    end

    test "delete_gate/1 deletes the gate" do
      gate = gate_fixture()
      assert {:ok, %Gate{}} = Accounts.delete_gate(gate)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_gate!(gate.id) end
    end

    test "change_gate/1 returns a gate changeset" do
      gate = gate_fixture()
      assert %Ecto.Changeset{} = Accounts.change_gate(gate)
    end
  end

  describe "entities" do
    alias MachineMonitor.Accounts.Entity

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def entity_fixture(attrs \\ %{}) do
      {:ok, entity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_entity()

      entity
    end

    test "list_entities/0 returns all entities" do
      entity = entity_fixture()
      assert Accounts.list_entities() == [entity]
    end

    test "get_entity!/1 returns the entity with given id" do
      entity = entity_fixture()
      assert Accounts.get_entity!(entity.id) == entity
    end

    test "create_entity/1 with valid data creates a entity" do
      assert {:ok, %Entity{} = entity} = Accounts.create_entity(@valid_attrs)
      assert entity.name == "some name"
    end

    test "create_entity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_entity(@invalid_attrs)
    end

    test "update_entity/2 with valid data updates the entity" do
      entity = entity_fixture()
      assert {:ok, entity} = Accounts.update_entity(entity, @update_attrs)
      assert %Entity{} = entity
      assert entity.name == "some updated name"
    end

    test "update_entity/2 with invalid data returns error changeset" do
      entity = entity_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_entity(entity, @invalid_attrs)
      assert entity == Accounts.get_entity!(entity.id)
    end

    test "delete_entity/1 deletes the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{}} = Accounts.delete_entity(entity)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_entity!(entity.id) end
    end

    test "change_entity/1 returns a entity changeset" do
      entity = entity_fixture()
      assert %Ecto.Changeset{} = Accounts.change_entity(entity)
    end
  end

  describe "actions" do
    alias MachineMonitor.Accounts.Action

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def action_fixture(attrs \\ %{}) do
      {:ok, action} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_action()

      action
    end

    test "list_actions/0 returns all actions" do
      action = action_fixture()
      assert Accounts.list_actions() == [action]
    end

    test "get_action!/1 returns the action with given id" do
      action = action_fixture()
      assert Accounts.get_action!(action.id) == action
    end

    test "create_action/1 with valid data creates a action" do
      assert {:ok, %Action{} = action} = Accounts.create_action(@valid_attrs)
      assert action.name == "some name"
    end

    test "create_action/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_action(@invalid_attrs)
    end

    test "update_action/2 with valid data updates the action" do
      action = action_fixture()
      assert {:ok, action} = Accounts.update_action(action, @update_attrs)
      assert %Action{} = action
      assert action.name == "some updated name"
    end

    test "update_action/2 with invalid data returns error changeset" do
      action = action_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_action(action, @invalid_attrs)
      assert action == Accounts.get_action!(action.id)
    end

    test "delete_action/1 deletes the action" do
      action = action_fixture()
      assert {:ok, %Action{}} = Accounts.delete_action(action)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_action!(action.id) end
    end

    test "change_action/1 returns a action changeset" do
      action = action_fixture()
      assert %Ecto.Changeset{} = Accounts.change_action(action)
    end
  end

  describe "policies" do
    alias MachineMonitor.Accounts.Policy

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def policy_fixture(attrs \\ %{}) do
      {:ok, policy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_policy()

      policy
    end

    test "list_policies/0 returns all policies" do
      policy = policy_fixture()
      assert Accounts.list_policies() == [policy]
    end

    test "get_policy!/1 returns the policy with given id" do
      policy = policy_fixture()
      assert Accounts.get_policy!(policy.id) == policy
    end

    test "create_policy/1 with valid data creates a policy" do
      assert {:ok, %Policy{} = policy} = Accounts.create_policy(@valid_attrs)
      assert policy.description == "some description"
      assert policy.name == "some name"
    end

    test "create_policy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_policy(@invalid_attrs)
    end

    test "update_policy/2 with valid data updates the policy" do
      policy = policy_fixture()
      assert {:ok, policy} = Accounts.update_policy(policy, @update_attrs)
      assert %Policy{} = policy
      assert policy.description == "some updated description"
      assert policy.name == "some updated name"
    end

    test "update_policy/2 with invalid data returns error changeset" do
      policy = policy_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_policy(policy, @invalid_attrs)
      assert policy == Accounts.get_policy!(policy.id)
    end

    test "delete_policy/1 deletes the policy" do
      policy = policy_fixture()
      assert {:ok, %Policy{}} = Accounts.delete_policy(policy)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_policy!(policy.id) end
    end

    test "change_policy/1 returns a policy changeset" do
      policy = policy_fixture()
      assert %Ecto.Changeset{} = Accounts.change_policy(policy)
    end
  end
end
