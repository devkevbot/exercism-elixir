defmodule RationalNumbers do
  import Kernel, except: [abs: 1]

  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(x :: rational, y :: rational) :: rational
  def add({a, b}, {c, d}) do
    {a * d + c * b, b * d} |> reduce()
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(x :: rational, y :: rational) :: rational
  def subtract({a, b}, {c, d}) do
    {a * d - c * b, b * d} |> reduce()
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(x :: rational, y :: rational) :: rational
  def multiply({a, b}, {c, d}) do
    {a * c, b * d} |> reduce()
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a, b}, {c, d}) when c != 0 do
    {a * d, b * c} |> reduce()
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({num, denom}) do
    {Kernel.abs(num), Kernel.abs(denom)} |> reduce()
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(x :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n >= 0 do
    {Kernel.trunc(:math.pow(a, n)), Kernel.trunc(:math.pow(b, n))} |> reduce()
  end

  def pow_rational({a, b}, n) do
    n = Kernel.abs(n)
    {Kernel.trunc(:math.pow(b, n)), Kernel.trunc(:math.pow(a, n))} |> reduce()
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    :math.pow(x, a) |> :math.pow(1.0 / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(x :: rational) :: rational
  def reduce({a, b}) do
    gcd = Integer.gcd(a, b)

    a = div(a, gcd)
    b = div(b, gcd)

    if b < 0 do
      {-a, -b}
    else
      {a, b}
    end
  end
end
