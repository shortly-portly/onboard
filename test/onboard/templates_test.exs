defmodule Onboard.TemplatesTest do
  use Onboard.DataCase

  alias Onboard.Templates
  alias Onboard.Documents

  describe "templates" do
    alias Onboard.Templates.Template
    alias Onboard.TemplateDoc

    @valid_attrs %{name: "some name", documents: []}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def template_fixture(attrs \\ %{}) do
      {:ok, template} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Templates.create_template()

      template
    end

    test "list_templates/0 returns all templates" do
      template = template_fixture()
      assert Templates.list_templates() == [template]
    end

    test "get_template!/1 returns the template with given id" do
      template = template_fixture()
      assert Templates.get_template!(template.id) == template
    end

    test "create_template/1 with valid data creates a template" do
      assert {:ok, %Template{} = template} = Templates.create_template(@valid_attrs)
      assert template.name == "some name"
    end

    test "create_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Templates.create_template(@invalid_attrs)
    end

    test "update_template/2 with valid data updates the template" do
      template = template_fixture()
      assert {:ok, %Template{} = template} = Templates.update_template(template, @update_attrs)
      assert template.name == "some updated name"
    end

    test "update_template/2 with invalid data returns error changeset" do
      template = template_fixture()
      assert {:error, %Ecto.Changeset{}} = Templates.update_template(template, @invalid_attrs)
      assert template == Templates.get_template!(template.id)
    end

    test "delete_template/1 deletes the template" do
      template = template_fixture()
      assert {:ok, %Template{}} = Templates.delete_template(template)
      assert_raise Ecto.NoResultsError, fn -> Templates.get_template!(template.id) end
    end

    test "change_template/1 returns a template changeset" do
      template = template_fixture()
      assert %Ecto.Changeset{} = Templates.change_template(template)
    end

    test "add_document_to_template/1 adds a document to a template" do
      {:ok, document} = Documents.create_document(%{name: "Document"})
      {:ok, template} = Templates.create_template(%{name: "Template"})

      {:ok, %TemplateDoc{} = _template} =
        Templates.add_document_to_template(%{template_id: template.id, document_id: document.id})

      template = Templates.get_template!(template.id)
      assert length(template.documents) == 1
    end

    test "remove_document_from_template/2 removes a document from a template" do
      {:ok, document} = Documents.create_document(%{name: "Document"})
      {:ok, template} = Templates.create_template(%{name: "Template"})

      {:ok, %TemplateDoc{} = _template} =
        Templates.add_document_to_template(%{template_id: template.id, document_id: document.id})

      template = Templates.get_template!(template.id)
      assert length(template.documents) == 1

      {1, nil} = Templates.remove_document_from_template(template.id, document.id)
    end
  end
end
