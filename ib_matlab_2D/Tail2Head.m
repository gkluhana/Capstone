function gap = Tail2Head(param,X)
p = param;

Tail = min(X(1:p.Nb,1))
Head = max(X(p.Nb+1:p.Nb+p.Nb,1))

gap = Tail - Head;

