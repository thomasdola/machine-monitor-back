defmodule MachineMonitorWeb.ReceiptPaperRollView do
    use MachineMonitorWeb, :view

    def render("index.json", %{receipt_paper_rolls: receipt_paper_rolls}) do
        Enum.map(receipt_paper_rolls, fn receipt_paper_roll -> 
            %{
                id: receipt_paper_roll.id, 
                amount: receipt_paper_roll.amount, 
                date: DateTime.to_string(receipt_paper_roll.date), 
                transaction_type: _get_type(receipt_paper_roll.transaction_type),
                stock_after_transaction: receipt_paper_roll.stock_after_transaction,
                stock_before_transaction: receipt_paper_roll.stock_before_transaction
            } 
        end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    defp _get_type(1), do: "Check In"
    defp _get_type(0), do: "Check Out"
end