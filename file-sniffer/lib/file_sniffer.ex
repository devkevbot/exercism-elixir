defmodule FileSniffer do
  @extension_to_media_type %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }
  def type_from_extension(extension) do
    Map.get(@extension_to_media_type, extension)
  end

  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>), do: "application/octet-stream"
  def type_from_binary(<<0x42, 0x4D, _::binary>>), do: "image/bmp"

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>),
    do: "image/png"

  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::binary>>), do: "image/jpg"
  def type_from_binary(<<0x47, 0x49, 0x46, _::binary>>), do: "image/gif"
  def type_from_binary(_), do: nil

  def verify(file_binary, extension) do
    extension_type = type_from_extension(extension)
    binary_type = type_from_binary(file_binary)

    cond do
      extension_type == nil or binary_type == nil ->
        {:error, "Warning, file format and file extension do not match."}

      extension_type != binary_type ->
        {:error, "Warning, file format and file extension do not match."}

      true ->
        {:ok, binary_type}
    end
  end
end
