defmodule OnboardWeb.TemplateDocumentLive.Edit do
  use OnboardWeb, :live_view

  alias Onboard.Templates
  alias Onboard.Documents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    template = Templates.get_template!(id)
    documents = Documents.list_documents()

    unassigned_documents = remove_assigned_docs(documents, template.documents)

    {:noreply,
     socket
     |> assign(:page_title, "Add Documents to Template")
     |> assign(:template, template)
     |> assign(:documents, unassigned_documents)}
  end

  @impl true
  def handle_event("remove-document", %{"document-id" => document_id}, socket) do
    Templates.remove_document_from_template(
      socket.assigns.template.id,
      String.to_integer(document_id)
    )

    template = Templates.get_template!(socket.assigns.template.id)
    documents = Documents.list_documents()

    unassigned_documents = remove_assigned_docs(documents, template.documents)

    {:noreply,
     socket
     |> assign(:template, template)
     |> assign(:documents, unassigned_documents)}
  end

  def handle_event("add-document", %{"document-id" => document_id}, socket) do
    Templates.add_document_to_template(%{
      template_id: socket.assigns.template.id,
      document_id: document_id
    })

    template = Templates.get_template!(socket.assigns.template.id)
    documents = Documents.list_documents()

    unassigned_documents = remove_assigned_docs(documents, template.documents)

    {:noreply,
     socket
     |> assign(:template, template)
     |> assign(:documents, unassigned_documents)}
  end

  defp remove_assigned_docs(documents, assigned_documents) do
    Enum.reject(documents, fn document -> Enum.member?(assigned_documents, document) end)
  end
end
