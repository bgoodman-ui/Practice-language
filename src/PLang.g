grammar PLang;

@header {
    import static PLang.ast.*;
}


program returns [Program ast] :
    f = functions { $ast = new Program($f.ast);}
    |n = nominate { $ast = new Program($n.ast);}
    |o = output { $ast = new Program($p.ast);}
    |fo = fileopen { $ast = new Program($fo.ast);}
    |fw = filewrite{ $ast = new Program($fw.ast);}
    |fr = fileread { $ast = new Program ($fr.ast);}
    |fa = fileappend { $ast = new Program ($fa.ast);}
    |fe = fileedit { $ast = new Program ($fe.ast);}
    |fc = fileclose { $ast = new Program ($fc.ast);}
    |i = if { $ast = new Program ($i.ast);}
    |f = for {$ast = new Program ($f.ast);}
    |w = while { $ast = new Program ($w.ast);}
    |d = delete { $ast = new Program ($d.ast);}
    ;

nominate returns [Nominate ast] :
    p=primitive Assign p=program{ $ast = new Nominate($p.ast,$p.ast);}
    ;

output returns [Output ast] :
    Print p=program { $ast = new Output($o.output);}
    ;




primitive returns [Primitive ast] :
    id=Identifier { $ast = new Primitive($id.text);}
    ;

add returns [Add ast] :
    'add' '(' p1=program ',' p2=program ')' ';'{ $ast = new Add ($p1.ast,$p2.ast);}
    ;

subtact returns [Subtract ast] :
    'minus' '(' p1=program ',' p2=program ')' ';'{ $ast = new Subtact ($p1.ast,$p2.ast);}
    ;
multiply returns [Multiply ast] :
    'mult' '(' p1=program ',' p2=program ')' ';'{ $ast = new Multiply ($p1.ast,$p2.ast);}
    ;
divide returns [Divide ast] :
    'div' '(' p1=program ',' p2=program ')' ';'{ $ast = new Divide ($p1.ast,$p2.ast);}
    ;
modulus returns [Modulus ast] :
    'mod' '(' p1=program ',' p2=program ')' ';'{ $ast = new Modulus ($p1.ast,$p2.ast);}
    ;
exponent returns [Exponent ast] :
    'exp' '(' p1=program ',' p2=program ')' ';' { $ast = new Exponent ($p1.ast,$p2.ast);}
    ;

string returns [String ast] :
    s=string { $ast = new String($s.text);}
    ;

concatenation returns [Concatenation ast] :
    'merge' '[' p1=program '#' p2=program ']'';' { $ast = new Concatenation ($p1.ast,$p2.ast);}
    ;

functions returns [Functions ast] :
    p = primitive { $ast = $p.ast;}
    |s = string { $ast = $s.ast;}
    |a = add { $ast = $a.ast;}
    |su = subtract { $ast = $su.ast;}
    |m = multiply { $ast = $m.ast;}
    |di = divide { $ast = $di.ast;}
    |mo = modulus { $ast = $mo.ast;}
    |e = exponent { $ast = $e.ast;}
    |c = concatenation { $ast = $c.ast;}
    ;

 Print: 'print';
 Input: 'insert';
 Delete: 'delete';
 Open: 'openfile';
 FileWrite: 'writefile';
 FileRead: 'readfile';
 AppendFile: 'appendfile';
 FileClose: 'closefile';
 FileEdit: 'editfile';
 If: 'if';
 For: 'for';
 While: 'while';
TrueLiteral: 'true';
FalseLiteral: 'false';
Equals : '==';
 NotEquals : '!=';
 GreaterEqual : '>=';
 LessEqual : '<=';
 GreaterThan : '>';
 LessThan : '<';
 Assign : '=';
Semicolon : ';' ;

 Dot : '.' ;

 Number : DIGIT+ ;

 Identifier :   Letter LetterOrDigit*;

 String : '"' (~'"')* '"';

 Letter :   [a-zA-Z$_]
	|   ~[\u0000-\u00FF\uD800-\uDBFF] 
		{Character.isJavaIdentifierStart(_input.LA(-1))}?
	|   [\uD800-\uDBFF] [\uDC00-\uDFFF] 
		{Character.isJavaIdentifierStart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}? ;

 LetterOrDigit: [a-zA-Z0-9$_]
	|   ~[\u0000-\u00FF\uD800-\uDBFF] 
		{Character.isJavaIdentifierPart(_input.LA(-1))}?
	|    [\uD800-\uDBFF] [\uDC00-\uDFFF] 
		{Character.isJavaIdentifierPart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)))}?;

 fragment DIGIT: ('0'..'9');

 WS  :  [ \t\r\n\u000C]+ -> skip;