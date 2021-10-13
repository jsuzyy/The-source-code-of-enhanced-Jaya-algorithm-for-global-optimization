function [BestCost,BestValue,XTarget]=EJAYA(fhd,nPop,nVar,VarMin,VarMax,MaxIt)
%%Input parameters
%%fhd----------------objective function
%%nPop---------------population size 
%%nVar---------------the number of variables
%%VarMin-------------the lower boundaries of variables
%%VarMin-------------the upper boundaries of variables
%%MaxIt--------------the maximum number of iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Output parameters
%%BestCost-----------convergence curve
%%BestValue----------the optimal fitness value
%%XTarget------------the optimal solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nPop
    X(i,:)=VarMin+rand(1,nVar).*(VarMax-VarMin); %Initial population
    f(i) = fhd(X(i,:));
end
gen=1;% Initial the number of iterations
[BestCost(1),ind]=min(f);% 
XTarget=X(ind,:);
old=X;% Initial historical population
while(gen+1 <= MaxIt) % Main loop
    [row,col]=size(X);
    [t,tindex]=min(f);
    Best=X(tindex,:); 
    [w,windex]=max(f);
    worst=X(windex,:);
    xnew=zeros(row,col);
    fi1=rand;
    go1=1-fi1;
    fi2=rand;
    go2=1-fi2;
	ULP=(go1*Best+fi1*mean(X)-(X(i,:))); %Eq.(4)
	DLP=(go2*worst+fi2*mean(X)-(X(i,:))); %Eq(6)
    if rand<rand
        old=X; %Eq.(8)
    end
    old=old(randperm(nPop),:); %Eq.(9)
    for i=1:row 
        if rand<rand
            xnew(i,:)=(X(i,:))+rand(1,nVar).*ULP-rand(1,nVar).*DLP;%Eq.(7)
        else
            xnew(i,:)=(X(i,:))+randn.*(old(i,:)-(X(i,:))) ; %Eq.(10)
        end
    end
    
    for i=1:row
        xnew(i,:) = max(min(xnew(i,:),VarMax),VarMin);% boundary limit
        fnew(i,:) = fhd(xnew(i,:));
    end
    for i=1:nPop
        if(fnew(i)<f(i))
            X(i,:) = xnew(i,:);
            f(i) = fnew(i);
        end
    end
    gen = gen+1;
    [BestCost(gen),ind]=min(f);
    XTarget=X(ind);
end
BestValue=min(f);
end
