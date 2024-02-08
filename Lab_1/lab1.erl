-module(lab1).
-export([ball_volume/1,from_to/2,delta/1,int_to_binary/1,intersect/2,is_date/3,rle_encode/1]).
-import(math,[pi/0,pow/2]).

ball_volume(R)->4/3*pi()*pow(R,3). %Task_1

from_to(N,M)->                      %Taks_2
    from_to(N, M, []).

from_to(N,M,Oldlist)->
    if 
        N =< M -> from_to(N+1, M, [N | Oldlist]);
        true -> io:format("~w", [lists:reverse(Oldlist)])
    end
.

delta([Head | Tail])->                 %Task_3
    delta([Head],Tail,Head).

delta(New_list,[Head|Tail], Number)->    
    delta([(Head-Number) | New_list],Tail,Head);
delta(Old_list, [], _)->
    lists:reverse(Old_list).
    
int_to_binary(N)->
    binary_to_list(integer_to_binary(N,2)). %Task_4



encode_run({E, 1}) -> E;                       %Task_5
encode_run({E, C}) -> {E, C}.

group([], E, C, Acc) ->
    lists:reverse([encode_run({E, C}) | Acc]);
group([X | Xs], E, C, Acc) when X == E ->
    group(Xs, E, C + 1, Acc);
group([X | Xs], E, C, Acc) ->
    group(Xs, X, 1, [encode_run({E, C}) | Acc]).

rle_encode([]) -> [];
rle_encode([X | Xs]) -> group(Xs, X, 1, []).

intersect(List1, List2)-> (List1 -- (List1 -- List2)).  % Task_6

 is_date(DayOfMonth, MonthOfYear, Year)->is_date(DayOfMonth, MonthOfYear, Year,6).
     is_date(0, MonthOfYear, Year,Day)->
         case MonthOfYear of
             MonthOfYear when MonthOfYear == 2;
                              MonthOfYear == 4;
                              MonthOfYear == 6;
                              MonthOfYear == 8;
                              MonthOfYear == 9;
                              MonthOfYear == 11;
                              MonthOfYear == 1->
                 is_date(31, MonthOfYear-1, Year,Day);
             MonthOfYear when MonthOfYear == 5;
                              MonthOfYear == 7;
                              MonthOfYear == 10;
                              MonthOfYear == 12->
                 is_date(30, MonthOfYear-1, Year,Day);
             MonthOfYear when MonthOfYear == 3->
                 if
                     (((Year rem 4) == 0) and ((Year rem 100) /= 0)) or ((Year rem 400) == 0)->
                         is_date(29, MonthOfYear-1, Year,Day);
                     true->
                         is_date(28, MonthOfYear-1, Year,Day)
                 end                                                                                             % Task_7
             end;
     is_date(_, 0, Year,Day)->is_date(31, 12, Year-1,Day);
     is_date(DayOfMonth, MonthOfYear, Year,8)->is_date(DayOfMonth, MonthOfYear, Year,1);
     is_date(1, 1, 2000,Day)->
         case Day of
            Day when Day == 1 -> io:format("Понедельник~n");
		    Day when Day == 2 -> io:format("Вторник~n");
		    Day when Day == 3 -> io:format("Среда~n");
		    Day when Day == 4 -> io:format("Четверг~n");
		    Day when Day == 5 -> io:format("Пятница~n");
		    Day when Day == 6 -> io:format("Суббота~n");
		    Day when Day == 7 -> io:format("Воскресенье~n")
         end;
     is_date(DayOfMonth, MonthOfYear, Year,Day)-> is_date(DayOfMonth - 1 , MonthOfYear, Year,Day+1).
     