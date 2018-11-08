defmodule MachineMonitorWeb.Serializers.Center.Map do
    use Remodel
  
    attributes [:id, :code, :name, :status, :deployments, :longitude, :latitude]

    def longitude(%{location: nil}), do: nil
    def longitude(%{location: %{longitude: long}}) do
       long
    end

    def latitude(%{location: nil}), do: nil
    def latitude(%{location: %{latitude: lat}}), do: lat

    def deployments(%{deployments: nil}), do: []
    def deployments(%{deployments: deployments}) do
        Enum.map(deployments, fn deployment -> 
            %{
                id: deployment.id,
                start_date: DateTime.to_string(deployment.start_date),
                end_date: DateTime.to_string(deployment.end_date),
                status: deployment.status,
                machines: MachineMonitorWeb.Serializers.Machine.to_map(deployment.machines),
                printers: Enum.map(deployment.printers, fn printer -> %{id: printer.id, name: printer.serial} end)
            }
        end)
    end
  end