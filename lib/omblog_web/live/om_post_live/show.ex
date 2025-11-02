defmodule OmblogWeb.OMPostLive.Show do
  use OmblogWeb, :live_view

  alias Omblog.OMPosts

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Om post {@om_post.id}
        <:subtitle>This is a om_post record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/posts"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/posts/#{@om_post}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit om_post
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@om_post.title}</:item>
        <:item title="Body">{@om_post.body}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Om post")
     |> assign(:om_post, OMPosts.get_om_post!(id))}
  end
end
