function H = compute_homography(A, B)
    
    assert(size(A, 2) == 2);
    assert(size(B, 2) == 2);
    assert(size(A, 1) == size(B, 1));
        
    eq = [];
    
    for i = 1:size(A, 1)
        x = A(i, 1); 
        y = A(i, 2);
        xp = B(i, 1);
        yp = B(i, 2);
        temp = [-x -y -1 0 0 0 x*xp y*xp xp; 0 0 0 -x -y -1 x*yp y*yp yp];
        eq = [eq; temp];
    end
    
    [U, D, V] = svd(eq);
    H = V(:, end);
    H = reshape(H, 3, 3)';