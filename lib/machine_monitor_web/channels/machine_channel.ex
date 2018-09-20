defmodule MachineMonitorWeb.MachineChannel do
  use MachineMonitorWeb, :channel
  use Phoenix.Channel, log_join: :info, log_handle_in: :info, log_hand_info: :info, log_handle_out: :info

  alias MachineMonitor.Accounts.{Machine, User}
  alias MachineMonitor.Accounts
  alias MachineMonitor.Machine, as: MachineInformation

  alias MachineMonitorWeb.Serializers.MachineList
  alias MachineMonitorWeb.Serializers.Machine, as: MachineSerializer
  alias MachineMonitorWeb.Serializers.MachineMonitor, as: MachineMonitorSerializer

  def join("MACHINE:" <> machine_uuid, params, socket) do
    case MachineMonitorWeb.UserSocket.connect(params, socket) do
      {:ok, socket} ->
        %Machine{} = machine = Guardian.Phoenix.Socket.current_resource(socket)
        send(self, {:after_join, machine})
        {:ok, socket}
      _ -> {:error, :unauthenticated}
    end
  end

  def handle_in("USER_ACTIVITY_CHANGED" = event, report, socket) do
    #    persist data in db
    MachineMonitor.Machine.create_log(report)
    logs = MachineMonitor.Machine.list_logs() |> Enum.map(fn log -> Map.from_struct(log) end)
    #    broadcast event
    broadcast(socket, event, %{logs: logs})
    {:noreply, socket}
  end

  def handle_in("APPLICATIONS_STATUS" = event, %{"report" => report}, socket) do
    #    persist data in db
    %Machine{monitor: %{applications: applications}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])

    applications = Enum.map(report, fn %{"name" => name, "status" => status} -> 
      %{"display" => display} = Enum.find(applications, fn %{"name" => app_name} -> name == app_name end)
      %{name: name, display: display, status: status}
    end)

   {:ok, _, monitor} = MachineMonitor.Machine.update_machine_monitor(machine, %{applications: applications})

   data = MachineMonitorSerializer.applications(monitor)
   IO.inspect {:applications_status, data}

    #    broadcast event
    broadcast(socket, event, %{status: data})

    {:noreply, socket}
  end

  def handle_in("APPLICATION_STATUS_CHANGED" = event, %{"name" => name, "status" => status} = report, socket) do
    #    persist data in db
    %Machine{monitor: %{applications: applications}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])

    applications = Enum.map(applications, fn %{"name" => a_name, "display" => display} = app ->  
      if(name == a_name) do
        %{status: status, name: name, display: display}
      else
        app
      end
    end)

   {:ok, _, monitor} = MachineMonitor.Machine.update_machine_monitor(machine, %{applications: applications})

   data = MachineMonitorSerializer.applications(monitor)

    #    broadcast event
    broadcast(socket, event, %{status: data})

    {:noreply, socket}
  end

  def handle_in("SERVICES_STATUS" = event, %{"report" => report}, socket) do
    #    persist data in db
    %Machine{monitor: %{services: services}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])
    
    services = Enum.map(report, fn %{"name" => name, "status" => status} -> 
      %{"display" => display} = Enum.find(services, fn %{"name" => service_name} -> name == service_name end)
      %{name: name, display: display, status: status}
    end)

   {:ok, _, monitor} = MachineMonitor.Machine.update_machine_monitor(machine, %{services: services})

   data = MachineMonitorSerializer.services(monitor)

   IO.inspect {:services_status, data}

    #    broadcast event
    broadcast(socket, event, %{status: data})
    {:noreply, socket}
  end

  def handle_in("SERVICE_STATUS_CHANGED" = event, %{"name" => name, "status" => status} = report, socket) do
    #    persist data in db
    %Machine{monitor: %{services: services}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])

    services = Enum.map(services, fn %{"name" => s_name, "display" => display} = service ->  
      if(name == s_name) do
        %{status: status, name: name, display: display}
      else
        service
      end
    end)

   {:ok, _, monitor} = MachineMonitor.Machine.update_machine_monitor(machine, %{services: services})

   data = MachineMonitorSerializer.services(monitor)

    #    broadcast event
    broadcast(socket, event, %{status: data})

    {:noreply, socket}
  end

  def handle_in("NETWORK_STATUS_CHANGED" = event, %{"id" => id, "name" => name} = updated_adapter, socket) do
    %Machine{monitor: %{network: network}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])

    network = Enum.map(network, fn %{"id" => adapter_id, "name" => adapter_name} = adapter ->  
      if(id == adapter_id && name == adapter_name) do
        updated_adapter
      else
        adapter
      end
    end)
    #    persist data in db
   {:ok, _, monitor} = MachineMonitor.Machine.update_machine_monitor(machine, %{network: network})

   data = MachineMonitorSerializer.network(monitor)

    #    broadcast event
    broadcast(socket, event, %{status: data})

    {:noreply, socket}
  end

  def handle_in("NETWORK_STATUS" = event, %{"report" => report}, socket) do
    %Machine{monitor: %{network: network}} = machine =
      Guardian.Phoenix.Socket.current_resource(socket) |> MachineMonitor.Repo.preload([:monitor])
    #    persist data in db
   {:ok, _, monitor} = MachineMonitor.Machine.update_machine_monitor(machine, %{network: report})

   data = MachineMonitorSerializer.network(monitor)

   IO.inspect {:network_status, data}

    #    broadcast event
    broadcast(socket, event, %{status: data})

    {:noreply, socket}
  end

  def handle_in("LOCATION_STATUS_CHANGED" = event, %{"longitude" => lon, "latitude" => lat, "timestamp" => tim} = report, socket) do
    %Machine{id: id} = Guardian.Phoenix.Socket.current_resource(socket)

    # #    persist data in db
    data = %{
      machine_id: id, 
      longitude: lon, 
      latitude: lat, 
      timestamp: tim
    }
    {:ok, _} = MachineMonitor.Machine.create_location(data)

    #    broadcast event
    broadcast(socket, event, %{status: report})

    {:noreply, socket}
  end

  def handle_in("LOCATION_STATUS" = event, %{"report" => %{"longitude" => lon, "latitude" => lat, "timestamp" => tim} = report}, socket) do
    %Machine{id: id} = Guardian.Phoenix.Socket.current_resource(socket)

    # #    persist data in db
    data = %{
      machine_id: id, 
      longitude: lon, 
      latitude: lat, 
      timestamp: tim
    }
    {:ok, _} = MachineMonitor.Machine.create_location(data)

    #    broadcast event
    broadcast(socket, event, %{status: report})

    {:noreply, socket}
  end

  def handle_in("CHANGE_PASSWORD_DONE" = event, report, socket) do
    %Machine{uuid: uuid, name: name} = machine = Guardian.Phoenix.Socket.current_resource(socket)
    #    broadcast event
    data = %{changed: Map.get(report, "changed"), machine: %{name: name, uuid: uuid}}
    broadcast(socket, event, data)

    {:noreply, socket}
  end


  def handle_in("SHUT_DOWN" = event, data, socket) do
    broadcast(socket, event, data)
    {:noreply, socket}
  end

  def handle_in("STOP_SERVICE" = event, data, socket) do
    broadcast(socket, event, data)
    {:noreply, socket}
  end

  def handle_in("START_SERVICE" = event, data, socket) do
    broadcast(socket, event, data)
    {:noreply, socket}
  end

  def handle_in("STOP_APPLICATION" = event, data, socket) do
    broadcast(socket, event, data)
    {:noreply, socket}
  end

  def handle_in("START_APPLICATION" = event, data = params, socket) do
    broadcast(socket, event, data)
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
end