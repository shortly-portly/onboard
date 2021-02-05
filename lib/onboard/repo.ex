defmodule Onboard.Repo do
  use Ecto.Repo,
    otp_app: :onboard,
    adapter: Ecto.Adapters.Postgres
end
