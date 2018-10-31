defmodule MachineMonitor.ConsumablesTest do
  use MachineMonitor.DataCase

  alias MachineMonitor.Consumables

  describe "cards" do
    alias MachineMonitor.Consumables.Card

    @valid_attrs %{amount: 42, date: "2010-04-17 14:00:00.000000Z", stock_after_transaction: 42, stock_before_transaction: 42, transaction_type: 42}
    @update_attrs %{amount: 43, date: "2011-05-18 15:01:01.000000Z", stock_after_transaction: 43, stock_before_transaction: 43, transaction_type: 43}
    @invalid_attrs %{amount: nil, date: nil, stock_after_transaction: nil, stock_before_transaction: nil, transaction_type: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Consumables.create_card()

      card
    end

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Consumables.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Consumables.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      assert {:ok, %Card{} = card} = Consumables.create_card(@valid_attrs)
      assert card.amount == 42
      assert card.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert card.stock_after_transaction == 42
      assert card.stock_before_transaction == 42
      assert card.transaction_type == 42
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Consumables.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, card} = Consumables.update_card(card, @update_attrs)
      assert %Card{} = card
      assert card.amount == 43
      assert card.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert card.stock_after_transaction == 43
      assert card.stock_before_transaction == 43
      assert card.transaction_type == 43
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Consumables.update_card(card, @invalid_attrs)
      assert card == Consumables.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Consumables.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Consumables.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Consumables.change_card(card)
    end
  end

  describe "ribbons" do
    alias MachineMonitor.Consumables.Ribbon

    @valid_attrs %{amount: 42, date: "2010-04-17 14:00:00.000000Z", stock_after_transaction: 42, stock_before_transaction: 42, transaction_type: 42}
    @update_attrs %{amount: 43, date: "2011-05-18 15:01:01.000000Z", stock_after_transaction: 43, stock_before_transaction: 43, transaction_type: 43}
    @invalid_attrs %{amount: nil, date: nil, stock_after_transaction: nil, stock_before_transaction: nil, transaction_type: nil}

    def ribbon_fixture(attrs \\ %{}) do
      {:ok, ribbon} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Consumables.create_ribbon()

      ribbon
    end

    test "list_ribbons/0 returns all ribbons" do
      ribbon = ribbon_fixture()
      assert Consumables.list_ribbons() == [ribbon]
    end

    test "get_ribbon!/1 returns the ribbon with given id" do
      ribbon = ribbon_fixture()
      assert Consumables.get_ribbon!(ribbon.id) == ribbon
    end

    test "create_ribbon/1 with valid data creates a ribbon" do
      assert {:ok, %Ribbon{} = ribbon} = Consumables.create_ribbon(@valid_attrs)
      assert ribbon.amount == 42
      assert ribbon.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert ribbon.stock_after_transaction == 42
      assert ribbon.stock_before_transaction == 42
      assert ribbon.transaction_type == 42
    end

    test "create_ribbon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Consumables.create_ribbon(@invalid_attrs)
    end

    test "update_ribbon/2 with valid data updates the ribbon" do
      ribbon = ribbon_fixture()
      assert {:ok, ribbon} = Consumables.update_ribbon(ribbon, @update_attrs)
      assert %Ribbon{} = ribbon
      assert ribbon.amount == 43
      assert ribbon.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert ribbon.stock_after_transaction == 43
      assert ribbon.stock_before_transaction == 43
      assert ribbon.transaction_type == 43
    end

    test "update_ribbon/2 with invalid data returns error changeset" do
      ribbon = ribbon_fixture()
      assert {:error, %Ecto.Changeset{}} = Consumables.update_ribbon(ribbon, @invalid_attrs)
      assert ribbon == Consumables.get_ribbon!(ribbon.id)
    end

    test "delete_ribbon/1 deletes the ribbon" do
      ribbon = ribbon_fixture()
      assert {:ok, %Ribbon{}} = Consumables.delete_ribbon(ribbon)
      assert_raise Ecto.NoResultsError, fn -> Consumables.get_ribbon!(ribbon.id) end
    end

    test "change_ribbon/1 returns a ribbon changeset" do
      ribbon = ribbon_fixture()
      assert %Ecto.Changeset{} = Consumables.change_ribbon(ribbon)
    end
  end

  describe "laminates" do
    alias MachineMonitor.Consumables.Laminate

    @valid_attrs %{amount: 42, date: "2010-04-17 14:00:00.000000Z", stock_after_transaction: 42, stock_before_transaction: 42, transaction_type: 42}
    @update_attrs %{amount: 43, date: "2011-05-18 15:01:01.000000Z", stock_after_transaction: 43, stock_before_transaction: 43, transaction_type: 43}
    @invalid_attrs %{amount: nil, date: nil, stock_after_transaction: nil, stock_before_transaction: nil, transaction_type: nil}

    def laminate_fixture(attrs \\ %{}) do
      {:ok, laminate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Consumables.create_laminate()

      laminate
    end

    test "list_laminates/0 returns all laminates" do
      laminate = laminate_fixture()
      assert Consumables.list_laminates() == [laminate]
    end

    test "get_laminate!/1 returns the laminate with given id" do
      laminate = laminate_fixture()
      assert Consumables.get_laminate!(laminate.id) == laminate
    end

    test "create_laminate/1 with valid data creates a laminate" do
      assert {:ok, %Laminate{} = laminate} = Consumables.create_laminate(@valid_attrs)
      assert laminate.amount == 42
      assert laminate.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert laminate.stock_after_transaction == 42
      assert laminate.stock_before_transaction == 42
      assert laminate.transaction_type == 42
    end

    test "create_laminate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Consumables.create_laminate(@invalid_attrs)
    end

    test "update_laminate/2 with valid data updates the laminate" do
      laminate = laminate_fixture()
      assert {:ok, laminate} = Consumables.update_laminate(laminate, @update_attrs)
      assert %Laminate{} = laminate
      assert laminate.amount == 43
      assert laminate.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert laminate.stock_after_transaction == 43
      assert laminate.stock_before_transaction == 43
      assert laminate.transaction_type == 43
    end

    test "update_laminate/2 with invalid data returns error changeset" do
      laminate = laminate_fixture()
      assert {:error, %Ecto.Changeset{}} = Consumables.update_laminate(laminate, @invalid_attrs)
      assert laminate == Consumables.get_laminate!(laminate.id)
    end

    test "delete_laminate/1 deletes the laminate" do
      laminate = laminate_fixture()
      assert {:ok, %Laminate{}} = Consumables.delete_laminate(laminate)
      assert_raise Ecto.NoResultsError, fn -> Consumables.get_laminate!(laminate.id) end
    end

    test "change_laminate/1 returns a laminate changeset" do
      laminate = laminate_fixture()
      assert %Ecto.Changeset{} = Consumables.change_laminate(laminate)
    end
  end

  describe "receipt_paper_rolls" do
    alias MachineMonitor.Consumables.ReceiptPaperRoll

    @valid_attrs %{amount: 42, date: "2010-04-17 14:00:00.000000Z", stock_after_transaction: 42, stock_before_transaction: 42, transaction_type: 42}
    @update_attrs %{amount: 43, date: "2011-05-18 15:01:01.000000Z", stock_after_transaction: 43, stock_before_transaction: 43, transaction_type: 43}
    @invalid_attrs %{amount: nil, date: nil, stock_after_transaction: nil, stock_before_transaction: nil, transaction_type: nil}

    def receipt_paper_roll_fixture(attrs \\ %{}) do
      {:ok, receipt_paper_roll} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Consumables.create_receipt_paper_roll()

      receipt_paper_roll
    end

    test "list_receipt_paper_rolls/0 returns all receipt_paper_rolls" do
      receipt_paper_roll = receipt_paper_roll_fixture()
      assert Consumables.list_receipt_paper_rolls() == [receipt_paper_roll]
    end

    test "get_receipt_paper_roll!/1 returns the receipt_paper_roll with given id" do
      receipt_paper_roll = receipt_paper_roll_fixture()
      assert Consumables.get_receipt_paper_roll!(receipt_paper_roll.id) == receipt_paper_roll
    end

    test "create_receipt_paper_roll/1 with valid data creates a receipt_paper_roll" do
      assert {:ok, %ReceiptPaperRoll{} = receipt_paper_roll} = Consumables.create_receipt_paper_roll(@valid_attrs)
      assert receipt_paper_roll.amount == 42
      assert receipt_paper_roll.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert receipt_paper_roll.stock_after_transaction == 42
      assert receipt_paper_roll.stock_before_transaction == 42
      assert receipt_paper_roll.transaction_type == 42
    end

    test "create_receipt_paper_roll/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Consumables.create_receipt_paper_roll(@invalid_attrs)
    end

    test "update_receipt_paper_roll/2 with valid data updates the receipt_paper_roll" do
      receipt_paper_roll = receipt_paper_roll_fixture()
      assert {:ok, receipt_paper_roll} = Consumables.update_receipt_paper_roll(receipt_paper_roll, @update_attrs)
      assert %ReceiptPaperRoll{} = receipt_paper_roll
      assert receipt_paper_roll.amount == 43
      assert receipt_paper_roll.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert receipt_paper_roll.stock_after_transaction == 43
      assert receipt_paper_roll.stock_before_transaction == 43
      assert receipt_paper_roll.transaction_type == 43
    end

    test "update_receipt_paper_roll/2 with invalid data returns error changeset" do
      receipt_paper_roll = receipt_paper_roll_fixture()
      assert {:error, %Ecto.Changeset{}} = Consumables.update_receipt_paper_roll(receipt_paper_roll, @invalid_attrs)
      assert receipt_paper_roll == Consumables.get_receipt_paper_roll!(receipt_paper_roll.id)
    end

    test "delete_receipt_paper_roll/1 deletes the receipt_paper_roll" do
      receipt_paper_roll = receipt_paper_roll_fixture()
      assert {:ok, %ReceiptPaperRoll{}} = Consumables.delete_receipt_paper_roll(receipt_paper_roll)
      assert_raise Ecto.NoResultsError, fn -> Consumables.get_receipt_paper_roll!(receipt_paper_roll.id) end
    end

    test "change_receipt_paper_roll/1 returns a receipt_paper_roll changeset" do
      receipt_paper_roll = receipt_paper_roll_fixture()
      assert %Ecto.Changeset{} = Consumables.change_receipt_paper_roll(receipt_paper_roll)
    end
  end
end
