import Config

config :ipfx_rarbg,
  sqlite_db_path:
    "./rarbg/ipfs/QmbpRxBZ5HDZDVRoeAU8xFYnoP4r5eGCxdkmfFW3JbA6mq/rarbg_db_ipfs.sqlite"

# sqlite_db_path: "./rarbg_db.sqlite"

import_config "#{config_env()}.exs"
