function [ MtoP ] = getPowerOfMFirstRow( Matrix, Power )
%GETPOWEROFM Summary of this function goes here
%   Detailed explanation goes here
    N=size(Matrix,2);
    Coeffs=1:N;
    coeffs=zeros(N);
    Coeffs2=Coeffs-1;
    coeffs(1,:)=Coeffs;
    
    for I=1:N
        for J=1:N
            coeffs(I,J)=coeffs(1,mod(J+N-I,N)+1);   
        end
    end
    
    for i=1:N
        Coeffs2(i) = mod( Coeffs2( i ) * Power , N ) + 1 ;
    end
    
    WFirstRow = Matrix(1,:);
    
    PowerFirstRow = zeros(1,N);
    
    for i=1:N
        PowerFirstRow(i) = sum( WFirstRow( find(Coeffs2==i) ) );
    end

    MtoP = PowerFirstRow;

end

