defmodule Omblog.Repo do
  use Ecto.Repo,
    otp_app: :omblog,
    adapter: Ecto.Adapters.Postgres
end
