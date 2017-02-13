# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :litmus_test,
  ecto_repos: [LitmusTest.Repo]

# Configures the endpoint
config :litmus_test, LitmusTest.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WR4wE3GYJ90o9SAo2wPVsemVqjQHiBrpksFqmc0sAbFgM5tdfbsNoO5BrEkY8NsA",
  render_errors: [view: LitmusTest.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LitmusTest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
