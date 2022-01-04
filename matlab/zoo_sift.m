function [des,loc]=zoo_sift(im)
[row,col]=size(im);
f=fopen('tmp.pgm','w');
if f==-1
    error('Could not create file tmp.pgm.');
end
fprintf(f, 'P5\n%d\n%d\n255\n', col, row);
fwrite(f,im','uint8');
fclose(f);
 if isunix
    command = '!./sift ';
else
    command = '!siftWin32 ';
end
command = [command ' <tmp.pgm >tmp.key'];
eval(command);
 g=fopen('tmp.key','r');
if g==-1
    error('Could not open file tmp.key.');
end
[header,cnt]=fscanf(g,'%d %d',[1 2]);
if cnt~=2
    error('Invalid keypoint file beginning.');
end
num=header(1);
len=header(2);
if len~=128
    error('Keypoint descriptor length invalid (should be 128).');
end
 loc=double(zeros(num,4));
des=double(zeros(num,128));
for k=1:num
    [vector,cnt]=fscanf(g, '%f %f %f %f', [1 4]);
    if cnt~=4
        error('Invalid keypoint file format');
    end
    loc(k,:)=vector(1,:);
     [descrip, count] = fscanf(g, '%d', [1 len]);
    if (count ~= 128)
        error('Invalid keypoint file value.');
    end
    descrip = descrip / sqrt(sum(descrip.^2));
    des(k, :) = descrip(1, :);
end
fclose(g);
for k=1:size(des,1)
    des(k,:)=des(k,:)/sum(des(k,:));
end
delete tmp.key tmp.pgm
% <span style="font-family: Arial, Helvetica, sans-serif;">
% </span>
% <span style="font-family: Arial, Helvetica, sans-serif;">
% </span>
% <span style="font-family: Arial, Helvetica, sans-serif;">
% </span>
% <span style="font-family: Arial, Helvetica, sans-serif;">zoo_drawPoints.</span><span style="font-family: Arial, Helvetica, sans-serif;">m</span>
