defmodule MachineMonitorWeb.LaminateView do
    use MachineMonitorWeb, :view

    def render("index.json", %{laminates: laminates}) do
        Enum.map(laminates, fn laminate -> 
            %{
                id: laminate.id, 
                amount: laminate.amount, 
                date: DateTime.to_string(laminate.date), 
                transaction_type: _get_type(laminate.transaction_type),
                stock_after_transaction: laminate.stock_after_transaction,
                stock_before_transaction: laminate.stock_before_transaction
            } 
        end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    defp _get_type(1), do: "Check In"
    defp _get_type(0), do: "Check Out"
end