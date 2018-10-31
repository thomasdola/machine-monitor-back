defmodule MachineMonitorWeb.EntityView do
    use MachineMonitorWeb, :view

    def render("index.json", %{entities: entities}) do
        Enum.map(entities, fn %{id: id, name: name} -> %{id: id, name: name} end)
    end
end