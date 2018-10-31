defmodule MachineMonitorWeb.CardView do
    use MachineMonitorWeb, :view

    def render("index.json", %{cards: cards}) do
        Enum.map(cards, fn card -> 
            %{
                id: card.id, 
                amount: card.amount, 
                date: DateTime.to_string(card.date), 
                transaction_type: _get_type(card.transaction_type),
                stock_after_transaction: card.stock_after_transaction,
                stock_before_transaction: card.stock_before_transaction
            } 
        end)
    end

    def render("create.json", %{created: created}) do
        %{created: created}
    end

    defp _get_type(1), do: "Check In"
    defp _get_type(0), do: "Check Out"
end