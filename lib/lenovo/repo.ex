defmodule Lenovo.Repo do
  use Ecto.Repo,
    otp_app: :lenovo,
    adapter: Ecto.Adapters.Postgres
end
