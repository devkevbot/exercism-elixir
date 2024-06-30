defmodule CustomSet do
  @opaque t :: %__MODULE__{elem: list}

  defstruct elem: []

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    %CustomSet{elem: Enum.uniq(enumerable)}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    Enum.empty?(custom_set.elem)
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    Enum.find(custom_set.elem, nil, fn e -> e === element end) != nil
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    Enum.all?(custom_set_1.elem, fn e -> contains?(custom_set_2, e) end)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    Enum.all?(custom_set_1.elem, fn e -> not contains?(custom_set_2, e) end)
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    Enum.frequencies(custom_set_1.elem) === Enum.frequencies(custom_set_2.elem)
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    if contains?(custom_set, element) do
      custom_set
    else
      new(custom_set.elem ++ [element])
    end
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    filtered = Enum.filter(custom_set_1.elem, fn e -> contains?(custom_set_2, e) end)
    new(filtered)
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    filtered = Enum.filter(custom_set_1.elem, fn e -> not contains?(custom_set_2, e) end)
    new(filtered)
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    filtered = Enum.uniq(custom_set_1.elem ++ custom_set_2.elem)
    new(filtered)
  end
end
