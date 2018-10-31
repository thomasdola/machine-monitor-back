defmodule MachineMonitorWeb.MachineApplicationView do
    use MachineMonitorWeb, :view

    def render("index.json", %{applications: applications}) do
        Enum.map(applications, fn application -> %{id: application.id, name: application.name, display: application.display, path: application.path} end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    def render("single.json", %{application: application}) do
        %{id: application.id, name: application.name, display: application.display, path: application.path}
    end

    def render("update.json", %{updated: updated}) do
        %{updated: updated}
    end

    def render("delete.json", %{deleted: deleted}) do
        %{deleted: deleted}
    end
end