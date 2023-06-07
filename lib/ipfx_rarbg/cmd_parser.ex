defmodule IpfxRarbg.CmdParser do
  @moduledoc false
  @catmap %{
    "ebooks" => 1,
    "games_pc_iso" => 2,
    "games_pc_rip" => 3,
    "games_ps3" => 4,
    "games_ps4" => 5,
    "games_xbox360" => 6,
    "movies_bd_full" => 7,
    "movies_bd_remux" => 8,
    "movies_x264_3d" => 9,
    "movies_x264_4k" => 10,
    "movies_x264_720" => 11,
    "movies_x264" => 12,
    "movies_x265_4k_hdr" => 13,
    "movies_x265_4k" => 14,
    "movies_x265" => 15,
    "movies_xvid_720" => 16,
    "movies_xvid" => 17,
    "movies" => 18,
    "music_flac" => 19,
    "music_mp3" => 20,
    "software_pc_iso" => 21,
    "tv_sd" => 22,
    "tv_uhd" => 23,
    "tv" => 24,
    "xxx" => 25
  }

  @revcat Map.to_list(@catmap) |> Enum.into(%{}, fn {a, b} -> {b, a} end)

  def catmap, do: @catmap
  def revcat, do: @revcat

  def criteria_tv(qs, tags) do
    List.foldl(tags, [], fn t, acc -> [{t, query_tag(t, qs)} | acc] end) |> Enum.reverse()
  end

  defp query_tag(:title, qs) do
    Regex.scan(~r/\b\w+\b/, qs)
    |> List.flatten()
    |> Enum.reject(fn word ->
      query_tag(:cat, word) ||
        query_tag(:year, word) ||
        query_tag(:size, word)
    end)
  end

  defp query_tag(:cat, qs) do
    Regex.scan(~r/\b\w+\b/, qs)
    |> List.flatten()
    |> Enum.filter(fn word -> Map.has_key?(@catmap, word) end)
    |> List.first()
  end

  defp query_tag(:year, qs) do
    case Regex.run(~r/\b((19|20)\d{2})y\b/, qs) do
      nil -> nil
      [_, year, _] -> elem(Integer.parse(year), 0)
    end
  end

  defp query_tag(:size, qs) do
    cond do
      r = Regex.run(~r/\b(0|[1-9][0-9]*)mb\b/, qs) ->
        [_, size] = r
        elem(Integer.parse(size), 0) * 1000 * 1000

      r = Regex.run(~r/\b(0|[1-9][0-9]*)kb\b/, qs) ->
        [_, size] = r
        elem(Integer.parse(size), 0) * 1000

      r = Regex.run(~r/\b(0|[1-9][0-9]*)gb\b/, qs) ->
        [_, size] = r
        elem(Integer.parse(size), 0) * 1000 * 1000 * 1000

      true ->
        nil
    end
  end

  def test do
    cond do
      r = List.first([11]) ->
        IO.puts(r)

      true ->
        IO.puts("tant pis")
    end
  end
end
