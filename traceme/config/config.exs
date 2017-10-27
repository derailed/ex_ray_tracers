# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :traceme,
  ecto_repos: [Traceme.Repo]

# Configures the endpoint
config :traceme, TracemeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xOm9qOb2m5ZkkpgdxxUZ59YpEQhof6gW7Rmxebh8UZu3rINf/eCf7lsdv5AgJQ+J",
  render_errors: [view: TracemeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Traceme.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
