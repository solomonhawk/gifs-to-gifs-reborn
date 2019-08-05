searchNodes=[{"ref":"GameApp.Game.html","title":"GameApp.Game","type":"module","doc":"GameApp.Game defines a struct that encapsulates game state as well as many functions that advance the game state based on actions that players can take."},{"ref":"GameApp.Game.html#create/2","title":"GameApp.Game.create/2","type":"function","doc":"Creates a game. Examples iex&gt; Game.create(&quot;ABCD&quot;, Player.create(&quot;1&quot;, &quot;Gamer&quot;)) %Game{ shortcode: &quot;ABCD&quot;, creator: %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}, players: %{&quot;1&quot; =&gt; %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}}, scores: %{&quot;1&quot; =&gt; 0} }"},{"ref":"GameApp.Game.html#player_join/2","title":"GameApp.Game.player_join/2","type":"function","doc":"Adds a player to a game. Examples iex&gt; g = Game.create(&quot;ABCD&quot;, Player.create(&quot;1&quot;, &quot;Gamer&quot;)) iex&gt; Game.player_join(g, Player.create(&quot;2&quot;, &quot;Gamer2&quot;)) %Game{ shortcode: &quot;ABCD&quot;, creator: %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}, players: %{ &quot;1&quot; =&gt; %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}, &quot;2&quot; =&gt; %Player{id: &quot;2&quot;, name: &quot;Gamer2&quot;} }, scores: %{&quot;1&quot; =&gt; 0, &quot;2&quot; =&gt; 0} }"},{"ref":"GameApp.Game.html#player_leave/2","title":"GameApp.Game.player_leave/2","type":"function","doc":"Removes a player from a game. Removing a player doesn&#39;t remove their score which allows for a player to possibly leave and rejoin a game in progress without losing their prior points. Examples iex&gt; p1 = Player.create(&quot;1&quot;, &quot;Gamer&quot;) iex&gt; p2 = Player.create(&quot;2&quot;, &quot;Gamer2&quot;) iex&gt; g = Game.create(&quot;ABCD&quot;, p1) iex&gt; g = Game.player_join(g, p2) iex&gt; Game.player_leave(g, p2) %Game{ shortcode: &quot;ABCD&quot;, creator: %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}, players: %{&quot;1&quot; =&gt; %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}}, scores: %{&quot;1&quot; =&gt; 0, &quot;2&quot; =&gt; 0} }"},{"ref":"GameApp.Game.html#select_prompt/2","title":"GameApp.Game.select_prompt/2","type":"function","doc":"Assigns a prompt to the current round."},{"ref":"GameApp.Game.html#select_reaction/3","title":"GameApp.Game.select_reaction/3","type":"function","doc":"Adds a reaction in the current round for the given player."},{"ref":"GameApp.Game.html#select_round_winner/2","title":"GameApp.Game.select_round_winner/2","type":"function","doc":"Starts prompt selection for the current round."},{"ref":"GameApp.Game.html#start_game/1","title":"GameApp.Game.start_game/1","type":"function","doc":"Starts a game. Examples iex&gt; g = Game.create(&quot;ABCD&quot;, Player.create(&quot;1&quot;, &quot;Gamer&quot;)) iex&gt; Game.start_game(g) %Game{ shortcode: &quot;ABCD&quot;, phase: :game_start, creator: %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}, players: %{&quot;1&quot; =&gt; %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}}, scores: %{&quot;1&quot; =&gt; 0} }"},{"ref":"GameApp.Game.html#start_prompt_selection/1","title":"GameApp.Game.start_prompt_selection/1","type":"function","doc":"Starts prompt selection for the current round."},{"ref":"GameApp.Game.html#start_round/1","title":"GameApp.Game.start_round/1","type":"function","doc":"Starts a round. Examples iex&gt; g = Game.create(&quot;ABCD&quot;, Player.create(&quot;1&quot;, &quot;Gamer&quot;)) iex&gt; Game.start_game(g) %Game{ shortcode: &quot;ABCD&quot;, phase: :game_start, creator: %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}, players: %{&quot;1&quot; =&gt; %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}}, scores: %{&quot;1&quot; =&gt; 0} }"},{"ref":"GameApp.Game.html#summary/1","title":"GameApp.Game.summary/1","type":"function","doc":"Returns a summary of the game state. Examples iex&gt; g = Game.create(&quot;ABCD&quot;, Player.create(&quot;1&quot;, &quot;Gamer&quot;)) iex&gt; Game.summary(g) %{ creator: %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}, funmaster: nil, phase: :lobby, players: %{&quot;1&quot; =&gt; %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}}, prompt: nil, reactions: nil, round_number: nil, scores: %{&quot;1&quot; =&gt; 0}, shortcode: &quot;ABCD&quot;, winner: nil }"},{"ref":"GameApp.Game.html#t:game_state/0","title":"GameApp.Game.game_state/0","type":"type","doc":""},{"ref":"GameApp.Game.html#t:t/0","title":"GameApp.Game.t/0","type":"type","doc":""},{"ref":"GameApp.Player.html","title":"GameApp.Player","type":"module","doc":"A player in the game."},{"ref":"GameApp.Player.html#create/2","title":"GameApp.Player.create/2","type":"function","doc":"Creates a player."},{"ref":"GameApp.Player.html#t:t/0","title":"GameApp.Player.t/0","type":"type","doc":""},{"ref":"GameApp.Round.html","title":"GameApp.Round","type":"module","doc":"GameApp.Round defines a struct that encapsulates Round state as well as functions that update the round state."},{"ref":"GameApp.Round.html#create/1","title":"GameApp.Round.create/1","type":"function","doc":"Creates a round for the given round number. Examples iex&gt; Round.create(1) %Round{ number: 1, winner: nil, reactions: %{} }"},{"ref":"GameApp.Round.html#remove_reaction/2","title":"GameApp.Round.remove_reaction/2","type":"function","doc":"Removes the reaction for a player in a round. Examples iex&gt; r = Round.create(1) iex&gt; p = Player.create(&quot;1&quot;, &quot;Gamer&quot;) iex&gt; r = Round.set_reaction(r, p, &quot;OMG!&quot;) iex&gt; Round.remove_reaction(r, p) %Round{ number: 1, winner: nil, reactions: %{} }"},{"ref":"GameApp.Round.html#set_prompt/2","title":"GameApp.Round.set_prompt/2","type":"function","doc":"Sets the prompt for a round. Examples iex&gt; r = Round.create(1) iex&gt; Round.set_prompt(r, &quot;Wat&quot;) %Round{ number: 1, prompt: &quot;Wat&quot;, winner: nil, reactions: %{} }"},{"ref":"GameApp.Round.html#set_reaction/3","title":"GameApp.Round.set_reaction/3","type":"function","doc":"Sets the reaction for a player in a round. Examples iex&gt; r = Round.create(1) iex&gt; Round.set_reaction(r, Player.create(&quot;1&quot;, &quot;Gamer&quot;), &quot;OMG!&quot;) %Round{ number: 1, winner: nil, reactions: %{ &quot;1&quot; =&gt; &quot;OMG!&quot; } }"},{"ref":"GameApp.Round.html#set_winner/2","title":"GameApp.Round.set_winner/2","type":"function","doc":"Sets the winner for a round. Examples iex&gt; r = Round.create(1) iex&gt; Round.set_winner(r, Player.create(&quot;1&quot;, &quot;Gamer&quot;)) %Round{ number: 1, winner: %Player{id: &quot;1&quot;, name: &quot;Gamer&quot;}, reactions: %{} }"},{"ref":"GameApp.Round.html#t:t/0","title":"GameApp.Round.t/0","type":"type","doc":""},{"ref":"GameApp.Server.html","title":"GameApp.Server","type":"module","doc":"GameApp.Server provides a stateful process that maintains an internal game state and provides a public API for interacting with the game."},{"ref":"GameApp.Server.html#child_spec/1","title":"GameApp.Server.child_spec/1","type":"function","doc":"Returns a specification to start this module under a supervisor. See Supervisor."},{"ref":"GameApp.Server.html#game_pid/1","title":"GameApp.Server.game_pid/1","type":"function","doc":"Returns the pid of the game server process registered under the given shortcode, or nil if no process is registered."},{"ref":"GameApp.Server.html#generate_shortcode/0","title":"GameApp.Server.generate_shortcode/0","type":"function","doc":"Generates a 4-letter code used as the identifier for a game server."},{"ref":"GameApp.Server.html#join/2","title":"GameApp.Server.join/2","type":"function","doc":"Joins a player to the game with the given shortcode."},{"ref":"GameApp.Server.html#leave/2","title":"GameApp.Server.leave/2","type":"function","doc":"Removes a player from the game with the given shortcode."},{"ref":"GameApp.Server.html#start_game/1","title":"GameApp.Server.start_game/1","type":"function","doc":"Starts the game with the given shortcode."},{"ref":"GameApp.Server.html#start_link/2","title":"GameApp.Server.start_link/2","type":"function","doc":""},{"ref":"GameApp.Server.html#start_round/1","title":"GameApp.Server.start_round/1","type":"function","doc":"Starts the next round for the game with the given shortcode."},{"ref":"GameApp.Server.html#summary/1","title":"GameApp.Server.summary/1","type":"function","doc":"Returns a summary of the game state for a game with the given shortcode."},{"ref":"GameApp.Server.html#via_tuple/1","title":"GameApp.Server.via_tuple/1","type":"function","doc":"Returns a tuple used to register and lookup a game server process by name."},{"ref":"GameApp.ServerSupervisor.html","title":"GameApp.ServerSupervisor","type":"module","doc":"A dynamic supervisor that supervises child GameApp.Server processes."},{"ref":"GameApp.ServerSupervisor.html#child_spec/1","title":"GameApp.ServerSupervisor.child_spec/1","type":"function","doc":"Returns a specification to start this module under a supervisor. See Supervisor."},{"ref":"GameApp.ServerSupervisor.html#start_game/2","title":"GameApp.ServerSupervisor.start_game/2","type":"function","doc":"Starts a game server with the given shortcode and creator(player). Returns {:ok, pid} or {:error, any}. Examples iex&gt; GameApp.ServerSupervisor.start_game(&quot;ABCD&quot;, %{id: &quot;Gamer&quot;}) {:ok, pid}"},{"ref":"GameApp.ServerSupervisor.html#start_link/1","title":"GameApp.ServerSupervisor.start_link/1","type":"function","doc":""},{"ref":"GameApp.ServerSupervisor.html#stop_game/1","title":"GameApp.ServerSupervisor.stop_game/1","type":"function","doc":"Stops a game server with the given shortcode. Returns :ok or {:error, :not_found}."},{"ref":"Ui.html","title":"Ui","type":"module","doc":"The entrypoint for defining your web interface, such as controllers, views, channels and so on. This can be used in your application as: use Ui, :controller use Ui, :view The definitions below will be executed for every view, controller, etc, so keep them short and clean, focused on imports, uses and aliases. Do NOT define functions inside the quoted expressions below. Instead, define any helper function in modules and import those modules here."},{"ref":"Ui.html#__using__/1","title":"Ui.__using__/1","type":"macro","doc":"When used, dispatch to the appropriate controller/view/etc."},{"ref":"Ui.html#channel/0","title":"Ui.channel/0","type":"function","doc":""},{"ref":"Ui.html#controller/0","title":"Ui.controller/0","type":"function","doc":""},{"ref":"Ui.html#router/0","title":"Ui.router/0","type":"function","doc":""},{"ref":"Ui.html#view/0","title":"Ui.view/0","type":"function","doc":""},{"ref":"Ui.Endpoint.html","title":"Ui.Endpoint","type":"module","doc":""},{"ref":"Ui.Endpoint.html#broadcast/3","title":"Ui.Endpoint.broadcast/3","type":"function","doc":"Broadcasts a msg as event in the given topic. Callback implementation for Phoenix.Endpoint.broadcast/3."},{"ref":"Ui.Endpoint.html#broadcast!/3","title":"Ui.Endpoint.broadcast!/3","type":"function","doc":"Broadcasts a msg as event in the given topic. Raises in case of failures. Callback implementation for Phoenix.Endpoint.broadcast!/3."},{"ref":"Ui.Endpoint.html#broadcast_from/4","title":"Ui.Endpoint.broadcast_from/4","type":"function","doc":"Broadcasts a msg from the given from as event in the given topic. Callback implementation for Phoenix.Endpoint.broadcast_from/4."},{"ref":"Ui.Endpoint.html#broadcast_from!/4","title":"Ui.Endpoint.broadcast_from!/4","type":"function","doc":"Broadcasts a msg from the given from as event in the given topic. Raises in case of failures. Callback implementation for Phoenix.Endpoint.broadcast_from!/4."},{"ref":"Ui.Endpoint.html#call/2","title":"Ui.Endpoint.call/2","type":"function","doc":"Callback implementation for Plug.call/2."},{"ref":"Ui.Endpoint.html#child_spec/1","title":"Ui.Endpoint.child_spec/1","type":"function","doc":"Returns the child specification to start the endpoint under a supervision tree."},{"ref":"Ui.Endpoint.html#config/2","title":"Ui.Endpoint.config/2","type":"function","doc":"Returns the endpoint configuration for key Returns default if the key does not exist."},{"ref":"Ui.Endpoint.html#config_change/2","title":"Ui.Endpoint.config_change/2","type":"function","doc":"Reloads the configuration given the application environment changes."},{"ref":"Ui.Endpoint.html#host/0","title":"Ui.Endpoint.host/0","type":"function","doc":"Returns the host for the given endpoint."},{"ref":"Ui.Endpoint.html#init/1","title":"Ui.Endpoint.init/1","type":"function","doc":"Callback implementation for Plug.init/1."},{"ref":"Ui.Endpoint.html#instrument/3","title":"Ui.Endpoint.instrument/3","type":"macro","doc":"Instruments the given function. event is the event identifier (usually an atom) that specifies which instrumenting function to call in the instrumenter modules. runtime is metadata to be associated with the event at runtime (e.g., the query being issued if the event to instrument is a DB query). Examples instrument :render_view, %{view: &quot;index.html&quot;}, fn -&gt; render(conn, &quot;index.html&quot;) end"},{"ref":"Ui.Endpoint.html#path/1","title":"Ui.Endpoint.path/1","type":"function","doc":"Generates the path information when routing to this endpoint."},{"ref":"Ui.Endpoint.html#script_name/0","title":"Ui.Endpoint.script_name/0","type":"function","doc":"Generates the script name."},{"ref":"Ui.Endpoint.html#start_link/1","title":"Ui.Endpoint.start_link/1","type":"function","doc":"Starts the endpoint supervision tree."},{"ref":"Ui.Endpoint.html#static_integrity/1","title":"Ui.Endpoint.static_integrity/1","type":"function","doc":"Generates a base64-encoded cryptographic hash (sha512) to a static file in priv/static. Meant to be used for Subresource Integrity with CDNs."},{"ref":"Ui.Endpoint.html#static_lookup/1","title":"Ui.Endpoint.static_lookup/1","type":"function","doc":"Returns a two item tuple with the first item being the static_path and the second item being the static_integrity."},{"ref":"Ui.Endpoint.html#static_path/1","title":"Ui.Endpoint.static_path/1","type":"function","doc":"Generates a route to a static file in priv/static."},{"ref":"Ui.Endpoint.html#static_url/0","title":"Ui.Endpoint.static_url/0","type":"function","doc":"Generates the static URL without any path information. It uses the configuration under :static_url to generate such. It falls back to :url if :static_url is not set."},{"ref":"Ui.Endpoint.html#struct_url/0","title":"Ui.Endpoint.struct_url/0","type":"function","doc":"Generates the endpoint base URL but as a URI struct. It uses the configuration under :url to generate such. Useful for manipulating the URL data and passing it to URL helpers."},{"ref":"Ui.Endpoint.html#subscribe/1","title":"Ui.Endpoint.subscribe/1","type":"function","doc":""},{"ref":"Ui.Endpoint.html#subscribe/3","title":"Ui.Endpoint.subscribe/3","type":"function","doc":""},{"ref":"Ui.Endpoint.html#unsubscribe/1","title":"Ui.Endpoint.unsubscribe/1","type":"function","doc":"Unsubscribes the caller from the given topic. Callback implementation for Phoenix.Endpoint.unsubscribe/1."},{"ref":"Ui.Endpoint.html#url/0","title":"Ui.Endpoint.url/0","type":"function","doc":"Generates the endpoint base URL without any path information. It uses the configuration under :url to generate such."},{"ref":"Ui.ErrorHelpers.html","title":"Ui.ErrorHelpers","type":"module","doc":"Conveniences for translating and building error messages."},{"ref":"Ui.ErrorHelpers.html#error_tag/2","title":"Ui.ErrorHelpers.error_tag/2","type":"function","doc":"Generates tag for inlined form input errors."},{"ref":"Ui.ErrorHelpers.html#translate_error/1","title":"Ui.ErrorHelpers.translate_error/1","type":"function","doc":"Translates an error message using gettext."},{"ref":"Ui.ErrorView.html","title":"Ui.ErrorView","type":"module","doc":""},{"ref":"Ui.ErrorView.html#__phoenix_recompile__?/0","title":"Ui.ErrorView.__phoenix_recompile__?/0","type":"function","doc":"Returns true whenever the list of templates changes in the filesystem."},{"ref":"Ui.ErrorView.html#__resource__/0","title":"Ui.ErrorView.__resource__/0","type":"function","doc":"The resource name, as an atom, for this view"},{"ref":"Ui.ErrorView.html#__templates__/0","title":"Ui.ErrorView.__templates__/0","type":"function","doc":"Returns the template root alongside all templates."},{"ref":"Ui.ErrorView.html#render/2","title":"Ui.ErrorView.render/2","type":"function","doc":"Renders the given template locally."},{"ref":"Ui.ErrorView.html#template_not_found/2","title":"Ui.ErrorView.template_not_found/2","type":"function","doc":"Callback invoked when no template is found. By default it raises but can be customized to render a particular template."},{"ref":"Ui.GameChannel.html","title":"Ui.GameChannel","type":"module","doc":""},{"ref":"Ui.GameChannel.html#handle_info/2","title":"Ui.GameChannel.handle_info/2","type":"function","doc":"Handle regular Elixir process messages. See GenServer.handle_info/2. Callback implementation for Phoenix.Channel.handle_info/2."},{"ref":"Ui.GameChannel.html#join/3","title":"Ui.GameChannel.join/3","type":"function","doc":"Handle channel joins by topic. To authorize a socket, return {:ok, socket} or {:ok, reply, socket}. To refuse authorization, return {:error, reason}. Example def join(&quot;room:lobby&quot;, payload, socket) do if authorized?(payload) do {:ok, socket} else {:error, %{reason: &quot;unauthorized&quot;}} end end Callback implementation for Phoenix.Channel.join/3."},{"ref":"Ui.GameChannel.html#start_link/1","title":"Ui.GameChannel.start_link/1","type":"function","doc":""},{"ref":"Ui.GameController.html","title":"Ui.GameController","type":"module","doc":""},{"ref":"Ui.GameController.html#create/2","title":"Ui.GameController.create/2","type":"function","doc":""},{"ref":"Ui.GameController.html#join/2","title":"Ui.GameController.join/2","type":"function","doc":""},{"ref":"Ui.GameController.html#new/2","title":"Ui.GameController.new/2","type":"function","doc":""},{"ref":"Ui.GameController.html#show/2","title":"Ui.GameController.show/2","type":"function","doc":""},{"ref":"Ui.GameView.html","title":"Ui.GameView","type":"module","doc":""},{"ref":"Ui.GameView.html#__phoenix_recompile__?/0","title":"Ui.GameView.__phoenix_recompile__?/0","type":"function","doc":"Returns true whenever the list of templates changes in the filesystem."},{"ref":"Ui.GameView.html#__resource__/0","title":"Ui.GameView.__resource__/0","type":"function","doc":"The resource name, as an atom, for this view"},{"ref":"Ui.GameView.html#__templates__/0","title":"Ui.GameView.__templates__/0","type":"function","doc":"Returns the template root alongside all templates."},{"ref":"Ui.GameView.html#render/2","title":"Ui.GameView.render/2","type":"function","doc":"Renders the given template locally."},{"ref":"Ui.GameView.html#template_not_found/2","title":"Ui.GameView.template_not_found/2","type":"function","doc":"Callback invoked when no template is found. By default it raises but can be customized to render a particular template."},{"ref":"Ui.Gettext.html","title":"Ui.Gettext","type":"module","doc":"A module providing Internationalization with a gettext-based API. By using Gettext, your module gains a set of macros for translations, for example: import Ui.Gettext # Simple translation gettext(&quot;Here is the string to translate&quot;) # Plural translation ngettext(&quot;Here is the string to translate&quot;, &quot;Here are the strings to translate&quot;, 3) # Domain-based translation dgettext(&quot;errors&quot;, &quot;Here is the error message to translate&quot;) See the Gettext Docs for detailed usage."},{"ref":"Ui.Gettext.html#dgettext/3","title":"Ui.Gettext.dgettext/3","type":"macro","doc":""},{"ref":"Ui.Gettext.html#dgettext_noop/2","title":"Ui.Gettext.dgettext_noop/2","type":"macro","doc":""},{"ref":"Ui.Gettext.html#dngettext/5","title":"Ui.Gettext.dngettext/5","type":"macro","doc":""},{"ref":"Ui.Gettext.html#dngettext_noop/3","title":"Ui.Gettext.dngettext_noop/3","type":"macro","doc":""},{"ref":"Ui.Gettext.html#gettext/2","title":"Ui.Gettext.gettext/2","type":"macro","doc":""},{"ref":"Ui.Gettext.html#gettext_comment/1","title":"Ui.Gettext.gettext_comment/1","type":"macro","doc":""},{"ref":"Ui.Gettext.html#gettext_noop/1","title":"Ui.Gettext.gettext_noop/1","type":"macro","doc":""},{"ref":"Ui.Gettext.html#handle_missing_bindings/2","title":"Ui.Gettext.handle_missing_bindings/2","type":"function","doc":"Default handling for missing bindings. This function is called when there are missing bindings in a translation. It takes a Gettext.MissingBindingsError struct and the translation with the wrong bindings left as is with the %{} syntax. For example, if something like this is called: MyApp.Gettext.gettext(&quot;Hello %{name}, welcome to %{country}&quot;, name: &quot;Jane&quot;, country: &quot;Italy&quot;) and our it/LC_MESSAGES/default.po looks like this: msgid &quot;Hello %{name}, welcome to %{country}&quot; msgstr &quot;Ciao %{name}, benvenuto in %{cowntry}&quot; # (typo) then Gettext will call: MyApp.Gettext.handle_missing_bindings(exception, &quot;Ciao Jane, benvenuto in %{cowntry}&quot;) where exception is a struct that looks like this: %Gettext.MissingBindingsError{ backend: MyApp.Gettext, domain: &quot;default&quot;, locale: &quot;it&quot;, msgid: &quot;Hello %{name}, welcome to %{country}&quot;, bindings: [:country], } The return value of the c:handle_missing_bindings/2 callback is used as the translated string that the translation macros and functions return. The default implementation for this function uses Logger.error/1 to warn about the missing binding and returns the translated message with the incomplete bindings. This function can be overridden. For example, to raise when there are missing bindings: def handle_missing_bindings(exception, _incomplete) do raise exception end Callback implementation for Gettext.Backend.handle_missing_bindings/2."},{"ref":"Ui.Gettext.html#handle_missing_plural_translation/6","title":"Ui.Gettext.handle_missing_plural_translation/6","type":"function","doc":"Default handling for plural translations with a missing translation. Same as c:handle_missing_translation/4, but for plural translations. In this case, n is the number used for pluralizing the translated string. Callback implementation for Gettext.Backend.handle_missing_plural_translation/6."},{"ref":"Ui.Gettext.html#handle_missing_translation/4","title":"Ui.Gettext.handle_missing_translation/4","type":"function","doc":"Default handling for translations with a missing translation. When a Gettext function/macro is called with a string to translate into a locale but that locale doesn&#39;t provide a translation for that string, this callback is invoked. msgid is the string that Gettext tried to translate. This function should return {:ok, translated} if a translation can be fetched or constructed for the given string, or {:default, msgid} otherwise. Callback implementation for Gettext.Backend.handle_missing_translation/4."},{"ref":"Ui.Gettext.html#lgettext/4","title":"Ui.Gettext.lgettext/4","type":"function","doc":""},{"ref":"Ui.Gettext.html#lngettext/6","title":"Ui.Gettext.lngettext/6","type":"function","doc":""},{"ref":"Ui.Gettext.html#ngettext/4","title":"Ui.Gettext.ngettext/4","type":"macro","doc":""},{"ref":"Ui.Gettext.html#ngettext_noop/2","title":"Ui.Gettext.ngettext_noop/2","type":"macro","doc":""},{"ref":"Ui.LayoutView.html","title":"Ui.LayoutView","type":"module","doc":""},{"ref":"Ui.LayoutView.html#__phoenix_recompile__?/0","title":"Ui.LayoutView.__phoenix_recompile__?/0","type":"function","doc":"Returns true whenever the list of templates changes in the filesystem."},{"ref":"Ui.LayoutView.html#__resource__/0","title":"Ui.LayoutView.__resource__/0","type":"function","doc":"The resource name, as an atom, for this view"},{"ref":"Ui.LayoutView.html#__templates__/0","title":"Ui.LayoutView.__templates__/0","type":"function","doc":"Returns the template root alongside all templates."},{"ref":"Ui.LayoutView.html#render/2","title":"Ui.LayoutView.render/2","type":"function","doc":"Renders the given template locally."},{"ref":"Ui.LayoutView.html#template_not_found/2","title":"Ui.LayoutView.template_not_found/2","type":"function","doc":"Callback invoked when no template is found. By default it raises but can be customized to render a particular template."},{"ref":"Ui.Router.html","title":"Ui.Router","type":"module","doc":""},{"ref":"Ui.Router.html#api/2","title":"Ui.Router.api/2","type":"function","doc":""},{"ref":"Ui.Router.html#browser/2","title":"Ui.Router.browser/2","type":"function","doc":""},{"ref":"Ui.Router.html#call/2","title":"Ui.Router.call/2","type":"function","doc":"Callback invoked by Plug on every request."},{"ref":"Ui.Router.html#init/1","title":"Ui.Router.init/1","type":"function","doc":"Callback required by Plug that initializes the router for serving web requests."},{"ref":"Ui.Router.Helpers.html","title":"Ui.Router.Helpers","type":"module","doc":"Module with named helpers generated from Ui.Router."},{"ref":"Ui.Router.Helpers.html#game_path/2","title":"Ui.Router.Helpers.game_path/2","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#game_path/3","title":"Ui.Router.Helpers.game_path/3","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#game_path/4","title":"Ui.Router.Helpers.game_path/4","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#game_url/2","title":"Ui.Router.Helpers.game_url/2","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#game_url/3","title":"Ui.Router.Helpers.game_url/3","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#game_url/4","title":"Ui.Router.Helpers.game_url/4","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#join_path/2","title":"Ui.Router.Helpers.join_path/2","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#join_path/3","title":"Ui.Router.Helpers.join_path/3","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#join_url/2","title":"Ui.Router.Helpers.join_url/2","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#join_url/3","title":"Ui.Router.Helpers.join_url/3","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#path/2","title":"Ui.Router.Helpers.path/2","type":"function","doc":"Generates the path information including any necessary prefix."},{"ref":"Ui.Router.Helpers.html#session_path/2","title":"Ui.Router.Helpers.session_path/2","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#session_path/3","title":"Ui.Router.Helpers.session_path/3","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#session_url/2","title":"Ui.Router.Helpers.session_url/2","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#session_url/3","title":"Ui.Router.Helpers.session_url/3","type":"function","doc":""},{"ref":"Ui.Router.Helpers.html#static_integrity/2","title":"Ui.Router.Helpers.static_integrity/2","type":"function","doc":"Generates an integrity hash to a static asset given its file path."},{"ref":"Ui.Router.Helpers.html#static_path/2","title":"Ui.Router.Helpers.static_path/2","type":"function","doc":"Generates path to a static asset given its file path."},{"ref":"Ui.Router.Helpers.html#static_url/2","title":"Ui.Router.Helpers.static_url/2","type":"function","doc":"Generates url to a static asset given its file path."},{"ref":"Ui.Router.Helpers.html#url/1","title":"Ui.Router.Helpers.url/1","type":"function","doc":"Generates the connection/endpoint base URL without any path information."},{"ref":"Ui.SessionController.html","title":"Ui.SessionController","type":"module","doc":""},{"ref":"Ui.SessionController.html#create/2","title":"Ui.SessionController.create/2","type":"function","doc":""},{"ref":"Ui.SessionController.html#delete/2","title":"Ui.SessionController.delete/2","type":"function","doc":""},{"ref":"Ui.SessionController.html#new/2","title":"Ui.SessionController.new/2","type":"function","doc":""},{"ref":"Ui.SessionView.html","title":"Ui.SessionView","type":"module","doc":""},{"ref":"Ui.SessionView.html#__phoenix_recompile__?/0","title":"Ui.SessionView.__phoenix_recompile__?/0","type":"function","doc":"Returns true whenever the list of templates changes in the filesystem."},{"ref":"Ui.SessionView.html#__resource__/0","title":"Ui.SessionView.__resource__/0","type":"function","doc":"The resource name, as an atom, for this view"},{"ref":"Ui.SessionView.html#__templates__/0","title":"Ui.SessionView.__templates__/0","type":"function","doc":"Returns the template root alongside all templates."},{"ref":"Ui.SessionView.html#render/2","title":"Ui.SessionView.render/2","type":"function","doc":"Renders the given template locally."},{"ref":"Ui.SessionView.html#template_not_found/2","title":"Ui.SessionView.template_not_found/2","type":"function","doc":"Callback invoked when no template is found. By default it raises but can be customized to render a particular template."},{"ref":"Ui.UserSocket.html","title":"Ui.UserSocket","type":"module","doc":""},{"ref":"Ui.UserSocket.html#connect/2","title":"Ui.UserSocket.connect/2","type":"function","doc":"Receives the socket params and authenticates the connection. Socket params and assigns Socket params are passed from the client and can be used to verify and authenticate a user. After verification, you can put default assigns into the socket that will be set for all channels, ie {:ok, assign(socket, :user_id, verified_user_id)} To deny connection, return :error. See Phoenix.Token documentation for examples in performing token verification on connect. Callback implementation for Phoenix.Socket.connect/2."},{"ref":"Ui.UserSocket.html#connect/3","title":"Ui.UserSocket.connect/3","type":"function","doc":"Callback implementation for Phoenix.Socket.connect/3."},{"ref":"Ui.UserSocket.html#id/1","title":"Ui.UserSocket.id/1","type":"function","doc":"Identifies the socket connection. Socket IDs are topics that allow you to identify all sockets for a given user: def id(socket), do: &quot;users_socket:\#{socket.assigns.user_id}&quot; Would allow you to broadcast a &quot;disconnect&quot; event and terminate all active sockets and channels for a given user: MyApp.Endpoint.broadcast(&quot;users_socket:&quot; &lt;&gt; user.id, &quot;disconnect&quot;, %{}) Returning nil makes this socket anonymous. Callback implementation for Phoenix.Socket.id/1."},{"ref":"readme.html","title":"GifsToGifs","type":"extras","doc":"GifsToGifs This umbrella project holds a series of applications that together form a game known as Gifs to Gifs which is a multiplayer turn-based game resembling Cards Against Humanity or Apples to Apples but with GIFS!!!"},{"ref":"readme.html#docs","title":"GifsToGifs - Docs","type":"extras","doc":"The ExDoc documentation is available here."},{"ref":"readme.html#starting-points","title":"GifsToGifs - Starting Points","type":"extras","doc":"GameApp.Game - Game state and logic GameApp.Round - Round state and logic GameApp.Server - Game Server logic (GenServer) GameApp.ServerSupervisor - Supervisor for Game Servers"}]