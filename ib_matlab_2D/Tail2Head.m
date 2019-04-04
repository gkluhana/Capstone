function gap = Tail2Head(p,X)

Tail = min(X(1:p.Nb,1));
Head = max(X(p.Nb+1:p.Nb+p.Nb,1));

gap = Tail - Head;

