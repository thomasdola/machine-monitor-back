defmodule MachineMonitorWeb.Serializers.MachineList do
  use Remodel

  attributes [:id, :name, :power, :location]

  def location(%{locations: nil}), do: %{longitude: nil, latitude: nil, timestamp: nil}
  def location(%{locations: []}), do: %{longitude: nil, latitude: nil, timestamp: nil}
  def location(%{locations: [%{longitude: lon, latitude: lat, timestamp: time} | _]}) do
    %{longitude: lon, latitude: lat, timestamp: time}
  end

  def power(%{monitor: nil}), do: "OFF"
  def power(%{monitor: %{status: 1}}), do: "ON"
  def power(%{monitor: %{status: 0}}), do: "OFF"
end