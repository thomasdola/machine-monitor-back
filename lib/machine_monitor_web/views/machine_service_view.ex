defmodule MachineMonitorWeb.MachineServiceView do
    use MachineMonitorWeb, :view

    def render("index.json", %{services: services}) do
        Enum.map(services, fn service -> %{id: service.id, name: service.name, display: service.display, path: service.path} end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    def render("single.json", %{service: service}) do
        %{id: service.id, name: service.name, display: service.display, path: service.path}
    end

    def render("update.json", %{updated: updated}) do
        %{updated: updated}
    end

    def render("delete.json", %{deleted: deleted}) do
        %{deleted: deleted}
    end
end