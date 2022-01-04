function im=zoo_imRegist(im1,im2,T)
sz=3*max(length(im1),length(im2));
dim=length(size(im1));
if dim==3
    [row1,col1,~]=size(im1);
    [row2,col2,~]=size(im2);
    im=zeros(sz,sz,3);
else
    [row1,col1]=size(im1);
    [row2,col2]=size(im2);
    im=zeros(sz,sz);
end
 
cX=sz/3;
cY=sz/3;
if dim==3
    im(1+cY:row1+cY,1+cX:col1+cX,:)=im1;
else
    im(1+cY:row1+cY,1+cX:col1+cX)=im1;
end
T=inv(T);
for i=1:size(im,1)
    for j=1:size(im,2)
        xy1=[j-cX;i-cY;1];
        xy2=round(T*xy1);
        nx=xy2(1);
        ny=xy2(2);
        if nx>=1&& nx<=col2 && ny>=1 && ny<=row2
           if i<=cY || i>=cY+row1 || j<=cX ||j>=cX+col1
               if dim==3
                   im(i,j,:)=im2(ny,nx,:);
               else
                   im(i,j)=im2(ny,nx);
               end
           end
        end
    end
end
 
im=imCrop(im);
im=uint8(im);
