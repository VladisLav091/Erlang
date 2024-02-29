-module(lab2).
-export([sum_neg_squares/1,dropwhile/2,antimap/2,solve/4,for/4,sortBy/2,comparator/2]).
-import(math,[pi/0,pow/2]).

sum_neg_squares(List)->sum_neg_squares(List,0).         %Task_1
sum_neg_squares([],Sum)-> Sum;
sum_neg_squares([X|Xs],Sum)->
    if
        X < 0 ->
            sum_neg_squares(Xs,Sum + pow(X,2));
        true -> sum_neg_squares(Xs,Sum)
    end.
 
dropwhile(_Pred, []) ->[];                              %Task_2
dropwhile(Pred,[X|Xs])->
    case Pred(X) of
        true -> dropwhile(Pred,Xs);
        false -> [X|Xs]
    end.

antimap([],_)->[];                                  %Task_3
antimap(ListF,X)->antimap(ListF,X,[]).
antimap([],_,Acc)->lists:reverse(Acc);
antimap([H|T],X,Acc)->
    antimap(T,X,[H(X)|Acc]).


solve(Fun, A, B, 0) -> solve(Fun, A, B, 0.001);     %Task_4
solve(Fun, A, B, Eps) -> 
	C=(A+B)/2,
	AAA = Fun(A),
	BBB = Fun(B),
	CCC = Fun(C),
	if 
		(B - A) / 2 < Eps -> C;
		(AAA =< 0) and (0 =< CCC) -> 
			solve(Fun, A, C, Eps);
		(CCC =< 0) and (0 =< BBB) ->
			solve(Fun, C, B, Eps);
		true-> []
	end.



for(I, Cond, Step, Body) ->             %Task_5
    loop(I, Cond, Step, Body).

loop(I, Cond, Step, Body) ->
    case Cond(I) of
        true ->
            Body(I),
            NewI = Step(I),
            loop(NewI, Cond, Step, Body);
        false ->
            io:format("END~n")
    end.
% lab2:for(1, fun(X) -> X =< 15 end, fun(X) -> X + 1 end, fun(X) -> io:format("~p~n", [X]) end).


sortBy(Comparator, List) ->
    mergeSort(Comparator, List).

comparator(X, Y) when X < Y -> less;
comparator(X, Y) when X > Y -> greater;
comparator(X, Y) when X == Y -> equal;
comparator(_, _) -> io:format("Erorr~n").

mergeSort(_, []) -> [];
mergeSort(_, [X]) -> [X];
mergeSort(Comparator, List) ->
    {L1, L2} = split(List),
    merge(mergeSort(Comparator, L1), mergeSort(Comparator, L2), Comparator).


split(List) ->
    {L1, L2} = split(List, [], []),
    {lists:reverse(L1), lists:reverse(L2)}.

split([], L1, L2) -> {L1, L2};
split([X | Rest], L1, L2) -> split(Rest, [X | L2], L1).


merge(L1, [], _) -> L1;
merge([], L2, _) -> L2;
merge([X | Rest1], [Y | Rest2], Comparator) ->
    case Comparator(X, Y) of
        less -> [X | merge(Rest1, [Y | Rest2], Comparator)];
        _ -> [Y | merge([X | Rest1], Rest2, Comparator)]
    end.
%lab2:sortBy(fun lab2:comparator/2,[6,5,3,1,8,7,2,4]).




