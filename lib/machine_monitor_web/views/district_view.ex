defmodule MachineMonitorWeb.DistrictView do
    use MachineMonitorWeb, :view

    def render("index.json", %{districts: districts}) do
        Enum.map(districts, fn district -> %{id: district.id, name: district.name} end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    def render("single.json", %{district: district}) do
        %{id: district.id, name: district.name}
    end

    def render("update.json", %{updated: updated}) do
        %{updated: updated}
    end

    def render("delete.json", %{deleted: deleted}) do
        %{deleted: deleted}
    end
end