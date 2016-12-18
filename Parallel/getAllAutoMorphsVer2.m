function [ SAME ] = getAllAutoMorphsVer2( M, cores )
%COMPAREMATRICES Summary of this function goes here
%   Detailed explanation goes here

    N = size(M,2); %size of matrices
    
    Coeffs=1:N;  %generate the developed matrix
    coeffs=zeros(N);
    coeffs(1,:)=Coeffs;
    for I=1:N
        for J=1:N
            coeffs(I,J)=coeffs(1,mod(J+N-I,N)+1);
        end
    end
    
    %generate all automorphisms of shifts and negs
    %first get all coprime values from 2 to N-1
    MULT = find( gcd([1:N-1],N)==1 );
    
    %for each matrix and each MULT get the new matrix
%     TEMP = [ SHIFTS; NEGS ];

    FULLLIST=zeros(size(MULT,2) , N);
    FULLLIST2=zeros(N*size(MULT,2), N);

    spmd
        counter = 0;
        for a=labindex:cores:size(MULT,2) 
            counter = counter + 1;
            FULLLISTtemp(counter,:) = getPowerOfMFirstRow( M , MULT(a) );
        end
    end
    
    FULLLIST = FULLLISTtemp{1};
    for a=2:cores
        FULLLIST=[FULLLIST; FULLLISTtemp{a}];
    end
    
    
    %generate all shiftings of each row
    spmd
        Wtemp = FULLLIST(labindex,:);
        FULLLIST2temp = Wtemp(coeffs);
        
        for a=labindex+cores:cores:size(FULLLIST,1)
            Wtemp = FULLLIST(a,:);
            FULLLIST2temp = [FULLLIST2temp; Wtemp(coeffs)];
        end
    end
    
    FULLLIST2 = FULLLIST2temp{1};
    for a=2:cores
        FULLLIST2=[FULLLIST2; FULLLIST2temp{a}];
    end
    
    
    
    %EXPERIMENTAL FOR FINDING INVERSE OF EACH SEQ
%     disp('start EX')
    
        FULLLIST2I = zeros( size(FULLLIST2) );
        for a=1:size(FULLLIST2,1)
            
            Wtemp = FULLLIST2(a,:);
            W = Wtemp(coeffs);
            W = W';
            
            FULLLIST2I(a,:) = W(1,:);
            
        end
    
        FULLLIST3 = [FULLLIST2; FULLLIST2I];
    %END EXPERIMENTAL
    
    
    SAME=[FULLLIST3 ; -1*FULLLIST3];
  

end

