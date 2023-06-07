defmodule IpfxRarbg do
  @app_name Mix.Project.config()[:name]

  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  @slogan """
  #{@app_name} ipfx_rarbg basic query tool
  q quit - h help - other strings for query, example:
  paris 1972 2020y 2gb movies_x265
  """

  @doc """
      main entry point for the command-line interpreter escript
  """
  def main(_) do
    IO.puts(@slogan)

    {:ok, conn} =
      Exqlite.Sqlite3.open(
        "./rarbg/ipfs/QmbpRxBZ5HDZDVRoeAU8xFYnoP4r5eGCxdkmfFW3JbA6mq/rarbg_db_ipfs.sqlite",
        mode: :readonly
      )

    loop(conn)
  end

  @doc false
  defp loop(conn) do
    case IO.read(:line) do
      "q\n" ->
        IO.puts("quit #{@app_name}.")

      "h\n" ->
        IO.puts("""
        example: 
          paris 1972 2020y 2gb movies_x265
        queries rows with the following fields: 
            - title expects 'paris' and '1972'
            - dt expects dt in '2020y' (year 2020)
            - size of approx. 2gb 
            - cat for 'movies_x265'
        allowed cat tags: #{inspect(Map.keys(IpfxRarbg.CmdParser.catmap()))}
        """)

        loop(conn)

      cmd ->
        process_cmd(conn, cmd)
        |> loop()
    end
  end

  @tags ~w(title cat year size)a
  def process_cmd(conn, string_of_cmds) when is_binary(string_of_cmds) do
    IpfxRarbg.CmdParser.criteria_tv(string_of_cmds, @tags)
    |> IpfxRarbg.DBQuery.prepare_statement(conn)
    |> IpfxRarbg.DBQuery.step_rows(conn, [])
    |> IpfxRarbg.Display.display()

    conn
  rescue
    error ->
      "error with cmd: '#{string_of_cmds}, #{inspect(error)}'"
  end
end
