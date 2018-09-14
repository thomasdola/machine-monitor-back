defmodule MachineMonitorWeb.MachineController do
  use MachineMonitorWeb, :controller

  action_fallback MachineMonitorWeb.ActionFallbackController

  alias MachineMonitor.{Accounts, Settings}
  alias MachineMonitorWeb.Serializers.{MachineList, Machine}

  def list(conn, params) do
    machines = Accounts.list_machines(params)
    render conn, "list.json", machines: MachineList.to_map(machines)
  end

  def single(conn, %{"id" => machine_id, "type" => type} = params) do
    with %Accounts.Machine{} = machine <- Accounts.get_machine_by(String.to_existing_atom(type), machine_id) do
      render conn, "single.json", machine: Machine.to_map(machine)
    end
  end

  defp machine_channel(uuid), do: "MRW:#{uuid}"
end
