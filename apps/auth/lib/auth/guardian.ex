defmodule GifMe.Auth.Guardian do
  use Guardian, otp_app: :auth

  alias GifMe.DB.Accounts

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.find_user(id: id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
