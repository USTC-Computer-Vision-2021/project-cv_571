function im=imCrop(pic)
if length(size(pic))==3
    gray=rgb2gray(pic);
else
    gray=pic;
end
SZ=length(gray);
k=1;
while k<SZ
    if any(any(gray(k,:)))
        break
    end
    k=k+1;
end
ceil=k;
 
k=SZ;
while k>0
    if any(any(gray(k,:)))
        break
    end
    k=k-1;
end
bottom=k;
 
k=1;
while k<SZ
    if any(any(gray(:,k)))
        break
    end
    k=k+1;
end
left=k;
 
k=SZ;
while k>0
    if any(any(gray(:,k)))
        break
    end
    k=k-1;
end
right=k;
 
if length(size(pic))==3
    im=pic(ceil:bottom,left:right,:);
else
    im=pic(ceil:bottom,left:right);
end
