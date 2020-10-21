N=200;
a=-50;
b=50;
population=(b-a)*rand(N,2)+a;
max_iter=100;
ref_m=-1
ref_n=3
w=200*rand(100,1)-100;
v=3-w;
th=50;
results=zeros(1,max_iter);
res=zeros(max_iter,2);
dim=1;
global_min=1000000000;
x=-1;
y=-1;
for t=1:max_iter
  fit=zeros(1,N);
  for i=1:(size(population,1))
     fit(i)=sum((v(1:100)-population(i,1)*w(1:100)-population(i,2)).^2);
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
  new_population=population(ind(s<=th),:)+2*rand(size(population(ind(s<=th),:)))-1;
  while length(new_population)<N
    l=size(new_population,1);
    if l==0
      new_population(1,:)=population(ind(1));
      l=l+1;
    endif
    r=randi(l);
    new_population(l+1,:)=new_population(r,:)+4*rand(1,2)-2;
  endwhile
  population=new_population;
  th=0.9*th;  
endfor
results;
res;
global_min
x
y
