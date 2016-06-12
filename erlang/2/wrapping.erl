-module(wrapping).
-export([calculate/1, erm/1]).

erm(String) ->
  lists:foldl(
    fun(Curr, Sum) ->
      Sum + calculate(erlang:list_to_tuple(Curr))
    end,
  0, lists:map(fun(Str) -> string:tokens(Str, "x") end, string:tokens(String, "\n"))).

calculate({Length, Width, Height})  ->
  L = string:to_integer(Length),
  W = string:to_integer(Width),
  H = string:to_integer(Height),
  erlang:display(L),
  erlang:display(W),
  erlang:display(H),
  (2*(L*W)) + (2*(W*H)) + (2*(H*L)) + erlang:min(erlang:min((2*(L*W)), (2*(W*H)), (2*(H*L)))).
