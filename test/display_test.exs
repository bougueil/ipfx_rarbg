defmodule DisplayTest do
  use ExUnit.Case

  test "row" do
    assert "826A5AC37E88AFD71279FFC2D95FBEE55B5BC96B 2020-07-01 10:19:53 2170.6mb Last.Tango.In.Paris.1972.1080p.BluRay.x265-RARBG cat: movies_x265" ==
             IpfxRarbg.Display.row([
               "Last.Tango.In.Paris.1972.1080p.BluRay.x265-RARBG",
               1_593_598_793,
               2_170_552_320,
               15,
               <<130, 106, 90, 195, 126, 136, 175, 215, 18, 121, 255, 194, 217, 95, 190, 229, 91,
                 91, 201, 107>>
             ])
  end

  test "display" do
    assert :ok ==
             IpfxRarbg.Display.display(["aaa", "bbb"])
  end
end
