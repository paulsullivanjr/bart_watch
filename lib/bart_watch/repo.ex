defmodule BartWatch.Repo do
  use Ecto.Repo,
    otp_app: :bart_watch,
    adapter: Ecto.Adapters.Postgres
end
