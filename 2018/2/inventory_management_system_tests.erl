% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(inventory_management_system, [verbose])" -s init stop
%

-module(inventory_management_system_tests).
-include_lib("eunit/include/eunit.hrl").

no_repeats_test() ->
  TestInput = "abcdef",
  Result = [],
  ?assertEqual(Result, inventory_management_system:get_repeats(TestInput)).

two_of_letter_and_three_of_letter_test() ->
  TestInput = "bababc",
  Result = [{$b,3},{$a,2}],
  ?assertEqual(Result, inventory_management_system:get_repeats(TestInput)).

two_of_letter_test() ->
  TestInput = "abbcde",
  Result = [{$b,2}],
  ?assertEqual(Result, inventory_management_system:get_repeats(TestInput)).

three_of_letter_test() ->
  TestInput = "abcccd",
  Result = [{$c,3}],
  ?assertEqual(Result, inventory_management_system:get_repeats(TestInput)).

two_of_letter_twice_test() ->
  TestInput = "aabcdd",
  Result = [{$a,2},{$d,2}],
  ?assertEqual(Result, inventory_management_system:get_repeats(TestInput)).

three_of_letter_twice_test() ->
  TestInput = "ababab",
  Result = [{$b,3},{$a,3}],
  ?assertEqual(Result, inventory_management_system:get_repeats(TestInput)).

inventory_checksum_test() ->
  TestInput = [
    "abcdef",
    "bababc",
    "abbcde",
    "abcccd",
    "aabcdd",
    "abcdee",
    "ababab"
  ],
  Result = 12,
  ?assertEqual(Result, inventory_management_system:scan_ids(TestInput)).
