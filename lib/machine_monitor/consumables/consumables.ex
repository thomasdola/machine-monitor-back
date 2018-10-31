defmodule MachineMonitor.Consumables do
  @moduledoc """
  The Consumables context.
  """

  import Ecto.Query, warn: false
  alias MachineMonitor.Repo

  alias MachineMonitor.Consumables.Card

  @doc """
  Returns the list of cards.

  ## Examples

      iex> list_cards()
      [%Card{}, ...]

  """
  def list_cards do
    Repo.all(Card)
  end

  @doc """
  Gets a single card.

  Raises `Ecto.NoResultsError` if the Card does not exist.

  ## Examples

      iex> get_card!(123)
      %Card{}

      iex> get_card!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card!(id), do: Repo.get!(Card, id)

  @doc """
  Creates a card.

  ## Examples

      iex> create_card(%{field: value})
      {:ok, %Card{}}

      iex> create_card(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a card.

  ## Examples

      iex> update_card(card, %{field: new_value})
      {:ok, %Card{}}

      iex> update_card(card, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card(%Card{} = card, attrs) do
    card
    |> Card.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Card.

  ## Examples

      iex> delete_card(card)
      {:ok, %Card{}}

      iex> delete_card(card)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card(%Card{} = card) do
    Repo.delete(card)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card changes.

  ## Examples

      iex> change_card(card)
      %Ecto.Changeset{source: %Card{}}

  """
  def change_card(%Card{} = card) do
    Card.changeset(card, %{})
  end

  alias MachineMonitor.Consumables.Ribbon

  @doc """
  Returns the list of ribbons.

  ## Examples

      iex> list_ribbons()
      [%Ribbon{}, ...]

  """
  def list_ribbons do
    Repo.all(Ribbon)
  end

  @doc """
  Gets a single ribbon.

  Raises `Ecto.NoResultsError` if the Ribbon does not exist.

  ## Examples

      iex> get_ribbon!(123)
      %Ribbon{}

      iex> get_ribbon!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ribbon!(id), do: Repo.get!(Ribbon, id)

  @doc """
  Creates a ribbon.

  ## Examples

      iex> create_ribbon(%{field: value})
      {:ok, %Ribbon{}}

      iex> create_ribbon(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ribbon(attrs \\ %{}) do
    %Ribbon{}
    |> Ribbon.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ribbon.

  ## Examples

      iex> update_ribbon(ribbon, %{field: new_value})
      {:ok, %Ribbon{}}

      iex> update_ribbon(ribbon, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ribbon(%Ribbon{} = ribbon, attrs) do
    ribbon
    |> Ribbon.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ribbon.

  ## Examples

      iex> delete_ribbon(ribbon)
      {:ok, %Ribbon{}}

      iex> delete_ribbon(ribbon)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ribbon(%Ribbon{} = ribbon) do
    Repo.delete(ribbon)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ribbon changes.

  ## Examples

      iex> change_ribbon(ribbon)
      %Ecto.Changeset{source: %Ribbon{}}

  """
  def change_ribbon(%Ribbon{} = ribbon) do
    Ribbon.changeset(ribbon, %{})
  end

  alias MachineMonitor.Consumables.Laminate

  @doc """
  Returns the list of laminates.

  ## Examples

      iex> list_laminates()
      [%Laminate{}, ...]

  """
  def list_laminates do
    Repo.all(Laminate)
  end

  @doc """
  Gets a single laminate.

  Raises `Ecto.NoResultsError` if the Laminate does not exist.

  ## Examples

      iex> get_laminate!(123)
      %Laminate{}

      iex> get_laminate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_laminate!(id), do: Repo.get!(Laminate, id)

  @doc """
  Creates a laminate.

  ## Examples

      iex> create_laminate(%{field: value})
      {:ok, %Laminate{}}

      iex> create_laminate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_laminate(attrs \\ %{}) do
    %Laminate{}
    |> Laminate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a laminate.

  ## Examples

      iex> update_laminate(laminate, %{field: new_value})
      {:ok, %Laminate{}}

      iex> update_laminate(laminate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_laminate(%Laminate{} = laminate, attrs) do
    laminate
    |> Laminate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Laminate.

  ## Examples

      iex> delete_laminate(laminate)
      {:ok, %Laminate{}}

      iex> delete_laminate(laminate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_laminate(%Laminate{} = laminate) do
    Repo.delete(laminate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking laminate changes.

  ## Examples

      iex> change_laminate(laminate)
      %Ecto.Changeset{source: %Laminate{}}

  """
  def change_laminate(%Laminate{} = laminate) do
    Laminate.changeset(laminate, %{})
  end

  alias MachineMonitor.Consumables.ReceiptPaperRoll

  @doc """
  Returns the list of receipt_paper_rolls.

  ## Examples

      iex> list_receipt_paper_rolls()
      [%ReceiptPaperRoll{}, ...]

  """
  def list_receipt_paper_rolls do
    Repo.all(ReceiptPaperRoll)
  end

  @doc """
  Gets a single receipt_paper_roll.

  Raises `Ecto.NoResultsError` if the Receipt paper roll does not exist.

  ## Examples

      iex> get_receipt_paper_roll!(123)
      %ReceiptPaperRoll{}

      iex> get_receipt_paper_roll!(456)
      ** (Ecto.NoResultsError)

  """
  def get_receipt_paper_roll!(id), do: Repo.get!(ReceiptPaperRoll, id)

  @doc """
  Creates a receipt_paper_roll.

  ## Examples

      iex> create_receipt_paper_roll(%{field: value})
      {:ok, %ReceiptPaperRoll{}}

      iex> create_receipt_paper_roll(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_receipt_paper_roll(attrs \\ %{}) do
    %ReceiptPaperRoll{}
    |> ReceiptPaperRoll.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a receipt_paper_roll.

  ## Examples

      iex> update_receipt_paper_roll(receipt_paper_roll, %{field: new_value})
      {:ok, %ReceiptPaperRoll{}}

      iex> update_receipt_paper_roll(receipt_paper_roll, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_receipt_paper_roll(%ReceiptPaperRoll{} = receipt_paper_roll, attrs) do
    receipt_paper_roll
    |> ReceiptPaperRoll.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ReceiptPaperRoll.

  ## Examples

      iex> delete_receipt_paper_roll(receipt_paper_roll)
      {:ok, %ReceiptPaperRoll{}}

      iex> delete_receipt_paper_roll(receipt_paper_roll)
      {:error, %Ecto.Changeset{}}

  """
  def delete_receipt_paper_roll(%ReceiptPaperRoll{} = receipt_paper_roll) do
    Repo.delete(receipt_paper_roll)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking receipt_paper_roll changes.

  ## Examples

      iex> change_receipt_paper_roll(receipt_paper_roll)
      %Ecto.Changeset{source: %ReceiptPaperRoll{}}

  """
  def change_receipt_paper_roll(%ReceiptPaperRoll{} = receipt_paper_roll) do
    ReceiptPaperRoll.changeset(receipt_paper_roll, %{})
  end
end
