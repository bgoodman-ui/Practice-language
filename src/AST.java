package PLang;

import java.util.ArrayList;
import java.util.List;

public interface AST {
    public static abstract class ASTNode {
        public abstract <T> T accept(Visitor<T> visitor, Env env);
    }
public static class Program extends ASTNode {
    Function _e;

    public Program(Function e) {
        _e = e;
    }

    public List<Function> getStatements() {
        List<Function> list = new ArrayList<Function>();
        list.add(_e);
        return list;
    }

    public <T> T accept(Visitor<T> visitor, Env env) {
        return.visitor.visit(this, env);
    }
}

public static abstract class Function extends ASTNode {

}


}