defmodule Omblog.OMPostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Omblog.OMPosts` context.
  """

  @doc """
  Generate a om_post.
  """
  def om_post_fixture(attrs \\ %{}) do
    {:ok, om_post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> Omblog.OMPosts.create_om_post()

    om_post
  end
end
