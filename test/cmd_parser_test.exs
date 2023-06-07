defmodule CmdParserTest do
  use ExUnit.Case
  @tags ~w(title cat year size)a

  test "no criteria" do
    assert [title: [], cat: nil, year: nil, size: nil] ==
             IpfxRarbg.CmdParser.criteria_tv("", @tags)
  end

  test "criteria field dt" do
    assert [title: [], cat: nil, year: 2016, size: nil] ==
             IpfxRarbg.CmdParser.criteria_tv("2016y ", @tags)
  end

  test "criteria field cat" do
    assert [title: [], cat: "movies_x265", year: nil, size: nil] ==
             IpfxRarbg.CmdParser.criteria_tv("movies_x265 ", @tags)
  end

  test "criteria field size" do
    assert [title: [], cat: nil, year: nil, size: 555_000_000] ==
             IpfxRarbg.CmdParser.criteria_tv("555mb ", @tags)
  end

  test "criteria field title" do
    assert [title: ["Columbo", "1976"], cat: nil, year: nil, size: nil] ==
             IpfxRarbg.CmdParser.criteria_tv("Columbo 1976 ", @tags)
  end

  test "criteria all fields" do
    assert [title: ["paris", "1972"], cat: "movies_x265", year: 2020, size: 2_000_000_000] ==
             IpfxRarbg.CmdParser.criteria_tv("paris 1972 2020y 2gb movies_x265 ", @tags)
  end
end
