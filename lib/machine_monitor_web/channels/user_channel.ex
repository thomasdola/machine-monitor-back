defmodule MachineMonitorWeb.UserChannel do
  use MachineMonitorWeb, :channel
  use Phoenix.Channel, log_join: :info, log_handle_in: :info, log_hand_info: :info, log_handle_out: :info

  alias MachineMonitor.Accounts

  def join("USER:" <> user_uuid, params, socket) do
    case MachineMonitorWeb.UserSocket.connect(params, socket) do
      {:ok, socket} ->
        topics = Accounts.list_machines() |> Enum.map(fn %{uuid: uuid} -> "MACHINE:"<>uuid end)
        {:ok, socket |> assign(:topics, []) |> put_new_topics(topics)}
      _ -> {:error, :unauthenticated}
    end
  end

  def handle_in("CHANGE_PASSWORD" = event, %{"machine" => name} = params, socket) do
    %Accounts.Machine{uuid: uuid} = Accounts.get_machine_by(:name, name)
    MachineMonitorWeb.Endpoint.broadcast("MACHINE:#{uuid}", event, params)
    {:reply, :ok, socket}
  end

  def handle_in("SHUT_DOWN" = event, %{"machine" => name} = params, socket) do
    %Accounts.Machine{uuid: uuid} = Accounts.get_machine_by(:name, name)
    MachineMonitorWeb.Endpoint.broadcast("MACHINE:#{uuid}", event, params)
    {:reply, :ok, socket}
  end

  def handle_in("STOP_SERVICE" = event, %{"machine" => name} = params, socket) do
    %Accounts.Machine{uuid: uuid} = Accounts.get_machine_by(:name, name)
    MachineMonitorWeb.Endpoint.broadcast("MACHINE:#{uuid}", event, params)
    {:reply, :ok, socket}
  end

  def handle_in("START_SERVICE" = event, %{"machine" => name} = params, socket) do
    %Accounts.Machine{uuid: uuid} = Accounts.get_machine_by(:name, name)
    MachineMonitorWeb.Endpoint.broadcast("MACHINE:#{uuid}", event, params)
    {:reply, :ok, socket}
  end

  def handle_in("STOP_APPLICATION" = event, %{"machine" => name} = params, socket) do
    %Accounts.Machine{uuid: uuid} = Accounts.get_machine_by(:name, name)
    MachineMonitorWeb.Endpoint.broadcast("MACHINE:#{uuid}", event, params)
    {:reply, :ok, socket}
  end

  def handle_in("START_APPLICATION" = event, %{"machine" => name, "name" => application} = params, socket) do
    %Accounts.Machine{uuid: uuid} = Accounts.get_machine_by(:name, name)
    case MachineMonitor.Settings.get_application_by_name(application) do
      %{path: path} ->
        MachineMonitorWeb.Endpoint.broadcast("MACHINE:#{uuid}", event, Map.put(params, :path, path))
        {:reply, :ok, socket}
      _ -> {:reply, :error, socket}
    end
  end

  alias Phoenix.Socket.Broadcast
  def handle_info(%Broadcast{topic: topic, event: ev, payload: payload}, socket) do
    IO.inspect {:info, topic, ev, payload}
    push socket, ev, payload
    {:noreply, socket}
  end

  defp put_new_topics(socket, topics) do
    Enum.reduce(topics, socket, fn topic, acc ->
      topics = acc.assigns.topics
      if topic in topics do
        acc
      else
        :ok = MachineMonitorWeb.Endpoint.subscribe(topic)
        assign(acc, :topics, [topic | topics])
      end
    end)
  end
end