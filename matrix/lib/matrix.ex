defmodule Matrix do
  defstruct [:data, :n_rows, :n_cols]

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    rows =
      input
      |> String.split("\n")
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn row ->
        Enum.map(row, &String.to_integer(&1, 10))
      end)

    n_rows = length(rows)
    n_cols = length(Enum.at(rows, 0))

    %Matrix{
      data: rows,
      n_rows: n_rows,
      n_cols: n_cols
    }
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    matrix.data
    |> Enum.map(fn row ->
      Enum.map(row, &Integer.to_string/1) |> Enum.join(" ")
    end)
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
    matrix.data
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    Enum.at(matrix.data, index - 1)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    1..matrix.n_cols |> Enum.map(&column(matrix, &1))
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    matrix.data
    |> Enum.map(&Enum.at(&1, index - 1))
  end
end
