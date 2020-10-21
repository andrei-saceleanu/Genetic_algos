function [individual]=choose_parent(population,s,index)
  suma=sum(s);
  uniform=rand();
  accumulated=double(0);
  for i=1:length(population)
    probability=double(s(i))/suma;
    accumulated+=probability;
    if uniform<=accumulated
      individual=population(index(i),:);
      break;
    endif
  endfor
endfunction
