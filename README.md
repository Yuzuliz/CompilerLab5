# CompilerLab5
    学期已过半，我们实现编译器的征程也终于来到最有趣最关键的地方。
    如果你还记得本学期初探索编译器的时候，我们曾使用-fdump-tree-original-raw获得 gcc 构建的语法树。对于void main(){}，它的输出如下。
```
;; Function main (null)
;; enabled by -tree-original
@1 bind_expr type: @2 body: @3
@2 void_type name: @4 algn: 8
@3 statement_list
@4 type_decl name: @5 type: @2
@5 identifier_node strg: void lngt: 4
```
    我们知道，输出的每一行可以理解为语法树上的一个结点。每一个结点有其自身的类型、属性，以及数个子结点。本次作业便是要求构建这样一棵树并输出。
    可以想象，gcc 采取了更复杂的语法定义去构建这棵树，并使用一些压缩算法处理这棵树。本次实验，我们只要求以最简洁最直观的方式将这棵树构建出来、展示结果。
    构建出树后，我们之后的所有操作，比如树上各结点信息的获取与流动、类型检查、翻译至中间代码，都可以理解为对该树进行一次遍历。同时值得一提的是，若一些操作需要考虑语法，比如构建作用域树，那么通过语法树上一次遍历，便可以很容易完成。
