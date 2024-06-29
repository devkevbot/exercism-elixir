defmodule PaintByNumber do
  @spec palette_bit_size(number()) :: integer()
  def palette_bit_size(color_count) do
    trunc(:math.ceil(:math.log2(color_count)))
  end

  @spec empty_picture() :: <<>>
  def empty_picture() do
    <<>>
  end

  @spec test_picture() :: <<_::8>>
  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  @spec prepend_pixel(bitstring(), number(), integer()) :: bitstring()
  def prepend_pixel(picture, color_count, pixel_color_index) do
    bitsize = palette_bit_size(color_count)
    <<pixel_color_index::size(bitsize), picture::bitstring>>
  end

  @spec get_first_pixel(bitstring(), number()) :: integer() | nil
  def get_first_pixel(picture, _) when picture == <<>>, do: nil

  def get_first_pixel(picture, color_count) do
    bitsize = palette_bit_size(color_count)
    <<value::size(bitsize), _::bitstring>> = picture
    value
  end

  @spec drop_first_pixel(bitstring(), number()) :: bitstring() | nil
  def drop_first_pixel(picture, _) when picture == <<>>, do: <<>>

  def drop_first_pixel(picture, color_count) do
    bitsize = palette_bit_size(color_count)
    <<_::size(bitsize), rest::bitstring>> = picture
    rest
  end

  @spec concat_pictures(bitstring(), bitstring()) :: bitstring()
  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
