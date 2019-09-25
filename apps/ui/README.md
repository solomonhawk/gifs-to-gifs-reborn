# Ui

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Set Up

From the `apps/ui/assets` folder:

1. **Install `yarn` dependencies**

        yarn install

2. **Configure environment variables**

        cp .env.example .env

    After creating `.env` you may need to fill in any missing values.

3. **For local development, start the webpack server**

        yarn watch

    Alternatively, from the root folder of the project you can simply run `make assets`.