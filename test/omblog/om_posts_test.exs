defmodule Omblog.OMPostsTest do
  use Omblog.DataCase

  alias Omblog.OMPosts

  describe "posts" do
    alias Omblog.OMPosts.OMPost

    import Omblog.OMPostsFixtures

    @invalid_attrs %{title: nil, body: nil}

    test "list_posts/0 returns all posts" do
      om_post = om_post_fixture()
      assert OMPosts.list_posts() == [om_post]
    end

    test "get_om_post!/1 returns the om_post with given id" do
      om_post = om_post_fixture()
      assert OMPosts.get_om_post!(om_post.id) == om_post
    end

    test "create_om_post/1 with valid data creates a om_post" do
      valid_attrs = %{title: "some title", body: "some body"}

      assert {:ok, %OMPost{} = om_post} = OMPosts.create_om_post(valid_attrs)
      assert om_post.title == "some title"
      assert om_post.body == "some body"
    end

    test "create_om_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OMPosts.create_om_post(@invalid_attrs)
    end

    test "update_om_post/2 with valid data updates the om_post" do
      om_post = om_post_fixture()
      update_attrs = %{title: "some updated title", body: "some updated body"}

      assert {:ok, %OMPost{} = om_post} = OMPosts.update_om_post(om_post, update_attrs)
      assert om_post.title == "some updated title"
      assert om_post.body == "some updated body"
    end

    test "update_om_post/2 with invalid data returns error changeset" do
      om_post = om_post_fixture()
      assert {:error, %Ecto.Changeset{}} = OMPosts.update_om_post(om_post, @invalid_attrs)
      assert om_post == OMPosts.get_om_post!(om_post.id)
    end

    test "delete_om_post/1 deletes the om_post" do
      om_post = om_post_fixture()
      assert {:ok, %OMPost{}} = OMPosts.delete_om_post(om_post)
      assert_raise Ecto.NoResultsError, fn -> OMPosts.get_om_post!(om_post.id) end
    end

    test "change_om_post/1 returns a om_post changeset" do
      om_post = om_post_fixture()
      assert %Ecto.Changeset{} = OMPosts.change_om_post(om_post)
    end
  end
end
