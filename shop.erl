-module(shop).
-export([cost/1, total/1, extract_price/1, total_sum/1, joe_method/2]).

%% shop:cost(oranges) -> 5
%% shop:cost(kiwi) -> 0

cost(oranges) -> 5;
cost(newspaper) -> 8;
cost(apples) -> 2;
cost(pears) -> 9; 
cost(milk) -> 7;
cost(_) -> 0.

%% [{oranges,{quantity,10}},{apples,{quantity,3}}]

%% joe_method([{oranges,{quantity,10}},{apples,{quantity,3}}], 0)

joe_method([ {Type, {quantity, Q}} |L], Sum) -> joe_method(L, shop:cost(Type)*Q+Sum);
joe_method([], Sum) -> Sum.

total(Pu) ->
	lists:map(fun(P) -> 
				  {Type, {quantity, Q}} = P,
				  {Type, {total, shop:cost(Type)*Q}}
		  end, Pu).

extract_price(Pu) ->
	   lists:map(fun(P) ->
                                  {_, {total, T}} = P,
                                  T
                  end, Pu).

total_sum(Pu) ->
	lists:sum(Pu).
