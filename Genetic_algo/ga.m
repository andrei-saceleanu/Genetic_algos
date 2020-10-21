N=500;
a=-3;
b=3;
population=(b-a)*rand(N,2)+a;
max_iter=300;
%f=@(v) sqrt(v(1)^2+v(2)^2);
f=@(v) 2*v(1)^3+6*v(1)*v(2)^2-3*v(2)^3-150*v(1);
th=30;
results=zeros(1,max_iter);
res=zeros(max_iter,2);
dim=1;
global_min=1000000000;
x=-1;
y=-1;
for t=1:max_iter
  fit=zeros(1,N);
  for i=1:(size(population,1))
    fit(i)=f(population(i,:));
  endfor
  [s,ind]=sort(fit);
  results(dim)=s(1);
  if s(1)<global_min
    global_min=s(1);
    x=population(ind(1),1);
    y=population(ind(1),2);
  endif
  res(dim,:)=population(ind(1),:);
  dim=dim+1;
  new_population=population(ind(s<=th),:)+0.2*rand(size(population(ind(s<=th),:)))-0.1;
  while length(new_population)<N
    l=size(new_population,1);
    if l==0
      new_population(1,:)=population(ind(1));
      l=l+1;
    endif
    r=randi(l);
    new_population(l+1,:)=new_population(r,:)+0.2*rand(1,2)-0.1;
  endwhile
  population=new_population;
  th=0.9*th;  
endfor
results;
res;
global_min
x
y
