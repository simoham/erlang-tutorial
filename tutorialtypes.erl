-module(tutorialtypes).
-export([sum/2, check_student_id/1, check_student_map/1]).

-record(student, {name, id}).

-spec sum(our_number(), our_number()) -> our_number().
-type our_number() :: integer().

-spec check_student_id(student_data()) -> id().
-type student_data() :: {student, {name, name()}, {id, id()}}.
-type name() :: {{firstname, string()}, {lastname, string()}}.
-type id() :: string().

-spec check_student_map(student_map()) -> record().

-type student_map() :: #{name=>name_student(), id=>id_student()}.
-type name_student() :: string().
-type id_student() :: {{city, city()}, {id, data()}}.
-type city() :: string().
-type data() :: number().
-type record() :: #student{name :: name_student(), id :: id_student()}.

sum(A, B) ->
	A+B.

check_student_id({student, {name, _Name}, {id, Id}}) ->
	Id.

check_student_map(#{name:=Name, id:=ID}) ->
	#student{name=Name, id=ID}.

