digraph G {
graph [rankdir=LR, bgcolor="white"];
node [shape=box, style=filled];
edge [arrowhead=none];
a -> b;
c -> d;
}

-- sqlfmt-corpus-separator --

digraph G {
a -> b;
}

-- sqlfmt-corpus-separator --

digraph G {
a -> b -> c -> d;
a -> b -> c -> d [style=bold, color=blue, label="path"];
}

-- sqlfmt-corpus-separator --

digraph Empty {}

-- sqlfmt-corpus-separator --

digraph G {
rankdir = LR;
a -> b;
}

-- sqlfmt-corpus-separator --

digraph G {
start [shape=box, style=filled, color=red];
end [shape=doublecircle, label="done"];
start -> end;
}

-- sqlfmt-corpus-separator --

strict digraph G {
a -> b;
b -> a;
}

-- sqlfmt-corpus-separator --

digraph G {
subgraph cluster_0 {
label="Frontend";
a -> b;
}
subgraph cluster_1 {
label="Backend";
c -> d;
}
a -> c;
}