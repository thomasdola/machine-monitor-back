defmodule MachineMonitorWeb.MachineAuthController do
  use MachineMonitorWeb, :controller

  action_fallback MachineMonitorWeb.ActionFallbackController

  alias MachineMonitor.Accounts
  alias MachineMonitor.Settings
  alias MachineMonitor.Accounts.Machine
  alias MachineMonitor.Machine, as: MachineProfile

  alias MachineMonitorWeb.Serializers.{MachineList, MachineSerializer}

  alias MachineMonitorWeb.Auth.Guardian

  def login(conn, %{"name" => name, "password" => plain_password}) do
    with {:ok, %Machine{uuid: uuid} = machine} <- Accounts.Auth.authenticate_machine(name, plain_password) do
      {:ok, token, _} = Guardian.encode_and_sign(machine)

#      broadcast_updated_machines_event(uuid)

      render(conn, "login.json", token: token, uuid: uuid)
    end
  end

  def register(conn, %{"name" => name, "password" => plain_password} = params) do
    with {:ok, %Machine{uuid: uuid} = machine} <- Accounts.Auth.authenticate_machine(name, plain_password) do
      {:ok, token, _} = Guardian.encode_and_sign(machine)

#      broadcast_updated_machines_event(uuid)

      render(conn, "login.json", token: token, uuid: uuid)
    else
      {:error, :invalid_credentials} ->
        {:ok, %Machine{uuid: uuid, id: id} = machine} = Accounts.create_machine(params)

        applications =
          Settings.list_applications()
          |> Enum.map(fn a -> %{name: a.name, display: a.display, path: a.path, status: 0} end)

        services =
          Settings.list_services()
          |> Enum.map(fn s -> %{name: s.name, display: s.display, path: s.path, status: 0} end)

        {:ok, %{}} = MachineProfile.create_monitor(
          %{status: 1, machine_id: id, applications: applications, services: services}
        )

        {:ok, token, _} = Guardian.encode_and_sign(machine)

#        broadcast_updated_machines_event(uuid)

        render(conn, "login.json", token: token, uuid: uuid)
    end
  end

  def logout(conn, _) do
    %Machine{uuid: uuid} = Guardian.Plug.current_resource(conn)
    {:ok, _} = Guardian.Plug.current_token(conn) |> Guardian.revoke()

    broadcast_updated_machines_event(uuid)

    render(conn, "logout.json")
  end

  defp machine_channel(uuid), do: "MACHINE:#{uuid}"

  defp broadcast_updated_machines_event(machine_uuid) do
    machines = Accounts.list_machines() |> MachineList.to_map()
    MachineMonitorWeb.Endpoint.broadcast! "MACHINE:#{machine_uuid}", "MACHINES_UPDATED", %{machines: machines}
  end
end