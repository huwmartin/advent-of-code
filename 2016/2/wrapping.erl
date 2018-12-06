-module(wrapping).
-export([paper/1, ribbon/1]).

paper(String) ->
  calculate_amount(fun calculate_paper/1, String).

ribbon(String) ->
  calculate_amount(fun calculate_ribbon/1, String).

calculate_amount(Fn, String) ->
  lists:foldl(fun(Curr, Sum) -> Sum + Fn(Curr) end, 0, parse_string(String)).

parse_string(String) ->
  lists:map(fun(Str) -> string:tokens(Str, "x") end, string:tokens(String, "\n")).

calculate_paper([Length, Width, Height])  ->
  {L, _} = string:to_integer(Length),
  {W, _} = string:to_integer(Width),
  {H, _} = string:to_integer(Height),
  2*L*W + 2*W*H + 2*H*L + lists:min([L*W, W*H, H*L]).

calculate_ribbon([Length, Width, Height])  ->
  {L, _} = string:to_integer(Length),
  {W, _} = string:to_integer(Width),
  {H, _} = string:to_integer(Height),
  X = lists:min([L, W, H]),
  Y = lists:min(lists:delete(X, [L, W, H])),
  X*2 + Y*2 + L*W*H.
