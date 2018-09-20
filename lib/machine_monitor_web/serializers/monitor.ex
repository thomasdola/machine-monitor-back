defmodule MachineMonitorWeb.Serializers.MachineMonitor do
  use Phoenix.HTML
  
  def power(nil), do: "OFF"
  def power(%{status: 1}), do: "ON"
  def power(%{status: 0}), do: "OFF"

  def network(nil), do: []
  def network(%{network: nil}), do: []
  def network(%{network: network}) do
    Enum.map(network, fn adapter ->  
      keys = Map.keys adapter
      Enum.map(keys, fn key ->  
        value = Map.get(adapter, key)
        %{name: humanize(key), value: value}
      end) |> Enum.reject(fn %{name: name} -> String.downcase(name) == "address" end)
    end)
  end

  def applications(nil), do: []
  def applications(%{applications: nil}), do: []
  def applications(%{applications: applications}) do
    Enum.map(applications, &process/1)
  end

  def services(nil), do: []
  def services(%{services: nil}), do: []
  def services( %{services: services}) do
    Enum.map(services, &process/1)
  end

  defp process(%{"name" => name, "status" => status, "display" => display}), do: %{name: name, status: status, display: display}
  defp process(%{name: name, status: status, display: display}), do: %{name: name, status: status, display: display}
end