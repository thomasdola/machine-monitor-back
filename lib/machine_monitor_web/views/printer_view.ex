defmodule MachineMonitorWeb.PrinterView do
    use MachineMonitorWeb, :view

    def render("index.json", %{printers: printers}) do
        Enum.map(printers, fn printer -> %{id: printer.id, serial: printer.serial, laminator: printer.laminator} end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    def render("single.json", %{printer: printer}) do
        %{id: printer.id, serial: printer.serial, laminator: printer.laminator}
    end

    def render("update.json", %{updated: updated}) do
        %{updated: updated}
    end

    def render("delete.json", %{deleted: deleted}) do
        %{deleted: deleted}
    end
end