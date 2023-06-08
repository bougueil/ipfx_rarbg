# See LICENSE for licensing information.

defmodule IpfxRarbg.Display do
  @moduledoc false

  @revcat IpfxRarbg.CmdParser.revcat()

  def display(list) do
    IO.write(Enum.intersperse(list, "\n"))
    IO.puts("")
  end

  def row([title, dt, size, cat, hash]) do
    "#{Base.encode16(hash)} #{date_str(dt)} #{size_str(size)} #{title} cat: #{@revcat[cat]}"
  end

  defp date_str(dt) do
    "#{DateTime.from_unix!(dt)}" |> String.slice(0, 19)
  end

  defp size_str(size) when size > 10_000_000_000 do
    size = :erlang.float_to_binary(size / 1_000_000_000, decimals: 1)
    String.pad_trailing("#{size}gb", 8)
  end

  defp size_str(size) when size > 10_000_000 do
    size = :erlang.float_to_binary(size / 1_000_000, decimals: 1)
    String.pad_trailing("#{size}mb", 8)
  end

  defp size_str(size) when size > 10_000 do
    size = :erlang.float_to_binary(size / 1_000_000, decimals: 1)
    String.pad_trailing("#{size}kb", 8)
  end
end
