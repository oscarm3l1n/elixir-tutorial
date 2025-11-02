defmodule OmblogWeb.OMPostLive.Index do
  use OmblogWeb, :live_view

  alias Omblog.OMPosts

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Posts
        <:actions>
          <.button variant="primary" navigate={~p"/posts/new"}>
            <.icon name="hero-plus" /> New Om post
          </.button>
        </:actions>
      </.header>

      <.table
        id="posts"
        rows={@streams.posts}
        row_click={fn {_id, om_post} -> JS.navigate(~p"/posts/#{om_post}") end}
      >
        <:col :let={{_id, om_post}} label="Title">{om_post.title}</:col>
        <:col :let={{_id, om_post}} label="Body">{om_post.body}</:col>
        <:action :let={{_id, om_post}}>
          <div class="sr-only">
            <.link navigate={~p"/posts/#{om_post}"}>Show</.link>
          </div>
          <.link navigate={~p"/posts/#{om_post}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, om_post}}>
          <.link
            phx-click={JS.push("delete", value: %{id: om_post.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Posts")
     |> stream(:posts, list_posts())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    om_post = OMPosts.get_om_post!(id)
    {:ok, _} = OMPosts.delete_om_post(om_post)

    {:noreply, stream_delete(socket, :posts, om_post)}
  end

  defp list_posts() do
    OMPosts.list_posts()
  end
end
