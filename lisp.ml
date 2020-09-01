(* Basic file stream implementation *)

type stream = {
  mutable line_num: int
 ;mutable chrs: char list
 ;chan: in_channel
 };;

type lobject =
  | Fixnum of int
  | Boolean of bool


exception SyntaxError of string;;

(* Read a single character from input stream and return it *)
let read_char stm =
  match stm.chrs with
  | [] ->
    let c = input_char stm.chan
    in
    if c = '\n' then let _ = stm.line_num <- stm.line_num + 1
      in c
    else c
  | c::rest ->
    let _ = stm.chrs <- rest in c;;

(* Backtracking - concatenate char in front
   of our char buffer *)
let unread_char stm c =
  stm.chrs <- c :: stm.chrs;;

(* Trim white space since it carries no semantic
    meaning in Lisp. *)
let rec eat_whitespace stm =
  let is_white c =
    c = ' ' || c = '\t' || c = '\n'
  in

  let c = read_char stm
  in

  if is_white c then
    eat_whitespace stm
  else
    unread_char stm c;
  ();;

let read_sexp stm =
  let is_digit c =
    let code = Char.code c in
    code >= Char.code('0') && code <= Char.code('9')
  in
  let rec read_fixnum acc =
    let nc = read_char stm in
    if is_digit nc
    then read_fixnum (acc ^ (Char.escaped nc))
    else
      let _ = unread_char stm nc in
      Fixnum(int_of_string acc)
  in
  eat_whitespace stm;
  let c = read_char stm in
  if (is_digit c) || (c = '~') then read_fixnum (Char.escaped (if c = '~' then '-' else c))
  else if c = '#' then
    match (read_char stm) with
    | 't' -> Boolean(true)
    | 'f' -> Boolean (false)
    | x -> raise (SyntaxError ("Invalid boolean literal " ^ (Char.escaped x)))
           
  else raise (SyntaxError ("Unexpected char " ^ (Char.escaped c)));;

let print_sexp e =
  match e with
  | Fixnum(v) -> print_int v
  | Boolean(b) -> print_string (if b then "#t" else "#f")

let rec repl stm =
  print_string "> ";
  flush stdout;
  let sexp = read_sexp stm in
  print_sexp sexp;
  print_newline ();
  repl stm;;

let main =
  let stm = { chrs=[]; line_num=1; chan=stdin } in
  repl stm;;

  
         
