function grayset=getMask(im1,im2,T)
[row1,col1]=size(im1);
[row2,col2]=size(im2);
T=T^(-1);
grayset=[];
for i=1:row1
    for j=1:col1
        xy1=[j;i;1];
        xy2=round(T*xy1);
        if xy2(1)>=1 && xy2(1)<=col2&& xy2(2)>=1 && xy2(2)<=row2
           grayset=[grayset,[im1(i,j);im2(xy2(2),xy2(1))]];
        end
    end
end
