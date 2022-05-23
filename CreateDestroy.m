function [Ldestroy,list_des,m]=CreateDestroy(model,L,alpha)

m=randi([1 6]);

switch m
    case 1
        
        [Ldestroy,list_des]=Destroy_metho_1(model,L,alpha); %Takhrib 1
        
    case 2
        
        [Ldestroy,list_des]=Destroy_metho_2(model,L,alpha); %Takhrib 2
        
    case 3
        
        [Ldestroy,list_des]=Destroy_metho_3(model,L,alpha); %Takhrib 3
  
    case 4
        
        [Ldestroy,list_des]=Destroy_metho_4(L);            %Takhrib 7
        
        
    case 5
        
        [Ldestroy,list_des]=Destroy_metho_5(model,L,alpha); %Takhrib 11
        
        
    case 6
        
        [Ldestroy,list_des]=Destroy_metho_6(model,L,alpha); %Takhrib 8
end

end


function [Ldestroy,list_des]=Destroy_metho_1(model,L,alpha)
L0=cell2mat(L');
L0(L0==1)=[];

list_des=randsample(L0,floor(model.I*alpha));
Ldestroy=L;

% for i=1:numel(L)
%     for j=1:numel(list_des)
%       Ldestroy{i}(Ldestroy{i}==list_des(j))=[]  ;
%     end
% end
for i=list_des
    Ldestroy=cellfun(@(x) x(x~=i), Ldestroy,'un',0);
end

end

function [Ldestroy,list_des]=Destroy_metho_2(model,L,alpha)
L0=cell2mat(L');
L0(L0==1)=[];

n=randsample(L0,1);

[~,ix]=sort(model.d(n,:));
% [~,ix]=sort(model.d(n,:),'descend');

list_des=[n,ix(2:floor(model.I*alpha))];
list_des(list_des==1)=[];
Ldestroy=L;

% for i=1:numel(L)
%     for j=1:numel(list_des)
%       Ldestroy{i}(Ldestroy{i}==list_des(j))=[]  ;
%     end
% end

for i=list_des
    Ldestroy=cellfun(@(x) x(x~=i), Ldestroy,'un',0);
end

end


function [Ldestroy,list_des]=Destroy_metho_3(model,L,alpha)

f=zeros(model.I,1);
for i=2:model.I
    f(i)= DisAllRoute(model,L) - DisAllRoute(model , cellfun(@(x) x(x~=i), L,'un',0) ) ;
end

[~,ix]=sort(f,'descend');
list_des=ix(1:floor(model.I*alpha));
list_des(list_des==1)=[];
Ldestroy=L;



% for i=1:numel(L)
%     for j=1:numel(list_des)
%       Ldestroy{i}(Ldestroy{i}==list_des(j))=[]  ;
%     end
% end

for i=list_des'
    Ldestroy=cellfun(@(x) x(x~=i), Ldestroy,'un',0);
end

end

function [Ldestroy,list_des]=Destroy_metho_4(L)

n=randsample(numel(L),1);
list_des=L{n}(2:end-1);

list_des(list_des==1)=[];
Ldestroy=L;



% for i=1:numel(L)
%     for j=1:numel(list_des)
%       Ldestroy{i}(Ldestroy{i}==list_des(j))=[]  ;
%     end
% end

for i=list_des
    Ldestroy=cellfun(@(x) x(x~=i), Ldestroy,'un',0);
end

end


function [Ldestroy,list_des]=Destroy_metho_5(model,L,alpha)
L0=cell2mat(L');
L0(L0==1)=[];

n=randsample(L0,1);

[~,ix]=sort(model.d2(n,:));
% [~,ix]=sort(model.d(n,:),'descend');

list_des=[n,ix(2:floor(model.I*alpha))];
list_des(list_des==1)=[];
Ldestroy=L;

% for i=1:numel(L)
%     for j=1:numel(list_des)
%       Ldestroy{i}(Ldestroy{i}==list_des(j))=[]  ;
%     end
% end

for i=list_des
    Ldestroy=cellfun(@(x) x(x~=i), Ldestroy,'un',0);
end

end


function [Ldestroy,list_des]=Destroy_metho_6(model,L,alpha)
L0=cell2mat(L');
L0(L0==1)=[];

x=model.x;
y=model.y;

cnt=1;
n=randsample(L0,1);

list_des=n;
x(1)=inf;
y(1)=inf;


while cnt<=floor(model.I*alpha)
    B=[mean(x(list_des)),mean(y(list_des))];
    distance=sqrt((x-B(1)).^2+(y-B(2)).^2);
    [~,ix]=sort(distance);
    list_des=[list_des,ix(cnt+1)];

    cnt=cnt+1;
end

list_des(list_des==1)=[];

Ldestroy=L;




for i=list_des
    Ldestroy=cellfun(@(x) x(x~=i), Ldestroy,'un',0);
end

end



