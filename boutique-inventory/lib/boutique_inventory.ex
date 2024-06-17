defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, fn i -> i.price end, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn i -> i.price == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn i ->
      new_name = String.replace(i.name, old_word, new_word)
      %{i | name: new_name}
    end)
  end

  def increase_quantity(item, count) do
    quantities =
      Map.new(item.quantity_by_size, fn {size, quantity} -> {size, quantity + count} end)

    %{item | quantity_by_size: quantities}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_, qty}, total -> qty + total end)
  end
end
