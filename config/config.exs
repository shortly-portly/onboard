# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :onboard,
  ecto_repos: [Onboard.Repo]

# Configures the endpoint
config :onboard, OnboardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YWBej+FTz60IvMLc3pLe4xH9L6VdPS+gTc5HLkf0hPV3rAE8q2Mk9zb3cKohx45A",
  render_errors: [view: OnboardWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Onboard.PubSub,
  live_view: [signing_salt: "5dcXUOTE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
