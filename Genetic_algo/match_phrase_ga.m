N=100;
phrase="this is a test phrase";
len=length(phrase);
vp=zeros(1,len);
for i=1:len
  vp(i)=phrase(i)-' ';
endfor
vp
population=randi(90,N,len);
max_iter=100;
candidates=zeros(max_iter,len);
global_max=-1;
step=-1;
for t=1:max_iter
  %compute fitness
   fit=zeros(1,N);
   for i=1:N
     fit(i)=nnz(abs(population(i,:)-vp)<=4);
   endfor
   %end fitness
   
   %memorize best individual at step t
   [s,index]=sort(fit,'descend');
   candidates(t,:)=population(index(1),:);
   if s(1)>global_max
     global_max=s(1);
     step=t;
   endif
   %end individual
   
   %procreate
   new_population=zeros(N,len);
   k=1;
   while k<=N
     p1=choose_parent(population,s,index);
     p2=choose_parent(population,s,index);
     child=floor((p1+p2)/2);
     poz=randi(2);
     if poz==1
       child=child+randi(2,size(child));
     else
       child=child-randi(2,size(child));
     endif
     new_population(k,:)=child;
     k+=1;
   endwhile
   
   population=new_population;
   %endprocreate
endfor
candidates(step,:)
global_max
step