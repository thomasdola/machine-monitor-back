defmodule MachineMonitorWeb.Serializers.MachineList do
  use Remodel

  attributes [:id, :name, :power, :location, :locations]

  def location(%{locations: nil}), do: %{longitude: nil, latitude: nil, timestamp: nil}
  def location(%{locations: []}), do: %{longitude: nil, latitude: nil, timestamp: nil}
  def location(%{locations: [%{longitude: lon, latitude: lat, timestamp: time, out_of_zone: out} | _]}) do
    %{longitude: lon, latitude: lat, timestamp: time, out_of_zone: out}
  end

  def locations(%{locations: nil}) do
    []
  end
  def locations(%{locations: locations}) do
    Enum.map(locations, fn  %{longitude: lon, latitude: lat, timestamp: time, out_of_zone: out} ->  
      %{longitude: lon, latitude: lat, timestamp: time, out_of_zone: out}
    end)
  end

  def power(%{monitor: nil}), do: "OFF"
  def power(%{monitor: %{status: 1}}), do: "ON"
  def power(%{monitor: %{status: 0}}), do: "OFF"
end