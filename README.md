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

