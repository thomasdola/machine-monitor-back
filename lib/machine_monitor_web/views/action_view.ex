defmodule MachineMonitorWeb.ActionView do
    use MachineMonitorWeb, :view

    def render("index.json", %{actions: actions}) do
        Enum.map(actions, fn %{id: id, name: name} -> %{id: id, name: name} end)
    end
end