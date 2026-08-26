grammar PLang;

@header {
    import static PLang.ast.*;
}


program returns [Program ast] :
    f = function { $ast = new Program($f.ast);}
    |n = nominate { $ast = new Program($n.ast);}
    |o = output { $ast = new Program($p.ast);}
    |fo = fileopen { $ast = new Program($fo.ast);}
    |fw = filewrite{ $ast = new Program($fw.ast);}
    |fr = fileread { $ast = new Program ($fr.ast);}
    |fa = fileappend { $ast = new Program ($fa.ast);}
    |fe = fileedit { $ast = new Program ($fe.ast);}
    |fc = fileclose { $ast = new Program ($fc.ast);}
    |c = case { $ast = new Program ($c.ast);}
    |e = each {$ast = new Program ($e.ast);}
    |w = when { $ast = new Program ($w.ast);}
    |co = conditional {$ast = new Program ($co.ast);}
    |r = remove { $ast = new Program ($r.ast);}
    ;

nominate returns [Nominate ast] :
    p=primitive Assign p=program{ $ast = new Nominate($p.ast,$p.ast);}
    ;

output returns [Output ast] :
    Print p=program { $ast = new Output($o.output);}
    ;

fileopen returns [FileOpen ast] :
    Open p=primitive f=function { $ast = new FileOpen($p.ast,$f.ast);}
    ;

filewrite returns [FileWrite ast] :
    Write p=primitive f=function { $ast = new FileWrite($p.ast,$f.ast);}
    ;

fileappend returns [FileAppend ast] :
    Append p=primitive f=function { $ast = new FileAppend($p.ast,$f.ast);}
    ;

fileread returns [FileRead ast] :
    Read p=primitive f=function { $ast = new FileRead($p.ast,$f.ast);}
    ;

fileclose returns [FileClose ast] :
    Close p=primitive f=function { $ast = new FileClose($p.ast,$f.ast);}
    ;

fileedit returns [FileEdit ast] :
    Edit p=primitive f=function { $ast = new FileEdit($p.ast,$f.ast);}
    ;

compare returns [Compare ast] :
    f1 = function op = ('<' | '>' | '==' | '!=' | '>=' | '<=') f2=function {$ast = new Compare($f1.ast,$op.text,$f2.ast);}
    ;

case returns [Case ast] locals [ArrayList<Program> body] :
    {$body = new ArrayList<Program>();}
    If '(' f = function ')' '{' 
    (p = program {$body.add($p.ast);} )* 
    '}' {$ast = new Case($f.ast,$body);}
    |{$body = new ArrayList<Program>();}
    If '(' cm = compare ')' '{' 
    (p = program {$body.add($p.ast);} )* 
    '}' {$ast = new Case($cm.ast,$body);}
    ;

each returns [Each ast] locals [ArrayList<Program> body] :
    {$body = new ArrayList<Program>();}
    For '(' n=nominate ';' f1=function ';' f2=nominate ')' '{'
    (p = program {$body.add($p.ast);} )* 
    '}' {$ast = new Each($n.ast,$f1.ast,$f2.ast);}
    |{$body = new ArrayList<Program>();}
    For '(' n=nominate ';' cm=compare ';' f2=nominate ')' '{'
    (p = program {$body.add($p.ast);} )* 
    '}' {$ast = new Each($n.ast,$cm.ast,$f2.ast);}
    ;

when returns [When ast] locals [ArrayList<Program> body] :
    {$body = new ArrayList<Program>();}
    While '(' f = function ')' '{' 
    (p = program {$body.add($p.ast);} )* 
    '}' {$ast = new When($f.ast,$body);}
    |{$body = new ArrayList<Program>();}
    While '(' cm = compare ')' '{' 
    (p = program {$body.add($p.ast);} )* 
    '}' {$ast = new When($cm.ast,$body);}
    ;

conditional returns [Conditional ast] :
    TrueLiteral {$ast = new Conditional(true);}
    |FalseLiteral {$ast = new Conditional(false);}
    ;

remove returns [Remove ast] :
    Delete f=function {$ast = new Remove($f.ast);}
    ;
    


primitive returns [Primitive ast] :
    id=Identifier { $ast = new Primitive($id.text);}
    ;

basic returns [Basic ast] :
    n0 = Number {$ast = new Basic(Integer.parseInt($n0.text));}
    |n0 = Number Dot n1 = Number {$ast = new Basic(Double.parseDouble($n0.text+"."+$n1.text));}
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

function returns [Function ast] :
    p = primitive { $ast = $p.ast;}
    |s = string { $ast = $s.ast;}
    |b = basic {$ast = $b.ast;}
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
 Delete: 'remove';
 Open: 'openfile';
 Write: 'writefile';
 Read: 'readfile';
 Append: 'appendfile';
 Close: 'closefile';
 Edit: 'editfile';
 If: 'case';
 For: 'each';
 While: 'when';
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