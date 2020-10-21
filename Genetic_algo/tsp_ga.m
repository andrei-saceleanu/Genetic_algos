%travelling salesman problem genetic approach
N=100;
nodes=4;
max_iter=10;
th=50;
population=zeros(N,nodes+1);
for i=1:N
  population(i,1:nodes)=randperm(nodes);
  population(i,nodes+1)=population(i,1);
endfor

adj=[intmax,2,intmax,12,5;
     2,intmax,4,8,intmax;
     intmax,4,intmax,3,3;
     12,8,3,intmax,10;
     5,intmax,3,10,intmax];

adj2=[intmax,10,15,20;
      10,intmax,35,25;
      15,35,intmax,30;
      20,25,30,intmax];

candidates=zeros(max_iter,nodes+1);
global_min=1000000000000;
step=-1;
for t=1:max_iter
  %compute fitness
   fit=zeros(1,N);
   for i=1:N
     fit(i)=0;
     for j=1:nodes
       fit(i)+=adj2(population(i,j),population(i,j+1));
     endfor
   endfor
   %end fitness
   
   %memorize best individual at step t
   [s,index]=sort(fit);
   candidates(t,:)=population(index(1),:);
   if s(1)<global_min
     global_min=s(1);
     step=t;
   endif
   %end individual
   
   %procreate
   new_population=population(index(s<=th),:);
   while length(new_population)<N
     l=size(new_population,1);
    if l==0
      new_population(1,:)=population(index(1),:);
      l=l+1;
    endif
    r=randi(l);
    k=randi(nodes);
    if k>=2&&k<nodes
      new_population(l+1,:)=[new_population(r,1:k-1) new_population(r,k+1) new_population(r,k) new_population(r,k+2:end)];
    endif
   endwhile
   
   population=new_population;
   th=0.9*th;
   %endprocreate
endfor
candidates
global_min
step
