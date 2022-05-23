function DD=DisAllRoute(model,a)

dc=model.d;
D=zeros(1,numel(a)); 
DD=zeros(model.J,1);
for j=1:numel(a)
    for k=1:numel(a{j})-1
        D(j)=D(j)+dc(a{j}(k),a{j}(k+1));
    end
    DD=sum(D);

end