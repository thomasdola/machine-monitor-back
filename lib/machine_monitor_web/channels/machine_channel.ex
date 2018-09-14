defmodule MachineMonitorWeb.MachineChannel do
  use MachineMonitorWeb, :channel
  use Phoenix.Channel, log_join: :info, log_handle_in: :info, log_hand_info: :info, log_handle_out: :info

  alias MachineMonitor.Accounts.{Machine, User}
  alias MachineMonitor.Accounts
  alias MachineMonitor.Machine, as: MachineInformation

  alias MachineMonitorWeb.Serializers.{MachineList, MachineSerializer}

  def join("MACHINE:" <> machine_uuid, params, socket) do
    case MachineMonitorWeb.UserSocket.connect(params, socket) do
      {:ok, socket} ->
        %Machine{} = machine = Guardian.Phoenix.Socket.current_resource(socket)
        send(self, {:after_join, machine})
        {:ok, socket}
      _ -> {:error, :unauthenticated}
    end
  end

  def terminate(reason, socket) do
    IO.inspect {:left, reason}
    %Machine{} = machine = Guardian.Phoenix.Socket.current_resource(socket)
    MachineInformation.update_machine_monitor(machine, %{status: 0})
    machines = Accounts.list_machines() |> MachineList.to_map()
    broadcast(socket, "MACHINES_UPDATED", %{machines: machines})

    :ok
  end

  def handle_in("USER_ACTIVITY_CHANGED" = event, report, socket) do
    #    persist data in db
    MachineMonitor.Machine.create_log(report)
    logs = MachineMonitor.Machine.list_logs() |> Enum.map(fn log -> Map.from_struct(log) end)
    #    broadcast event
    broadcast(socket, event, %{logs: logs})
    {:noreply, socket}
  end

  def handle_in("APPLICATION_STATUS_CHANGED" = event, %{"name" => a_name} = report, socket) do
    #    persist data in db
    %Machine{monitor: %{applications: applications}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])
      applications = Enum.reject(applications, fn %{"name" => name} -> name == a_name end)
      applications = [report | applications]

#    {:ok, _} = MachineMonitor.Machine.update_machine_monitor(machine, %{applications: applications})

    #    broadcast event
    broadcast(socket, event, %{application: report})

    {:noreply, socket}
  end

  def handle_in("SERVICE_STATUS_CHANGED" = event, %{"name" => s_name} = report, socket) do
    #    persist data in db
    %Machine{monitor: %{services: services}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])
    services = Enum.reject(services, fn %{"name" => name} -> name == s_name end)
    services = [report | services]

#    {:ok, _} = MachineMonitor.Machine.update_machine_monitor(machine, %{services: services})

    #    broadcast event
    broadcast(socket, event, %{application: report})
    {:noreply, socket}
  end

  def handle_in("NETWORK_STATUS_CHANGED" = event, report, socket) do
    %Machine{monitor: %{network: network}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])
    #    persist data in db
#    {:ok, _} = MachineMonitor.Machine.update_machine_monitor(machine, %{netwok: network})

    #    broadcast event
    broadcast(socket, event, %{network: report})

    {:noreply, socket}
  end

  def handle_in("LOCATION_STATUS_CHANGED" = event, report, socket) do
    %Machine{monitor: %{network: network}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])

    #    persist data in db
    {:ok, _} = MachineMonitor.Machine.create_location(report)

    #    broadcast event
    broadcast(socket, event, %{location: report})

    {:noreply, socket}
  end

  def handle_in("CHANGE_PASSWORD_DONE" = event, report, socket) do
    %Machine{monitor: %{network: network}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])
    #    broadcast event
    broadcast(socket, event, report)

    {:noreply, socket}
  end

  def handle_info({:after_join, %Machine{} = machine}, socket) do
    MachineInformation.update_machine_monitor(machine, %{status: 1})
    machines = Accounts.list_machines() |> MachineList.to_map()
    broadcast(socket, "MACHINES_UPDATED", %{machines: machines})

    {:noreply, socket}
  end

  def handle_info({:after_leave, %Machine{} = machine}, socket) do
    MachineInformation.update_machine_monitor(machine, %{status: 0})
    machines = Accounts.list_machines() |> MachineList.to_map()
    broadcast(socket, "MACHINES_UPDATED", %{machines: machines})

    {:noreply, socket}
  end

  defp broadcast_updated_machines_event() do
    machines =
      Accounts.list_machines()
      |> Enum.map(fn %{uuid: uuid, name: name, monitor: %{status: status}} ->
        %{uuid: uuid, name: name, status: status}
      end)

    Accounts.list_users() |> Stream.each(fn %{uuid: uuid} ->
      topic = "USER:"<>uuid
      MachineMonitorWeb.Endpoint.broadcast! topic, "MACHINES_UPDATED", %{machines: machines}
    end)
  end
end