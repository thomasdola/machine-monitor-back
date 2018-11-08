defmodule MachineMonitorWeb.RegionView do
    use MachineMonitorWeb, :view

    def render("index.json", %{regions: regions}) do
        Enum.map(regions, fn region -> %{id: region.id, name: region.name} end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    def render("single.json", %{region: region}) do
        %{id: region.id, name: region.name}
    end

    def render("update.json", %{updated: updated}) do
        %{updated: updated}
    end

    def render("delete.json", %{deleted: deleted}) do
        %{deleted: deleted}
    end
end