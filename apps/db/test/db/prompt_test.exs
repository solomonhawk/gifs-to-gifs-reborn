defmodule GifMe.DB.PromptTest do
  use GifMe.DB.DataCase, async: true

  alias GifMe.DB.Prompts
  alias GifMe.DB.Prompts.Prompt

  @valid_attrs %{type: "tweet", source: "twitter", url: "https://twitter.com/tweet/1"}
  @invalid_attrs %{type: nil, source: nil, url: nil}

  test "create_prompt/1 with valid data creates a prompt" do
    assert {:ok, %Prompt{}} = Prompts.create_prompt(@valid_attrs)
  end

  test "create_prompt/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Prompts.create_prompt(@invalid_attrs)
  end

  test "type can't be blank" do
    assert {:error, %Ecto.Changeset{} = changeset} =
             Prompts.create_prompt(Map.delete(@valid_attrs, :type))

    assert %{type: ["can't be blank"]} = errors_on(changeset)
  end

  test "source can't be blank" do
    assert {:error, %Ecto.Changeset{} = changeset} =
             Prompts.create_prompt(Map.delete(@valid_attrs, :source))

    assert %{source: ["can't be blank"]} = errors_on(changeset)
  end

  test "url can't be blank" do
    assert {:error, %Ecto.Changeset{} = changeset} =
             Prompts.create_prompt(Map.delete(@valid_attrs, :url))

    assert %{url: ["can't be blank"]} = errors_on(changeset)
  end

  test "validates uniqueness of url" do
    assert {:ok, %Prompt{}} = Prompts.create_prompt(@valid_attrs)
    assert {:error, %Ecto.Changeset{} = changeset} = Prompts.create_prompt(@valid_attrs)
    assert %{url: ["has already been taken"]} = errors_on(changeset)
  end
end
