-module(chronal_calibration).
-export([get_frequency/1, calibrate_frequency/1]).

calibrate_frequency(String) ->
    Instructions = transform_instructions(String),
    attempt_frequency_calibration(Instructions, 0, [0], Instructions).

attempt_frequency_calibration([], Frequency, FrequencyHistory, InstructionSet) ->
    attempt_frequency_calibration(InstructionSet, Frequency, FrequencyHistory, InstructionSet);
attempt_frequency_calibration([{Instruction, Amount}|Tail], Frequency, FrequencyHistory, InstructionSet) ->
    NewFreq = handle_frequency_adjustment(Frequency, Instruction, Amount),
    SeenBefore = lists:member(NewFreq, FrequencyHistory),
    NewHistory = lists:flatten([NewFreq, FrequencyHistory]),
    if 
      SeenBefore -> 
        NewFreq; 
      true -> 
        attempt_frequency_calibration(Tail, NewFreq, NewHistory, InstructionSet)
    end.

get_frequency(String) ->
    Instructions = transform_instructions(String),
    process_instructions(Instructions, 0).

transform_instructions(String) ->
    InstructionStrings = string:tokens(String, ", "),
    map_instructions(InstructionStrings).

map_instructions(InstructionStrings) ->
    lists:map(fun(Element) -> transform_instruction(Element) end, InstructionStrings).

transform_instruction([Instruction|Amount]) ->
    TransformedInstruction = case Instruction of
        $+ -> add;
        $- -> subtract
    end,
    {TransformedAmount, _} = string:to_integer(Amount),
    {TransformedInstruction, TransformedAmount}.

process_instructions(Instructions, Start) ->
    lists:foldl(fun({Instruction, Amount}, Sum) -> handle_frequency_adjustment(Sum, Instruction, Amount) end, Start, Instructions).

handle_frequency_adjustment(Curr, Instruction, Amount) when Instruction == add ->
    Curr + Amount;
handle_frequency_adjustment(Curr, Instruction, Amount) when Instruction == subtract ->
    Curr - Amount.