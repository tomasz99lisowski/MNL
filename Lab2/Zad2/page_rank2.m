function [index_number, Edges, I, B, A, b, r] = page_rank()

    index_number = 197749;
    N = 7;
    L1 = (1+mod(9,7));
Edges = [1,1,6,7,6,4,4,5,5,2,2,2,3,3,3,3, 1,2,4,5,6,7;
         6,4,7,6,4,6,5,4,6,4,3,5,5,6,7,1, 3,3,3,3,3,3];
    
    d = 0.85;
    I = speye(N);
    B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
    L = sum(B)';
    A = spdiags(1./L, 0, N, N);
    b = repelem((1-d)/N, N)';
    M = I - d*B*A;
    r = M\b;
    
    bar(r)
    xlabel("Page")
    ylabel("PR Value")
    title("PR values")
    saveas(gcf,'zad2.1.png');
end