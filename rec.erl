-module(rec).
-export([init_student/2, get_firstname/1, set_firstname/2, student_to_map/1, student_to_record/1]).

-record(student, {firstname, lastname, email, phone, class, age, gendre}).
-define(MAX_STUDENT, 10000).

%% ?MAX_STUDENT 
%% #define MAX_STUDENT 100000
%%
%% {student, {fields, ....}}

init_student(Firstname, Lastname) ->
	#student{firstname=Firstname, lastname=Lastname}.

get_firstname(Student) when is_record(Student, student) ->
	Student#student.firstname.

set_firstname(Firstname, Student) when is_record(Student, student) ->
	UpdatedStudent=Student#student{firstname=Firstname},
	UpdatedStudent.

student_to_map(#student{firstname=Firstname, lastname=Lastname}) ->
	#{firstname=>Firstname, lastname=>Lastname}.

student_to_record(#{firstname:=Firstname, lastname:=Lastname}) ->
	#student{firstname=Firstname, lastname=Lastname}.
