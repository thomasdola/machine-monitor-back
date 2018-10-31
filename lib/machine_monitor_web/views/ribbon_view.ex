defmodule MachineMonitorWeb.RibbonView do
    use MachineMonitorWeb, :view

    def render("index.json", %{ribbons: ribbons}) do
        Enum.map(ribbons, fn ribbon -> 
            %{
                id: ribbon.id, 
                amount: ribbon.amount, 
                date: DateTime.to_string(ribbon.date), 
                transaction_type: _get_type(ribbon.transaction_type),
                stock_after_transaction: ribbon.stock_after_transaction,
                stock_before_transaction: ribbon.stock_before_transaction
            } 
        end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    defp _get_type(1), do: "Check In"
    defp _get_type(0), do: "Check Out"
end