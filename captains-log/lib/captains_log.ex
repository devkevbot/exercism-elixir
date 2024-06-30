defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  @spec random_planet_class() :: bitstring()
  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  @spec random_ship_registry_number() :: bitstring()
  def random_ship_registry_number() do
    prefix = "NCC"
    number = Enum.random(1000..9999)
    "#{prefix}-#{number}"
  end

  @spec random_stardate() :: float()
  def random_stardate() do
    :rand.uniform() * 1000 + 41_000
  end

  @spec format_stardate(float) :: bitstring()
  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate]) |> to_string()
  end
end
