defmodule Omblog.OMPosts do
  @moduledoc """
  The OMPosts context.
  """

  import Ecto.Query, warn: false
  alias Omblog.Repo

  alias Omblog.OMPosts.OMPost

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%OMPost{}, ...]

  """
  def list_posts do
    Repo.all(OMPost)
  end

  @doc """
  Gets a single om_post.

  Raises `Ecto.NoResultsError` if the Om post does not exist.

  ## Examples

      iex> get_om_post!(123)
      %OMPost{}

      iex> get_om_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_om_post!(id), do: Repo.get!(OMPost, id)

  @doc """
  Creates a om_post.

  ## Examples

      iex> create_om_post(%{field: value})
      {:ok, %OMPost{}}

      iex> create_om_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_om_post(attrs) do
    %OMPost{}
    |> OMPost.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a om_post.

  ## Examples

      iex> update_om_post(om_post, %{field: new_value})
      {:ok, %OMPost{}}

      iex> update_om_post(om_post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_om_post(%OMPost{} = om_post, attrs) do
    om_post
    |> OMPost.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a om_post.

  ## Examples

      iex> delete_om_post(om_post)
      {:ok, %OMPost{}}

      iex> delete_om_post(om_post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_om_post(%OMPost{} = om_post) do
    Repo.delete(om_post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking om_post changes.

  ## Examples

      iex> change_om_post(om_post)
      %Ecto.Changeset{data: %OMPost{}}

  """
  def change_om_post(%OMPost{} = om_post, attrs \\ %{}) do
    OMPost.changeset(om_post, attrs)
  end
end
