-module(not_quite_lisp).
-export([floor/1, floors/1, basement/1]).

floor(String) ->
  lists:last(floors(String)).

basement(String) ->
  string:str(floors(String), [-1]).

floors(String) ->
  lists:flatten(lists:foldl(fun floor_change/2, [], String)).

floor_change(Current, []) ->
  case Current of
    $(  -> [1];
    $) -> [-1]
  end;
floor_change(Current, Prod) ->
  Value = case Current of
    $(  -> lists:last(Prod)+1;
    $) -> lists:last(Prod)-1
  end,
  [Prod|[Value]].
