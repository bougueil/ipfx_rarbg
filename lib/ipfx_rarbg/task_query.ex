defmodule Mix.Tasks.Query do
  use Mix.Task
  @moduledoc false

  def run(_) do
    IpfxRarbg.main(1)
  end
end
