-module(bubble).
-export([bubble_sort/1]).

bubble_sort(List) ->
    bubble_sort(List, length(List)).

bubble_sort(List, 0) -> List;
bubble_sort(List, N) ->
    bubble_sort(one_pass(List), N - 1).

one_pass([X,Y|Rest]) when X > Y ->
    [Y | one_pass([X|Rest])];
one_pass([X,Y|Rest]) ->
    [X | one_pass([Y|Rest])];
one_pass([X]) ->
    [X];
one_pass([]) ->
    [].
