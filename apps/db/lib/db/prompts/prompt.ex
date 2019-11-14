defmodule GifMe.DB.Prompts.Prompt do
  use GifMe.DB.Schema

  @required_fields ~w(type source url)a

  schema "prompts" do
    field(:type, :string) # e.g. tweet, article, image
    field(:source, :string) # e.g. twitter, cnn.com, reddit.com
    field(:url, :string)
  end

  def changeset(prompt, params \\ %{}) do
    prompt
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:url)
  end
end
