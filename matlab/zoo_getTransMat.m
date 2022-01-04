function T=zoo_getTransMat(gray1,loc1,gray2,loc2)
gray1=double(gray1);
gray2=double(gray2);
N=size(loc1,1);
iter=N*(N-1)*(N-2)/6;
SEL=zeros(iter,3);
count=1;
for i=1:N-2
    for j=2:N-1
        for k=3:N
            if i<j && j<k
                SEL(count,:)=[i j k];
                count=count+1;
            end
        end
    end
end
T=[];
corr1=-1;
for k=1:iter
    sel=SEL(k,:);
    x1=loc1(sel,2);
    y1=loc1(sel,1);
    x2=loc2(sel,2);
    y2=loc2(sel,1);
    xy1=[x1';y1';ones(1,3)];
    xy2=[x2';y2';ones(1,3)];
    t=xy1/xy2;
     grayset=getMask(gray1,gray2,t);
    if isempty(grayset)
        continue
    end
    d1=grayset(1,:);
    d2=grayset(2,:);
    corr2=(d1*d2')/sqrt((d1*d1')*(d2*d2'));
    if corr2>corr1
        corr1=corr2;
        T=t;
    end
end
