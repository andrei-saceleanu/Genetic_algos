N=200;
a=-5;
b=5;
max_iter=100;
%f=@(v) v(1)^2+v(2)^2;
f=@(v) 2*v(1)^3+6*v(1)*v(2)^2-3*v(2)^3-150*v(1);
theta=(b-a)*rand(2,2)+a;
C=eye(2);
prev_mean=theta(1,:);
for t=1:max_iter
  population=zeros(N,2);
  fit=zeros(1,N);
  for i=1:N
    population(i,:)=theta(1,:)+theta(2,:).*mvnrnd(zeros(1,2),C,1);
    fit(i)=f(population(i,:));
  endfor
  [s,index]=sort(fit);
  elite=population(index(1:50),:);
  prev_mean=theta(1,:);
  theta(1,:)=mean(elite);
  sx= sum((elite(:,1)-prev_mean(1)).^2)/50;
  sy= sum((elite(:,2)-prev_mean(2)).^2)/50;
  sxy=sum((elite(:,1)-prev_mean(1)).*(elite(:,2)-prev_mean(2)))/50;
  theta(2,:)=sqrt(abs([sx,sy]));
  C=sqrt(abs([sx,sxy;sxy,sy]));
  C=C/norm(C);
  %C=cov(elite);
  %C=C/norm(C);
  %theta(2,:)=sqrt([C(1,1) C(2,2)]);
endfor
theta(1,:)
