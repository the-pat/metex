use Mix.Config

config :tesla, adapter: Tesla.Adapter.Hackney

config :metex, weather_api_key: "API KEY"

import_config "config.secret.exs"
