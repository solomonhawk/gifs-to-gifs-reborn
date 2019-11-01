sidebarNodes={"extras":[{"id":"api-reference","title":"API Reference","group":"","headers":[{"id":"Modules","anchor":"modules"}]},{"id":"readme","title":"GifsToGifs","group":"","headers":[{"id":"Docs","anchor":"docs"},{"id":"Starting Points","anchor":"starting-points"},{"id":"Set Up","anchor":"set-up"},{"id":"Running the app","anchor":"running-the-app"}]}],"exceptions":[],"modules":[{"id":"GameApp.Config","title":"GameApp.Config","group":"","nodeGroups":[{"key":"types","name":"Types","nodes":[{"id":"t/0","anchor":"t:t/0"}]},{"key":"functions","name":"Functions","nodes":[{"id":"create/1","anchor":"create/1"}]}]},{"id":"GameApp.Game","title":"GameApp.Game","group":"","nodeGroups":[{"key":"types","name":"Types","nodes":[{"id":"game_state/0","anchor":"t:game_state/0"},{"id":"t/0","anchor":"t:t/0"}]},{"key":"functions","name":"Functions","nodes":[{"id":"all_players_reacted?/1","anchor":"all_players_reacted?/1"},{"id":"create/1","anchor":"create/1"},{"id":"final_round?/1","anchor":"final_round?/1"},{"id":"finalize/1","anchor":"finalize/1"},{"id":"is_empty?/1","anchor":"is_empty?/1"},{"id":"player_join/2","anchor":"player_join/2"},{"id":"player_leave/2","anchor":"player_leave/2"},{"id":"select_prompt/2","anchor":"select_prompt/2"},{"id":"select_reaction/3","anchor":"select_reaction/3"},{"id":"select_winner/2","anchor":"select_winner/2"},{"id":"start_game/1","anchor":"start_game/1"},{"id":"start_prompt_selection/1","anchor":"start_prompt_selection/1"},{"id":"start_round/1","anchor":"start_round/1"},{"id":"start_winner_selection/1","anchor":"start_winner_selection/1"},{"id":"summary/1","anchor":"summary/1"}]}]},{"id":"GameApp.Player","title":"GameApp.Player","group":"","nodeGroups":[{"key":"types","name":"Types","nodes":[{"id":"t/0","anchor":"t:t/0"}]},{"key":"functions","name":"Functions","nodes":[{"id":"create/1","anchor":"create/1"}]}]},{"id":"GameApp.Round","title":"GameApp.Round","group":"","nodeGroups":[{"key":"types","name":"Types","nodes":[{"id":"t/0","anchor":"t:t/0"}]},{"key":"functions","name":"Functions","nodes":[{"id":"create/1","anchor":"create/1"},{"id":"remove_reaction/2","anchor":"remove_reaction/2"},{"id":"set_prompt/2","anchor":"set_prompt/2"},{"id":"set_reaction/3","anchor":"set_reaction/3"},{"id":"set_winner/2","anchor":"set_winner/2"}]}]},{"id":"GameApp.Server","title":"GameApp.Server","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"child_spec/1","anchor":"child_spec/1"},{"id":"game_pid/1","anchor":"game_pid/1"},{"id":"generate_shortcode/0","anchor":"generate_shortcode/0"},{"id":"join/2","anchor":"join/2"},{"id":"leave/2","anchor":"leave/2"},{"id":"select_prompt/3","anchor":"select_prompt/3"},{"id":"select_reaction/4","anchor":"select_reaction/4"},{"id":"select_winner/3","anchor":"select_winner/3"},{"id":"start_game/1","anchor":"start_game/1"},{"id":"start_link/3","anchor":"start_link/3"},{"id":"start_round/2","anchor":"start_round/2"},{"id":"summary/1","anchor":"summary/1"},{"id":"via_tuple/1","anchor":"via_tuple/1"}]}]},{"id":"GameApp.ServerSupervisor","title":"GameApp.ServerSupervisor","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"child_spec/1","anchor":"child_spec/1"},{"id":"start_game/3","anchor":"start_game/3"},{"id":"start_link/1","anchor":"start_link/1"},{"id":"stop_game/1","anchor":"stop_game/1"}]}]},{"id":"Ui","title":"Ui","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"__using__/1","anchor":"__using__/1"},{"id":"channel/0","anchor":"channel/0"},{"id":"controller/0","anchor":"controller/0"},{"id":"router/0","anchor":"router/0"},{"id":"view/0","anchor":"view/0"}]}]},{"id":"Ui.ChannelWatcher","title":"Ui.ChannelWatcher","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"child_spec/1","anchor":"child_spec/1"},{"id":"demonitor/2","anchor":"demonitor/2"},{"id":"init/1","anchor":"init/1"},{"id":"monitor/3","anchor":"monitor/3"},{"id":"start_link/1","anchor":"start_link/1"}]}]},{"id":"Ui.Endpoint","title":"Ui.Endpoint","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"broadcast/3","anchor":"broadcast/3"},{"id":"broadcast!/3","anchor":"broadcast!/3"},{"id":"broadcast_from/4","anchor":"broadcast_from/4"},{"id":"broadcast_from!/4","anchor":"broadcast_from!/4"},{"id":"call/2","anchor":"call/2"},{"id":"child_spec/1","anchor":"child_spec/1"},{"id":"config/2","anchor":"config/2"},{"id":"config_change/2","anchor":"config_change/2"},{"id":"host/0","anchor":"host/0"},{"id":"init/1","anchor":"init/1"},{"id":"instrument/3","anchor":"instrument/3"},{"id":"path/1","anchor":"path/1"},{"id":"script_name/0","anchor":"script_name/0"},{"id":"start_link/1","anchor":"start_link/1"},{"id":"static_integrity/1","anchor":"static_integrity/1"},{"id":"static_lookup/1","anchor":"static_lookup/1"},{"id":"static_path/1","anchor":"static_path/1"},{"id":"static_url/0","anchor":"static_url/0"},{"id":"struct_url/0","anchor":"struct_url/0"},{"id":"subscribe/1","anchor":"subscribe/1"},{"id":"subscribe/3","anchor":"subscribe/3"},{"id":"unsubscribe/1","anchor":"unsubscribe/1"},{"id":"url/0","anchor":"url/0"}]}]},{"id":"Ui.ErrorHelpers","title":"Ui.ErrorHelpers","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"error_tag/2","anchor":"error_tag/2"},{"id":"translate_error/1","anchor":"translate_error/1"}]}]},{"id":"Ui.ErrorView","title":"Ui.ErrorView","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"__phoenix_recompile__?/0","anchor":"__phoenix_recompile__?/0"},{"id":"__resource__/0","anchor":"__resource__/0"},{"id":"__templates__/0","anchor":"__templates__/0"},{"id":"render/2","anchor":"render/2"},{"id":"template_not_found/2","anchor":"template_not_found/2"}]}]},{"id":"Ui.GameChannel","title":"Ui.GameChannel","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"handle_in/3","anchor":"handle_in/3"},{"id":"handle_info/2","anchor":"handle_info/2"},{"id":"join/3","anchor":"join/3"},{"id":"leave/3","anchor":"leave/3"},{"id":"start_link/1","anchor":"start_link/1"}]}]},{"id":"Ui.GameController","title":"Ui.GameController","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"create/2","anchor":"create/2"},{"id":"join/2","anchor":"join/2"},{"id":"new/2","anchor":"new/2"},{"id":"show/2","anchor":"show/2"}]}]},{"id":"Ui.GameView","title":"Ui.GameView","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"__phoenix_recompile__?/0","anchor":"__phoenix_recompile__?/0"},{"id":"__resource__/0","anchor":"__resource__/0"},{"id":"__templates__/0","anchor":"__templates__/0"},{"id":"render/2","anchor":"render/2"},{"id":"template_not_found/2","anchor":"template_not_found/2"}]}]},{"id":"Ui.Gettext","title":"Ui.Gettext","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"dgettext/3","anchor":"dgettext/3"},{"id":"dgettext_noop/2","anchor":"dgettext_noop/2"},{"id":"dngettext/5","anchor":"dngettext/5"},{"id":"dngettext_noop/3","anchor":"dngettext_noop/3"},{"id":"gettext/2","anchor":"gettext/2"},{"id":"gettext_comment/1","anchor":"gettext_comment/1"},{"id":"gettext_noop/1","anchor":"gettext_noop/1"},{"id":"handle_missing_bindings/2","anchor":"handle_missing_bindings/2"},{"id":"handle_missing_plural_translation/6","anchor":"handle_missing_plural_translation/6"},{"id":"handle_missing_translation/4","anchor":"handle_missing_translation/4"},{"id":"lgettext/4","anchor":"lgettext/4"},{"id":"lngettext/6","anchor":"lngettext/6"},{"id":"ngettext/4","anchor":"ngettext/4"},{"id":"ngettext_noop/2","anchor":"ngettext_noop/2"}]}]},{"id":"Ui.LayoutView","title":"Ui.LayoutView","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"__phoenix_recompile__?/0","anchor":"__phoenix_recompile__?/0"},{"id":"__resource__/0","anchor":"__resource__/0"},{"id":"__templates__/0","anchor":"__templates__/0"},{"id":"render/2","anchor":"render/2"},{"id":"template_not_found/2","anchor":"template_not_found/2"}]}]},{"id":"Ui.Presence","title":"Ui.Presence","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"fetch/2","anchor":"fetch/2"},{"id":"get_by_key/2","anchor":"get_by_key/2"},{"id":"handle_diff/2","anchor":"handle_diff/2"},{"id":"init/1","anchor":"init/1"},{"id":"list/1","anchor":"list/1"},{"id":"start_link/1","anchor":"start_link/1"},{"id":"track/3","anchor":"track/3"},{"id":"track/4","anchor":"track/4"},{"id":"untrack/2","anchor":"untrack/2"},{"id":"untrack/3","anchor":"untrack/3"},{"id":"update/3","anchor":"update/3"},{"id":"update/4","anchor":"update/4"}]}]},{"id":"Ui.Router","title":"Ui.Router","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"api/2","anchor":"api/2"},{"id":"browser/2","anchor":"browser/2"},{"id":"call/2","anchor":"call/2"},{"id":"init/1","anchor":"init/1"}]}]},{"id":"Ui.Router.Helpers","title":"Ui.Router.Helpers","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"game_path/2","anchor":"game_path/2"},{"id":"game_path/3","anchor":"game_path/3"},{"id":"game_path/4","anchor":"game_path/4"},{"id":"game_url/2","anchor":"game_url/2"},{"id":"game_url/3","anchor":"game_url/3"},{"id":"game_url/4","anchor":"game_url/4"},{"id":"join_path/2","anchor":"join_path/2"},{"id":"join_path/3","anchor":"join_path/3"},{"id":"join_url/2","anchor":"join_url/2"},{"id":"join_url/3","anchor":"join_url/3"},{"id":"path/2","anchor":"path/2"},{"id":"session_path/2","anchor":"session_path/2"},{"id":"session_path/3","anchor":"session_path/3"},{"id":"session_url/2","anchor":"session_url/2"},{"id":"session_url/3","anchor":"session_url/3"},{"id":"static_integrity/2","anchor":"static_integrity/2"},{"id":"static_path/2","anchor":"static_path/2"},{"id":"static_url/2","anchor":"static_url/2"},{"id":"url/1","anchor":"url/1"}]}]},{"id":"Ui.SessionController","title":"Ui.SessionController","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"create/2","anchor":"create/2"},{"id":"delete/2","anchor":"delete/2"},{"id":"new/2","anchor":"new/2"}]}]},{"id":"Ui.SessionView","title":"Ui.SessionView","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"__phoenix_recompile__?/0","anchor":"__phoenix_recompile__?/0"},{"id":"__resource__/0","anchor":"__resource__/0"},{"id":"__templates__/0","anchor":"__templates__/0"},{"id":"render/2","anchor":"render/2"},{"id":"template_not_found/2","anchor":"template_not_found/2"}]}]},{"id":"Ui.UserSocket","title":"Ui.UserSocket","group":"","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"id":"connect/2","anchor":"connect/2"},{"id":"id/1","anchor":"id/1"}]}]}],"tasks":[]}