defmodule MachineMonitorWeb.CenterView do
    use MachineMonitorWeb, :view 

    def render("list.json", %{centers: centers, pagination: pagination}) do
        %{
            centers: Enum.map(centers, fn %{id: id, name: n, code: c, status: s}->  
                %{name: n, code: c, status: s, id: id}
            end), 
            pagination: pagination
        }
    end

    def render("map.json", %{centers: centers}) do
        centers
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    def render("update.json", %{updated: updated}) do
        %{updated: updated}
    end

    def render("single.json", %{center: center}) do
        center
    end

    def render("delete.json", %{deleted: deleted}) do
        %{deleted: deleted}
    end
end