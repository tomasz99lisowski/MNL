function [index_number, Edges, I, B, A, b, r] = page_rank()

    index_number = 197749;
    n = 7;
    d = 0.85;

    Edges = [1,1,2,7,2,4,4,5,5,6,6,6,3,3,3;
             2,4,7,2,4,2,5,4,2,4,3,5,5,2,7];
    
    I = speye(n);
    row_indices = Edges(2,:);
    col_indices = Edges(1,:);
    B = sparse(row_indices, col_indices, 1, n, n);
    L = sum(B).';
    A = spdiags(1./L, 0, n, n);
    b = zeros(n,1) + (1-d)/n;
    M = sparse(I - d*B*A);
    r = M\b;

    bar(r)
    xlabel("Page")
    ylabel("PR Value")
    title("PR values")
    saveas(gcf,'zad2.1.png');
    
    
    
end