# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

## Build Info
config :hi,
  build_mode: config_env(),
  build_time: DateTime.utc_now(),
  source_url: Mix.Project.config()[:source_url],
  commit_id: System.get_env("GIT_COMMIT_ID", ""),
  commit_time: System.get_env("GIT_COMMIT_TIME", "")

config :hi,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :hi, HiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: HiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Hi.PubSub,
  live_view: [signing_salt: "L/y0po/f"]

# Configures Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
