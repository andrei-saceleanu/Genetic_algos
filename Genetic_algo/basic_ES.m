N=200;
a=-10;
b=10;
%theta=(b-a)*rand(2,2)+a;
max_iter=100;
%f=@(v) exp(-(v(1)^3)/3+v(1)-v(2)^2); are maxim
f=@(v) 2*v(1)^3+6*v(1)*v(2)^2-3*v(2)^3-150*v(1); % are minim
eps=0.000001;
res=zeros(21,2);
for lambda=10:30
  theta=(b-a)*rand(2,2)+a;
while true
  %sample population and calculate fitness
  population=zeros(N,2);
  fit=zeros(1,N);
  for i=1:N
    population(i,:)=theta(1,:)+theta(2,:).*randn(1,2);
    fit(i)=f(population(i,:));
  endfor
  %end sample
  
  %elite selection and parameter update
  [s,index]=sort(fit);
  elite=population(index(1:lambda),:);
  if norm(mean(elite)-theta(1,:))<eps
    break
  endif
  theta(1,:)=mean(elite);
  theta(2,:)=std(elite);
  
endwhile
res(lambda-9,:)=theta(1,:);
endfor
res