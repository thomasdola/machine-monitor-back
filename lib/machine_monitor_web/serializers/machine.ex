defmodule MachineMonitorWeb.Serializers.Machine do
  use Remodel
  use Phoenix.HTML

  attributes [:id, :name, :power, :network, :applications, :services, :uuid, :location]

  def location(%{locations: nil}), do: %{longitude: nil, latitude: nil, timestamp: nil}
  def location(%{locations: []}), do: %{longitude: nil, latitude: nil, timestamp: nil}
  def location(%{locations: [%{longitude: lon, latitude: lat, timestamp: time} | _]}) do
    %{longitude: lon, latitude: lat, timestamp: time}
  end

  def power(%{monitor: nil}), do: "OFF"
  def power(%{monitor: %{status: 1}}), do: "ON"
  def power(%{monitor: %{status: 0}}), do: "OFF"

  def network(%{monitor: nil}), do: []
  def network(%{monitor: %{network: nil}}), do: []
  def network(%{monitor: %{network: network}}) do
    Enum.map(network, fn adapter ->  
      keys = Map.keys adapter
      Enum.map(keys, fn key ->  
        value = Map.get(adapter, key)
        %{name: humanize(key), value: value}
      end) |> Enum.reject(fn %{name: name} -> String.downcase(name) == "address" end)
    end)
  end

  def applications(%{monitor: nil}), do: []
  def applications(%{monitor: %{applications: nil}}), do: []
  def applications(%{monitor: %{applications: applications}}) do
    Enum.map(applications, fn %{"name" => name, "status" => status, "display" => display} ->
      %{name: name, status: status, display: display}
    end)
  end

  def services(%{monitor: nil}), do: []
  def services(%{monitor: %{services: nil}}), do: []
  def services(%{monitor: %{services: services}}) do
    Enum.map(services, fn %{"name" => name, "status" => status, "display" => display} ->
      %{name: name, status: status, display: display}
    end)
  end
end