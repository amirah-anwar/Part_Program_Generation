% ($Lathe)
% ($Millimeters)
% ($AddRegPart 32)
% (samp)

Im=imread('king1.jpg');
BW=im2bw(Im,0.75);
imEdge=edge(BW);
imshow(imEdge)
[dia st h tp rad sr hr]=segmentation(imEdge);
maxDia=50;len=150;
for k=1:length(dia)
    if abs(maxDia-dia(k))<=2
        dia(k)=maxDia;
    end
    if st(k)==max(st)
        st(k)=len;
    end
end
a=sprintf('($Lathe)\n($Millimeters)\n($AddRegPart 32)\n(samp)\nET8 M6\nG00 M09 M4 S2000\nG01 F0.02');disp(a);

for i=1:length(dia)-1
   x=maxDia-dia(i);
   y=maxDia;
   if x>1
       b=sprintf('G00 X%d\nG00 Z%d',y,st(i));disp(b);
   end
   while x>3
       y=y-5;
       c=sprintf('G01 X%d\nG01 Z%d\nG00 X%d\nG00 Z%d',y,st(i+1),y+5,st(i));disp(c);
       x=x-5;
   end
   d=sprintf('G00 X90');disp(d);
end

for i=1:2:length(tp)
     if tp(i)<tp(i+1)
         a1=sprintf('ET1 M6\nG00 X90');disp(a1);
     else
         a1=sprintf('ET4 M6\nG00 X90');disp(a1);
     end
    x=h(i);
    e=sprintf('G00 Z%d\nG00 X%d',tp(i),x);disp(e);
    while x~=h(i+1)
        x=x-5;
        if x<h(i+1)
            x=h(i+1);
        end
        f=sprintf('G01 X%d Z%d\nG00 X%d\nG00 Z%d',x,tp(i+1),h(i),tp(i));disp(f);
    end
    g=sprintf('G00 X90');disp(g);
end
g1=sprintf('ET8 M6\nG00 X90');disp(g1);
for i=1:length(rad)
    if rem(rad(i),2)~=0
        rad(i)=rad(i)+1;
    end
    z=hr(i);
    point1=sr(i);point2=sr(i)+2*rad(i);
    rad(i)=rad(i)+5;steps=round(rad(i)/5);
    b1=sprintf('G00 Z%d X%d\nG01 X%d\nG01 Z%d',point1,z,z-steps,point2);disp(b1);
    z=z-steps;
    while z>(hr(i)-rad(i))
        z=z-steps;point1=point1+steps;point2=point2-steps;
        if point1>point2
            point1=round((point2+point1)/2);point2=round((point2+point1)/2);
        end
        c1=sprintf('G00 X%d\nG00 Z%d\nG01 X%d\nG01 Z%d',z+steps,point1,z,point2);disp(c1);
        
    end
    d1=sprintf('G00 X90\nET4 M6\nG00 Z%d\nG00 X%d\nG01 X%d\nG02 X%d Z%d I%d',point1,z+5,z,hr(i),sr(i),rad(i));disp(d1);
    e1=sprintf('G00 X90\nET1 M6\nG00 Z%d\nG00 X%d\nG01 X%d\nG03 X%d Z%d I%d',point2,z+5,z,hr(i),sr(i)+2*rad(i),rad(i));disp(e1);
    f1=sprintf('G00 X90\nM30');disp(f1);
end
