defmodule MachineMonitorWeb.PolicyView do
    use MachineMonitorWeb, :view

    def render("index.json", %{policies: policies}) do
        policies
    end
end