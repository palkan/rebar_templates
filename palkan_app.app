-module({{name}}_app).
-author({{author}}).
-include_lib("{{name}}/include/{{name}}.hrl").
-include_lib("{{name}}/include/log.hrl").
-include_lib("{{name}}/include/priv.hrl").
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
  ?I("Starting application: {{name}}"),
  ConfigPath = case ?Config(config, undefined) of
    undefined -> "{{name}}.config";
    Else -> Else
  end,
  ulitos_app:load_config(?APP, ConfigPath, ["etc"]),
  case ?Config(use_sync, false) of
    true -> sync:go();
    false -> pass
  end,
  {{name}}_sup:start_link().

stop(_State) ->
  ok.
