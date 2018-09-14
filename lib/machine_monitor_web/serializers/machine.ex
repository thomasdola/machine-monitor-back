defmodule MachineMonitorWeb.Serializers.Machine do
  use Remodel

  attributes [:id, :name, :power, :network, :applications, :services, :uuid]

  def power(%{monitor: nil}), do: "OFF"
  def power(%{monitor: %{status: 1}}), do: "ON"
  def power(%{monitor: %{status: 0}}), do: "OFF"

  def network(%{monitor: nil}), do: []
  def network(%{monitor: %{network: nil}}), do: []
  def network(%{monitor: %{network: network}}) do
    Enum.map(network, fn %{key: k, value: v} -> %{name: k, value: v} end)
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