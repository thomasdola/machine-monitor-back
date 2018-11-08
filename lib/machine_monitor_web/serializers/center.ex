defmodule MachineMonitorWeb.Serializers.Center do
    use Remodel
  
    attributes [:id, :code, :name, :status, :ghana_post_gps, :longitude, :latitude, :sketch, :contact_name, 
        :contact_phone, :recomended, :preferred_network, :backup_network, :deployments, :region_id, :district_id]

    def region_id(%{location: nil}), do: nil
    def region_id(%{location: %{region_id: id}}), do: id

    def district_id(%{location: nil}), do: nil
    def district_id(%{location: %{district_id: id}}), do: id

    def ghana_post_gps(%{location: nil}), do: nil
    def ghana_post_gps(%{location: %{ghana_post_gps: gps}}), do: gps

    def longitude(%{location: nil}), do: nil
    def longitude(%{location: %{longitude: long}}) do
       long
    end

    def latitude(%{location: nil}), do: nil
    def latitude(%{location: %{latitude: lat}}), do: lat

    def sketch(%{location: nil}), do: nil
    def sketch(%{location: %{sketch: sketch}}), do: sketch

    def contact_name(%{contact: nil}), do: nil
    def contact_name(%{contact: %{name: name}}) do
        name
    end

    def contact_phone(%{contact: nil}), do: nil
    def contact_phone(%{contact: %{name: name, phone: phone}}) do
        phone
    end

    def preferred_network(%{recomendation: nil}), do: nil
    def preferred_network(%{recomendation: %{preferred_network: preferred_network}}) do
        preferred_network
    end

    def backup_network(%{recomendation: nil}), do: nil
    def backup_network(%{recomendation: %{backup_network: backup_network}}) do
        backup_network
    end

    def recomended(%{recomendation: nil}), do: "0"
    def recomended(%{recomendation: %{recomended: recomended}}) do
        if recomended, do: "1", else: "0"
    end

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