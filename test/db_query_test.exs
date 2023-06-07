defmodule DBQueryTest do
  use ExUnit.Case
  @tags ~w(title cat year size)a

  test "begin_end_year" do
    assert {1_577_836_800, 1_609_459_199} ==
             IpfxRarbg.DBQuery.begin_end_year(2020)
  end

  test "begin_end_size" do
    assert {1_100_000, 900_000} ==
             IpfxRarbg.DBQuery.begin_end_size(1_000_000)
  end

  test "prepare statement" do
    tv = [title: ["paris", "1972"], cat: "movies_x265", year: 2020, size: 2_000_000_000]

    assert {"select title,dt, size, cat, hash from items where title LIKE ?2 AND title LIKE ?1 and cat = ?3 and dt >= ?4 and dt <= ?5 and size > ?6 and size < ?7 ORDER BY dt DESC",
            ["%paris%", "%1972%", 15, 1_577_836_800, 1_609_459_199, 1_800_000_000, 2_200_000_000]} ==
             IpfxRarbg.DBQuery.prepare_stm(
               tv,
               "select title,dt, size, cat, hash from items where ",
               [],
               1
             )
  end
end
