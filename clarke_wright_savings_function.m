function saving=clarke_wright_savings_function(model)
N=size(model.d,1);
D=model.d;
n=N-1;




saving=zeros(ceil((n*n-n)/2),4);
idx=1;
for i=2:N
    for j=i+1:N
        s=D(i,1)+D(1,j)-D(i,j);
        saving(idx,1)=s;
        saving(idx,2)=-D(i,j);
        saving(idx,3)=i;
        saving(idx,4)=j;
        idx=idx+1;
    end
end
        
saving=sortrows(saving,1,'descend');



end