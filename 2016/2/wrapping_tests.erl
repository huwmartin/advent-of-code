% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(wrapping, [verbose])" -s init stop
%

-module(wrapping_tests).
-include_lib("eunit/include/eunit.hrl").

wrapping_test() ->
  ?assertEqual(58, wrapping:paper("2x3x4")).

wrapping_test_next() ->
  ?assertEqual(43, wrapping:paper("1x1x10")).

ribbon_test() ->
  ?assertEqual(34, wrapping:ribbon("2x3x4")).

ribbon_test_next() ->
  ?assertEqual(14, wrapping:ribbon("1x1x10")).
