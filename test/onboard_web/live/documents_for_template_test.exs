defmodule OnboardWeb.TemplateDocLiveTest do
  use OnboardWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Onboard.Templates
  alias Onboard.Documents

  @template_attrs %{name: "Template"}
  @document_attrs %{name: "Documents"}

  defp fixture(:template) do
    {:ok, template} = Templates.create_template(@template_attrs)
    template
  end

  defp fixture(:document) do
    {:ok, document} = Documents.create_document(@document_attrs)
    document
  end

  defp create_template(_) do
    template = fixture(:template)
    %{template: template}
  end

  defp create_document(_) do
    document = fixture(:document)
    %{document: document}
  end

  describe "documents for templates" do
    setup [:create_document, :create_template]

    test "add a document to a template", %{conn: conn, template: template, document: document} do
      {:ok, view, _html} =
        live(conn, Routes.template_document_edit_path(conn, :edit, template.id))

      view
      |> element("#add-#{document.id}")
      |> render_click()

      assert has_element?(view, "#assigned-documents", document.name)
      refute has_element?(view, "#unassigned-documents", document.name)
    end

    test "remove a document from a template", %{
      conn: conn,
      template: template,
      document: document
    } do
      {:ok, view, _html} =
        live(conn, Routes.template_document_edit_path(conn, :edit, template.id))

      view
      |> element("#add-#{document.id}")
      |> render_click()

      view
      |> element("#remove-#{document.id}")
      |> render_click()

      refute has_element?(view, "#assigned-documents", document.name)
      assert has_element?(view, "#unassigned-documents", document.name)
    end
  end
end
