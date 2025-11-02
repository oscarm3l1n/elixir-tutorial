defmodule OmblogWeb.OMPostLiveTest do
  use OmblogWeb.ConnCase

  import Phoenix.LiveViewTest
  import Omblog.OMPostsFixtures

  @create_attrs %{title: "some title", body: "some body"}
  @update_attrs %{title: "some updated title", body: "some updated body"}
  @invalid_attrs %{title: nil, body: nil}
  defp create_om_post(_) do
    om_post = om_post_fixture()

    %{om_post: om_post}
  end

  describe "Index" do
    setup [:create_om_post]

    test "lists all posts", %{conn: conn, om_post: om_post} do
      {:ok, _index_live, html} = live(conn, ~p"/posts")

      assert html =~ "Listing Posts"
      assert html =~ om_post.title
    end

    test "saves new om_post", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/posts")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Om post")
               |> render_click()
               |> follow_redirect(conn, ~p"/posts/new")

      assert render(form_live) =~ "New Om post"

      assert form_live
             |> form("#om_post-form", om_post: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#om_post-form", om_post: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/posts")

      html = render(index_live)
      assert html =~ "Om post created successfully"
      assert html =~ "some title"
    end

    test "updates om_post in listing", %{conn: conn, om_post: om_post} do
      {:ok, index_live, _html} = live(conn, ~p"/posts")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#posts-#{om_post.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/posts/#{om_post}/edit")

      assert render(form_live) =~ "Edit Om post"

      assert form_live
             |> form("#om_post-form", om_post: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#om_post-form", om_post: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/posts")

      html = render(index_live)
      assert html =~ "Om post updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes om_post in listing", %{conn: conn, om_post: om_post} do
      {:ok, index_live, _html} = live(conn, ~p"/posts")

      assert index_live |> element("#posts-#{om_post.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#posts-#{om_post.id}")
    end
  end

  describe "Show" do
    setup [:create_om_post]

    test "displays om_post", %{conn: conn, om_post: om_post} do
      {:ok, _show_live, html} = live(conn, ~p"/posts/#{om_post}")

      assert html =~ "Show Om post"
      assert html =~ om_post.title
    end

    test "updates om_post and returns to show", %{conn: conn, om_post: om_post} do
      {:ok, show_live, _html} = live(conn, ~p"/posts/#{om_post}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/posts/#{om_post}/edit?return_to=show")

      assert render(form_live) =~ "Edit Om post"

      assert form_live
             |> form("#om_post-form", om_post: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#om_post-form", om_post: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/posts/#{om_post}")

      html = render(show_live)
      assert html =~ "Om post updated successfully"
      assert html =~ "some updated title"
    end
  end
end
