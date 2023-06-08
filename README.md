# ipfx_rarbg
[![Test](https://github.com/bougueil/ipfx_rarbg/actions/workflows/ci.yml/badge.svg)](https://github.com/bougueil/ipfx_rarbg/actions/workflows/ci.yml)
<!-- MDOC !-->

`ipfx_rarbg`, a command-line query tool for the [rarbg_db_ipfs.sqlite db](https://ipfs.io/ipfs/QmbpRxBZ5HDZDVRoeAU8xFYnoP4r5eGCxdkmfFW3JbA6mq/).

wip to learn sqlite with elixir.

<!-- MDOC !-->

## Build & run

```
git clone https://github.com/bougueil/ipfx_rarbg
cd ipfx_rarbg ; mix deps.get

### download the rarbg_db_ipfs.sqlite db :
wget -m -nH -np -P rarbg https://ipfs.io/ipfs/QmbpRxBZ5HDZDVRoeAU8xFYnoP4r5eGCxdkmfFW3JbA6mq/

mix query
```
```
IpfxRarbg basic query tool
  q quit - h help - a_query_string like
    paris 1972 2020y 2gb movies_x265

found 2843691 items in ./rarbg/ipfs/QmbpRxBZ5HDZDVRoeAU8xFYnoP4r5eGCxdkmfFW3JbA6mq/rarbg_db_ipfs.sqlite.

ipfx_rarbg> paris 1972 2020y 2gb movies_x265
826A5AC37E88AFD71279FFC2D95FBEE55B5BC96B 2020-07-01 10:19:53 2170.6mb movies_x265 Last.Tango.In.Paris.1972.1080p.BluRay.x265-RARBG
ipfx_rarbg>
```