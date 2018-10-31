defmodule MachineMonitorWeb.RoleView do
    use MachineMonitorWeb, :view

    def render("index.json", %{roles: roles}) do
        roles
    end
end