-module({{appid}}_app).
-author({{author}}).
-include_lib("{{appid}}/include/{{appid}}.hrl").
-include_lib("{{appid}}/include/log.hrl").
-include_lib("{{appid}}/include/priv.hrl").
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
  ?I("Starting application: {{appid}}"),
  ConfigPath = case ?Config(config, undefined) of
    undefined -> "{{appid}}.config";
    Else -> Else
  end,
  ulitos_app:load_config(?APP, ConfigPath, ["etc"]),
  case ?Config(use_sync, false) of
    true -> sync:go();
    false -> pass
  end,
  {{appid}}_sup:start_link().

stop(_State) ->
  ok.
