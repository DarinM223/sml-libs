(* ML-Yacc Parser Generator (c) 1989 Andrew W. Appel, David R. Tarditi *)

(* parser.sml:  This is a parser driver for LR tables with an error-recovery
   routine added to it.  The routine used is described in detail in this
   article:

        'A Practical Method for LR and LL Syntactic Error Diagnosis and
         Recovery', by M. Burke and G. Fisher, ACM Transactions on
         Programming Langauges and Systems, Vol. 9, No. 2, April 1987,
         pp. 164-197.

    This program is an implementation is the partial, deferred method discussed
    in the article.  The algorithm and data structures used in the program
    are described below.

    This program assumes that all semantic actions are delayed.  A semantic
    action should produce a function from unit -> value instead of producing the
    normal value.  The parser returns the semantic value on the top of the
    stack when accept is encountered.  The user can deconstruct this value
    and apply the unit -> value function in it to get the answer.

    It also assumes that the lexer is a lazy stream.

    Data Structures:
    ----------------

        * The parser:

           The state stack has the type

                 (state * (semantic value * line # * line #)) list

           The parser keeps a queue of (state stack * lexer pair).  A lexer pair
         consists of a terminal * value pair and a lexer.  This allows the
         parser to reconstruct the states for terminals to the left of a
         syntax error, and attempt to make error corrections there.

           The queue consists of a pair of lists (x,y).  New additions to
         the queue are cons'ed onto y.  The first element of x is the top
         of the queue.  If x is nil, then y is reversed and used
         in place of x.

    Algorithm:
    ----------

        * The steady-state parser:

            This parser keeps the length of the queue of state stacks at
        a steady state by always removing an element from the front when
        another element is placed on the end.

            It has these arguments:

           stack: current stack
           queue: value of the queue
           lexPair ((terminal,value),lex stream)

        When SHIFT is encountered, the state to shift to and the value are
        are pushed onto the state stack.  The state stack and lexPair are
        placed on the queue.  The front element of the queue is removed.

        When REDUCTION is encountered, the rule is applied to the current
        stack to yield a triple (nonterm,value,new stack).  A new
        stack is formed by adding (goto(top state of stack,nonterm),value)
        to the stack.

        When ACCEPT is encountered, the top value from the stack and the
        lexer are returned.

        When an ERROR is encountered, fixError is called.  FixError
        takes the arguments to the parser, fixes the error if possible and
        returns a new set of arguments.

        * The distance-parser:

        This parser includes an additional argument distance.  It pushes
        elements on the queue until it has parsed distance tokens, or an
        ACCEPT or ERROR occurs.  It returns a stack, lexer, the number of
        tokens left unparsed, a queue, and an action option.
*)

signature FIFO =
  sig type 'a queue
      val empty : 'a queue
      exception Empty
      val get : 'a queue -> 'a * 'a queue
      val put : 'a * 'a queue -> 'a queue
  end

(* drt (12/15/89) -- the functor should be used in development work, but
   it wastes space in the release version.

functor ParserGen(structure LrTable : LR_TABLE
                  structure Stream : STREAM) : LR_PARSER =
*)

structure LrParser :> LR_PARSER = struct end
