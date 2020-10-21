N=100;
len=100;
xi=1;
yi=1;
xf=12;
yf=24;
population=zeros(N,len,2);
max_iter=40;
th=30;
for i=1:N
  population(i,:,1)=0.2*rand(1,len)-0.1;
  population(i,:,2)=randi(2,1,len);
endfor

global_min=1000000000000;
step=-1;
best=zeros(1,len,2);
v=1;
for t=1:max_iter
  fit=zeros(1,N);
  for i=1:N
    xs=xi;
    ys=yi;
    intersecteaza=0;
    prevx=xs;
    prevy=ys;
    for j=1:len
      if population(i,j,2)==1
        xs+=population(i,j,1);
      else
        ys+=population(i,j,1);
      endif
      if prevx==xs&&((-2*xs+28>=prevy&&-2*xs+28<=ys)||(-2*xs+28>=ys&&-2*xs+28<=prevy))
        intersecteaza=1;
      endif
      if prevy==ys&&((14-ys/2>=prevx&&14-ys/2<=xs)||(14-ys/2>=xs&&14-ys/2<=prevx))
        intersecteaza=1;
      endif
      prevx=xs;
      prevy=ys;
    endfor
    fit(i)=0.85*norm([xs ys]-[xf,yf])+0.15*sum(abs(population(i,:,1)));
    if intersecteaza==1
      fit(i)+=intmax;
    endif
  endfor
  [s,index]=sort(fit);
  if s(1)<global_min
    global_min=s(1);
    best=population(index(1),:,:);
    step=t;
  endif
  
  new_population=zeros(N,len,2);
  k=nnz(s<=th);
  new_population(1:k,:,1)=population(index(s<=th),:,1)+0.2*rand(size(population(index(s<=th),:,1)))-0.1;
  new_population(1:k,:,2)=population(index(s<=th),:,2);
  while k<N
    if k==0
      new_population(1,:,1)=population(index(1),:,1);
      new_population(1,:,2)=population(index(1),:,2);
      k+=1;
      continue;
    endif
    l=randi(k);
    new_population(k+1,:,1)=new_population(l,:,1)+0.2*rand(1,len,1)-0.1;
    uniform=rand(1,len);
    new_population(k+1,:,2)=new_population(l,:,2);
    new_population(k+1,uniform<0.2,2)=3-new_population(k+1,uniform<0.2,2);
    k+=1;
  endwhile
  population=new_population;
  th=0.8*th;
  
endfor
global_min
X=[xi];
Y=[yi];
a=xi;
b=yi;
for i=1:len
if best(1,i,2)==1
a+=best(1,i,1);
else
b+=best(1,i,1);
endif
X=[X a];
Y=[Y b];
endfor
plot(X,Y);
hold on;
vals=4:0.01:10;
plot(vals,-2*vals+28);
plot(xi,yi);
xf
yf
plot(xf,yf,'r');
