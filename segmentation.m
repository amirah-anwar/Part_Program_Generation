function [ d,st,h,tp,rad,sr,hr ] = segmentation( imEdge )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
   [r,c]=size(imEdge);
   x=zeros(1,c);
   start=0;count=0;i=1;
   for b=2:c-1
    for a=2:r-1
        if imEdge(a,b)==1
            start=1;
        end
        if sum(imEdge(a:r,b))==0
            start=0;
        end
        if start==1
            count=count+1;
        end
    end
   x(i)=count;count=0;i=i+1;
   
   end
    for k=1:length(x)-3
       y(k)=x(k+3)-x(k);
   end
   start=0;pos=0;neg=0;zer=0;p=1;q=1;
   for m=1:length(y)-5
       if y(m)~=0 && y(m+1)~=0 && y(m+2)~=0 && y(m+3)~=0 && y(m+5)~=0 && y(m+5)~=0
           if start==0
               init=m;
           end
           start=1;
       end
       if start==1
           if y(m)>0 && y(m)<40
               zer=0;pos=pos+1;
           elseif y(m)<0 && y(m)>-40
               zer=0;neg=neg+1;
           elseif y(m)==0
               zer=zer+1;
           end
           if zer>5
               final=m-zer;
               if pos>10 && neg>10
                   rad(p)=(final-init)/2;sr(p)=init;hr(p)=x(init-5);p=p+1;
               elseif pos>10
                   tp(q)=final;tp(q+1)=init;
                   h(q)=x(final+5);h(q+1)=x(init-5);q=q+2;
               elseif neg>10
                   tp(q)=init;tp(q+1)=final;
                   h(q)=x(init-5);h(q+1)=x(final+5);q=q+2;
               end
               start=0;pos=0;neg=0;zer=0;
           end
       end
   end
   for u=1:length(rad)
       x(sr(u):sr(u)+(2*rad))=x(sr(u)-5);
   end
   for v=1:2:length(h)
       if tp(v)<tp(v+1)
           x(tp(v):tp(v+1))=x(tp(v)-5);
       elseif tp(v)>tp(v+1)
           x(tp(v+1):tp(v))=x(tp(v)+5);
       end
   end
   i=1;
   for j=2:c-1
       if abs(x(j)-x(j-1))>10
           if abs(x(j)-x(j+10))<10
                d(i)=x(j+10);st(i)=j;i=i+1;
           end
       end
   end
   sr=sr-st(1);tp=tp-st(1);st=st-st(1);
     d=0.2083*d;st=0.2092*st;h=0.2083*h;tp=0.2092*tp;rad=0.2092*rad;sr=0.2092*sr;hr=0.2083*hr;
     d=round(d);st=round(st);h=round(h);tp=round(tp);rad=round(rad);sr=round(sr);hr=round(hr);
end

