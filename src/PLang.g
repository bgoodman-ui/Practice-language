grammar PLang;

@header {
    import static PLang.ast.*;
}


program returns [Program ast] :
    f = functions { $ast = new Program($f.ast);}
    |a = assign { $ast = new Program($a.ast);}
    |p = print { $ast = new Program($p.ast);}
    |f = file { $ast = new Program($f.ast);}
    