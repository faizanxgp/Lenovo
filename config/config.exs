# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lenovo,
  ecto_repos: [Lenovo.Repo]

# Configures the endpoint
config :lenovo, LenovoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "61H8cZQZGNCUxVwmGdImkmV0L5GBsQE2DuKSM9Xjx+2w3D4qzKzoJPJq8MSsw1np",
  render_errors: [view: LenovoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Lenovo.PubSub,
  live_view: [signing_salt: "R6k1Tj1N"]
#configuratiion for the guardian secret key which was generted by coomand: mix guardian.gen.secret
config :lenovo, Lenovo.UserManger.Guardian,
  issuer: "lenovo",
  secret_key: "IDmaARm5Kx/hKfEgNcGT9bYXHzKrw2DGsMk6HKx4a9HYdGm3BuqixEzZXETflovK"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
