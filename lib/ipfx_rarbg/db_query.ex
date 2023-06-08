defmodule IpfxRarbg.DBQuery do
  @moduledoc false
  def prepare_statement(tag_values, conn) do
    {query, params} =
      prepare_stm(tag_values, "select title, dt, size, cat, hash from items where ", [], 1)

    {:ok, statement} =
      Exqlite.Sqlite3.prepare(conn, query)

    :ok = Exqlite.Sqlite3.bind(conn, statement, params)
    statement
  end

  def step_rows(statement, conn, acc) do
    case Exqlite.Sqlite3.step(conn, statement) do
      :done ->
        acc

      {:row, row} ->
        step_rows(statement, conn, [
          IpfxRarbg.Display.row(row) | acc
        ])
    end
  end

  def prepare_stm([], query, params, _) do
    {query <> " ORDER BY dt DESC", Enum.reverse(params)}
  end

  def prepare_stm([{_, empty} | rest], query, params, num) when empty in [nil, []] do
    prepare_stm(rest, query, params, num)
  end

  def prepare_stm([{:title, titles} | rest], query, params, num) do
    {strs, num2s, num2} =
      List.foldl(
        titles,
        {[], [], num},
        fn t, {str, nums, acc} ->
          {["title LIKE ?#{acc} " | str], ["%#{t}%" | nums], acc + 1}
        end
      )

    strs = Enum.intersperse(strs, "AND ") |> Enum.join()
    prepare_stm(rest, query <> strs, num2s ++ params, num2)
  end

  def prepare_stm([{:year, year} | rest], query, params, num) do
    {dt1, dt2} = begin_end_year(year)

    prepare_stm(
      rest,
      query <> "and dt >= ?#{num} and dt <= ?#{num + 1} ",
      [dt2, dt1 | params],
      num + 2
    )
  end

  def prepare_stm([{:cat, cat} | rest], query, params, num) do
    cat = Map.get(IpfxRarbg.CmdParser.catmap(), cat)
    prepare_stm(rest, query <> "and cat = ?#{num} ", [cat | params], num + 1)
  end

  def prepare_stm([{:size, size} | rest], query, params, num) do
    {s1, s2} = begin_end_size(size)

    prepare_stm(
      rest,
      query <> "and size > ?#{num} and size < ?#{num + 1}",
      [s1, s2 | params],
      num + 2
    )
  end

  def begin_end_year(year) do
    {DateTime.new!(Date.new!(year, 1, 1), Time.new!(0, 0, 0))
     |> DateTime.to_unix(),
     (DateTime.new!(Date.new!(year + 1, 1, 1), Time.new!(0, 0, 0))
      |> DateTime.to_unix()) - 1}
  end

  def begin_end_size(size) do
    {round(size * 1.1), round(size * 0.9)}
  end

  # SELECT 	* FROM 	items LIMIT 10;
  def select(conn, select_statement) do
    {:ok, statement} = Exqlite.Sqlite3.prepare(conn, select_statement)
    Exqlite.Sqlite3.step(conn, statement)
  end
end
