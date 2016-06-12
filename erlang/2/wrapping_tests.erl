% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(wrapping, [verbose])" -s init stop
%

-module(wrapping_tests).
-include_lib("eunit/include/eunit.hrl").

wrapping_test() ->
  ?assertEqual(58, wrapping:calculate(2, 3, 4)).

wrapping_test_next() ->
  ?assertEqual(43, wrapping:calculate(1, 1, 10)).
