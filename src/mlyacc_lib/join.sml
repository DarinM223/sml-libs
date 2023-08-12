(* ML-Yacc Parser Generator (c) 1989 Andrew W. Appel, David R. Tarditi *)

(* functor Join creates a user parser by putting together a Lexer structure,
   an LrValues structure, and a polymorphic parser structure.  Note that
   the Lexer and LrValues structure must share the type pos (i.e. the type
   of line numbers), the type svalues for semantic values, and the type
   of tokens.
*)

functor Join(structure Lex : LEXER
             structure ParserData: PARSER_DATA
             structure LrParser : LR_PARSER
             sharing ParserData.LrTable = LrParser.LrTable
             sharing ParserData.Token = LrParser.Token
             sharing type Lex.UserDeclarations.svalue = ParserData.svalue
             sharing type Lex.UserDeclarations.pos = ParserData.pos
             sharing type Lex.UserDeclarations.token = ParserData.Token.token)
                 : PARSER where type pos = ParserData.pos
                            and type result = ParserData.result
                            and type arg = ParserData.arg
                            and type svalue = ParserData.svalue
                            and Token = LrParser.Token
                            and Stream = LrParser.Stream = struct end

(* functor JoinWithArg creates a variant of the parser structure produced
   above.  In this case, the makeLexer take an additional argument before
   yielding a value of type unit -> (svalue,pos) token
 *)

functor JoinWithArg(structure Lex : ARG_LEXER
             structure ParserData: PARSER_DATA
             structure LrParser : LR_PARSER
             sharing ParserData.LrTable = LrParser.LrTable
             sharing ParserData.Token = LrParser.Token
             sharing type Lex.UserDeclarations.svalue = ParserData.svalue
             sharing type Lex.UserDeclarations.pos = ParserData.pos
             sharing type Lex.UserDeclarations.token = ParserData.Token.token)
                 : ARG_PARSER where type arg = ParserData.arg
                                and type lexarg = Lex.UserDeclarations.arg
                                and type pos = ParserData.pos
                                and type result = ParserData.result
                                and type svalue = ParserData.svalue
                                and Token = ParserData.Token
                                and Stream = LrParser.Stream = struct end
