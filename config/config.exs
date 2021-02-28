# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rocketpay,
  ecto_repos: [Rocketpay.Repo]

# Configures the endpoint
config :rocketpay, RocketpayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EngoNCX8JUY/Y6nlbF4Wv7pWXLX97RHyqF91QPa3aw/LPEq4axvKkhIy9k/yPJgd",
  render_errors: [view: RocketpayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rocketpay.PubSub,
  live_view: [signing_salt: "h+J510An"]

config :rocketpay, Rocketpay.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Basic Auth
config :rocketpay, :basic_auth,
  username: "gf7JyN04WkNm",
  password: "toeFRzFXftLj"

# Bearer Token
config :rocketpay, Rocketpay.Guardian,
      issuer: "rocketpay",
      #  Secret key. You can use `mix guardian.gen.secret` to get one
      secret_key: "AncB/PpTK8WfyiUXJsfn8z2mEvPBh5uX4akT765ZyDZO+sOjL6cvNlaam/P0foq3"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
