# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :avatars, AvatarsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hqgou0s7Xp+yLziGQcmqPzBL4T4+FpMOdb7MRH4/rypofPHSc256YemR4goc5mLN",
  render_errors: [view: AvatarsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Avatars.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
