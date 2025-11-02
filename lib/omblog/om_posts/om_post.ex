defmodule Omblog.OMPosts.OMPost do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :body, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(om_post, attrs) do
    om_post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
