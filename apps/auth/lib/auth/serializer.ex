defmodule GifMe.Auth.Serializer do
  alias GifMe.DB.Accounts
  alias GifMe.DB.Accounts.User

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> id), do: {:ok, Accounts.find_user(id: id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
