defmodule MachineMonitorWeb.Serializers.MachineList do
  use Remodel

  attributes [:id, :name, :power]

  def power(%{monitor: nil}), do: "OFF"
  def power(%{monitor: %{status: 1}}), do: "ON"
  def power(%{monitor: %{status: 0}}), do: "OFF"
end