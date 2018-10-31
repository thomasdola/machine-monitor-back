defmodule MachineMonitorWeb.GateView do
    use MachineMonitorWeb, :view

    def render("index.json", %{gates: gates}) do
        Enum.map(gates, fn %{id: id, name: name} -> %{id: id, name: name} end)
    end
end