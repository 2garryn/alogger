-module(alog_if_default).

-compile([{parse_transform, alog_parse_trans}, nowarn_unused_vars]).

-export([get_mod_logs/3, log/7, default_mod_ast/0, default_modlogs_ast/0]).

% will return list of loggers for module/tag
get_mod_logs(_, _, _) ->
    [].

% main logging function  
log(Format, Args, Level, Tags, Module, Line, Pid) when is_list(Tags) ->
    [log(Format, Args, Level, Tag, Module, Line, Pid) || Tag <- Tags];

% main logging function 
log(Format, Args, Level, Tag, Module, Line, Pid) ->
    [begin
         Formatted = Mod:format(Format, Args, Tag, Module, Line, Pid),
         Mod:log(Level, Formatted)
	 end || Mod <- get_mod_logs(Level, Module, Tag)].

% wille return default AST of this module after parse_transform
default_mod_ast() ->
    ok.

% will return default AST of get_logs_mod/3
default_modlogs_ast() ->
    ok.
