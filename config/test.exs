import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hi, HiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "h5aVmnumks7oG70QdI+y8xDJ172+C6iT9/hkM5bMm7MYyDhMD27222z2wVvTsuzm",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
