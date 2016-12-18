function [ TheGCD ] = getGCD( FirstRow )
%GETGCD 
    FirstRow( find(FirstRow==0) ) = [];

    N=size(FirstRow,2);
    G=zeros(1,N-1);
    
    for a=2:N
        G(a-1)=gcd( FirstRow(1), FirstRow(a) );
    end
    
    TheGCD = min(G);
    

end

