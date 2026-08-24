grammar PLang;

@header {
    import static PLang.ast.*;
}


program returns [Program ast] :
    f = functions { $ast = new Program($f.ast);}
    |a = assign { $ast = new Program($a.ast);}
    |p = print { $ast = new Program($p.ast);}
    |fo = fileopen { $ast = new Program($fo.ast);}
    |fw = filewrite{ $ast = new Program($fw.ast);}
    |fr = fileread { $ast = new Program ($fr.ast);}
    |fa = fileappend { $ast = new Program ($fa.ast);}
    |fe = fileedit { $ast = new Program ($fe.ast);}
    |fc = fileclose { $ast = new Program ($fc.ast);}
    |i = if { $ast = new Program ($i.ast);}
    |f = for {$ast = new Program ($f.ast);}
    |w = while { $ast = new Program ($w.ast);}
