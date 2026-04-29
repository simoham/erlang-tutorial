-module(recordtutorial).
-export([student_init/3, get_cin/1, get_full_name/1]).

-export([student_to_map/1, student_to_record/1]).

-record(student, {firstname, lastname, cin, degrees, age, gendre}).
%% {student, {{firstname, lastname, cin, degrees, age, gendre}}
%%

student_init(Firstname, Lastname, Cin) ->
	%% #{key=>value} 
	#student{firstname=Firstname, lastname=Lastname, cin=Cin}.

get_cin(Student) ->
	Student#student.cin.

%% S = #student{...}
%% get_full_name(S) 

get_full_name(#student{firstname=Firstname, lastname=Lastname}=S) when is_record(S, student) ->
	{fullname, {Firstname, Lastname}}.	

student_to_map(#student{firstname=Firstname, lastname=Lastname}) ->
	#{firstname=>Firstname, lastname=>Lastname}.

student_to_record(#{firstname:=Firstname, lastname:=Lastname}) ->
	#student{firstname=Firstname, lastname=Lastname}.

