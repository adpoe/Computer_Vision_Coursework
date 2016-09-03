function [ output_val ] = fib_n( n )
% Returns the n-th fibonnaci number for input n
%   Recursively enerate each fibonnaci number up to n, and return it
if n <= 0
    output_val = 0;
elseif n <= 2
    output_val = 1;
else 
    fib_n_min_2 = fib_n( (n-2) );
    fib_n_min_1 = fib_n( (n-1) );
    output_val = fib_n_min_2 + fib_n_min_1;
end

