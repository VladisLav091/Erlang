-module(lab2).
-export([sum_neg_squares/1,dropwhile/2,antimap/2,solve/4,for/4,sortBy/2]).
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


% Основная функция сортировки
sortBy(Comparator, List) ->
    merge_sort(Comparator, List).

% Функция сортировки слиянием
merge_sort(_, []) ->
    [];
merge_sort(_, [X]) ->
    [X];
merge_sort(Comparator, List) ->
    {Left, Right} = split(List),
    merge(Comparator, merge_sort(Comparator, Left), merge_sort(Comparator, Right)).

% Функция разделения списка на две части
split(List) ->
    split(List, [], List).

split([], Acc, _) ->
    {lists:reverse(Acc), []};
split([_], Acc, _) ->
    {lists:reverse(Acc), []};
split([H1,H2|T], Acc, [_|T0]) ->
    split(T, [H1|Acc], T0).

% Функция слияния двух отсортированных списков
merge(_, Left, []) ->
    Left;
merge(_, [], Right) ->
    Right;
merge(Comparator, [H1|T1], [H2|T2]) ->
    case Comparator(H1, H2) of
        less ->
            [H1 | merge(Comparator, T1, [H2|T2])];
        equal ->
            [H1, H2 | merge(Comparator, T1, T2)];
        greater ->
            [H2 | merge(Comparator, [H1|T1], T2)]
    end.




