defmodule OmblogWeb.OMPostLive.Form do
  use OmblogWeb, :live_view

  alias Omblog.OMPosts
  alias Omblog.OMPosts.OMPost

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage om_post records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="om_post-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:body]} type="textarea" label="Body" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Om post</.button>
          <.button navigate={return_path(@return_to, @om_post)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    om_post = OMPosts.get_om_post!(id)

    socket
    |> assign(:page_title, "Edit Om post")
    |> assign(:om_post, om_post)
    |> assign(:form, to_form(OMPosts.change_om_post(om_post)))
  end

  defp apply_action(socket, :new, _params) do
    om_post = %OMPost{}

    socket
    |> assign(:page_title, "New Om post")
    |> assign(:om_post, om_post)
    |> assign(:form, to_form(OMPosts.change_om_post(om_post)))
  end

  @impl true
  def handle_event("validate", %{"om_post" => om_post_params}, socket) do
    changeset = OMPosts.change_om_post(socket.assigns.om_post, om_post_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"om_post" => om_post_params}, socket) do
    save_om_post(socket, socket.assigns.live_action, om_post_params)
  end

  defp save_om_post(socket, :edit, om_post_params) do
    case OMPosts.update_om_post(socket.assigns.om_post, om_post_params) do
      {:ok, om_post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Om post updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, om_post))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_om_post(socket, :new, om_post_params) do
    case OMPosts.create_om_post(om_post_params) do
      {:ok, om_post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Om post created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, om_post))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _om_post), do: ~p"/posts"
  defp return_path("show", om_post), do: ~p"/posts/#{om_post}"
end
