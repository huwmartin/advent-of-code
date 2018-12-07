-module(inventory_management_system).
-export([get_repeats/1, scan_ids/1]).

scan_ids(Ids) ->
  RepeatsInIds = lists:map(fun get_repeats/1, Ids),
  TwiceRepeatedInstances = lists:foldl(fun (RepeatsInId, Curr) -> iterate_if_repeated(RepeatsInId, Curr, 2) end, 0, RepeatsInIds),
  ThriceRepeatedInstances = lists:foldl(fun (RepeatsInId, Curr) -> iterate_if_repeated(RepeatsInId, Curr, 3) end, 0, RepeatsInIds),
  TwiceRepeatedInstances * ThriceRepeatedInstances.

iterate_if_repeated(Repeats, Curr, NumberOfRepeats) ->
  ContainsRepeat = lists:any(fun ({_, Value}) -> Value == NumberOfRepeats end, Repeats),
  if 
    ContainsRepeat -> 
      Curr + 1; 
    true -> 
      Curr
  end.

get_repeats(String) ->
  OccuranceDictionary = lists:foldl(fun(Letter, Dictionary) -> handle_dict_update(Letter, Dictionary) end, dict:new(), String),
  OnlyRepetedCharacters = dict:filter(fun check_for_duplicates/2, OccuranceDictionary),
  dict:to_list(OnlyRepetedCharacters).

handle_dict_update(Letter, Dictionary) ->
  dict:update_counter(Letter, 1, Dictionary).

check_for_duplicates(_, Value) when Value == 2 ->
  true;
check_for_duplicates(_, Value) when Value == 3 ->
  true;
check_for_duplicates(_, _) ->
  false.
