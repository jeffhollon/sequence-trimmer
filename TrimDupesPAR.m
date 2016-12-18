function [ TrimList ] = TrimDupesPAR( RawList , cores)
%TRIMDUPES
    
    count = 0;
    
    %the first one is unique
    count = count + 1;
    Temp(count,:) = RawList(1,:);
    
    %get all possible autocorrelations of the first
    CheckList = getAllAutoMorphsVer2( Temp(count,:) , cores );
  
    %Go through each item in RawList and remove anything which is the same
    %as the first one
 
    spmd
        counter = 0;
        for a=labindex:cores:size(RawList,1)

            for b=1:size(CheckList,1)
                if RawList(a,:) == CheckList(b,:)
                    counter = counter + 1;
                    A(counter)=a;
                    break
                end
            end
        end
    end
    
    clear temp
    temp=A{1};
    for i=2:cores
        if exist(A,i)
            temp = [temp, A{i}];
        end
    end       
    
    RawList(temp,:)=[];
    clear A

    
    %while RawList has something in it
    while ~isempty( RawList )

       
        count = count + 1;
        Temp(count,:) = RawList(1,:);
        CheckList = getAllAutoMorphsVer2( Temp(count,:) , cores );
        
        spmd
                counter = 0;
                for a=labindex:cores:size(RawList,1)

                    for b=1:size(CheckList,1)
                        if RawList(a,:) == CheckList(b,:)
                            counter = counter + 1;
                            A(counter)=a;
                            break
                        end
                    end
                end
        end
        
        clear temp
        temp=A{1};
        for i=2:cores
            if exist(A,i)
                temp = [temp, A{i}];
            end
        end       

        RawList(temp,:)=[];
        clear A
            

        
    end
    
    TrimList = Temp;

end

