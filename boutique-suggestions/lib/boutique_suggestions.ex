defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ Keyword.new()) do
    for t <- tops,
        b <- bottoms,
        t.base_color != b.base_color,
        t.price + b.price <= Keyword.get(options, :maximum_price, 100.00),
        do: {t, b}
  end
end
