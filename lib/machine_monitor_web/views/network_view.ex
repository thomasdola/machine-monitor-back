defmodule MachineMonitorWeb.NetworkView do
    use MachineMonitorWeb, :view

    def render("index.json", %{networks: networks}) do
        Enum.map(networks, fn network -> %{id: network.id, operator: network.operator, type: network.type} end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    def render("single.json", %{network: network}) do
        %{id: network.id, operator: network.operator, type: network.type}
    end

    def render("update.json", %{updated: updated}) do
        %{updated: updated}
    end

    def render("delete.json", %{deleted: deleted}) do
        %{deleted: deleted}
    end
end