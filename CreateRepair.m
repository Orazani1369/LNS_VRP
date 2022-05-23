function [Lrepair,unrouted,m]=CreateRepair(model,L)

m=randi([1 2]);

switch m
    case 1
        
        [Lrepair,unrouted]=Repair_metho_1(model,L);
        
    case 2
        
        [Lrepair,unrouted]=Repair_metho_2(model,L);
        
    case 3
        
        [Lrepair,unrouted]=Opt3_intra(model,L);
        
end

end


function [Lrepair,unrouted]=Repair_metho_1(model,L)


insert = @(a, x, n)cat(2,  x(1:n), a, x(n+1:end));
z=inf;
i=1;
unrouted=[];
c=model.c;


node=L.list;
tour=L.Ldestroy;
a=zeros(numel(node),numel(tour));
Tnew=cell(numel(node),numel(tour));
regret=zeros(numel(node),numel(tour));
while ~isempty(node)
    for j=1:numel(tour)
        for n=1:numel(node)
            
            if feasibility(model,tour{j},node(n),c(j))
                while i~=numel(tour{j})
                    
%                     tournew=insert(node(n),tour{j},i);
                    tournew= [tour{j}(1:i),node(n),tour{j}(i+1:end)];
%                     tournew=insert2(tour{j},node(n),i);
%                     tournew=vectorInsertAfter(tour{j},i,node(n));
                    bq1=distance(model.d,tournew);
                    bq2=distance(model.d,tour{j});
                    if bq1-bq2<z
                        z=bq1-bq2;
                        T=tournew;
                    end
                    i=i+1;
                end
                a(n,j)=z;
            else
                a(n,j)=1e9;
                T=tour{j};
                T=Opt2(T,model.d);
            end
            regret(n,j)=a(n,j)-min(a(:,j));
            i=1;
            z=inf;
            Tnew{n,j}=T;

        end
        regret=a-min(a,[],2);
        SN=sum(regret,2);
        
    end
    if SN~=0
        
    [~,ix]=max(SN);
    node(ix)=[];
    [~,iy]=min(a(ix,:));
    tour{iy}=Tnew{ix,iy};
    a=[];
    Tnew=[];
    else
        unrouted=[unrouted,node];
        return
        
    end
 
end

Lrepair=tour;
end



function [Lrepair,unrouted]=Repair_metho_2(model,L)


insert = @(a, x, n)cat(2,  x(1:n), a, x(n+1:end));
z=inf;
i=1;
unrouted=[];
c=model.c;


node=L.list;
tour=L.Ldestroy;
a=zeros(numel(node),numel(tour));
Tnew=cell(numel(node),numel(tour));
regret=zeros(numel(node),numel(tour));
while ~isempty(node)
    for j=1:numel(tour)
        for n=1:numel(node)
            
            if feasibility(model,tour{j},node(n),c(j))
                while i~=numel(tour{j})
                    
%                     tournew=insert(node(n),tour{j},i);
                    tournew= [tour{j}(1:i),node(n),tour{j}(i+1:end)];
%                     tournew=insert2(tour{j},node(n),i);
%                     tournew=vectorInsertAfter(tour{j},i,node(n));
                        bq1=distance(model.d,tournew);
                        bq2=distance(model.d,tour{j});
                    if bq1-bq2<z
                        z=bq1-bq2;
                        T=tournew;
                    end
                    i=i+1;
                end
                a(n,j)=z;
            else
                a(n,j)=1e9;
                T=tour{j};
                T=Opt2(T,model.d);
            end
            regret(n,j)=a(n,j)-min(a(:,j));
            i=1;
            z=inf;
            Tnew{n,j}=T;

        end
        regret=(a-min(a,[],2)) .* (randi([800 1200],1,1)/1000) ;
%         regret=(a-min(a,[],2)) .* (randi([800 1200],size(regret,1),size(regret,2))/1000) ;
        SN=sum(regret,2);
        
    end
    if SN~=0
        
    [~,ix]=max(SN);
    node(ix)=[];
    [~,iy]=min(a(ix,:));
    tour{iy}=Tnew{ix,iy};
    a=[];
    Tnew=[];
    else
        unrouted=[unrouted,node];
        return
        
    end
 
end

Lrepair=tour;
end

