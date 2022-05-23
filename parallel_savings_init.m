function routes=parallel_savings_init(model)

D=model.d;
d=model.r;
C=model.c(1);
L=0;
minimize_K=false;



C_EPS=1e-1;

N=size(D,1);

ignore_negative_savings=true;

routes=cell(numel(2:N),1);
route_costs=cell(numel(routes),1);

for i=1:numel(routes)
    routes{i}=i+1;
end

if C
    route_demands=d(2:end);
else
    route_demands=zeros(N,1);
    
end

if L>0.1
    for i=1:numel(routes)
        
        route_costs{i}=D(1,i+1)+D(i+1,1);
    end
    
    
end
    
saving=clarke_wright_savings_function(model);

endnode_to_route=[1,1:N-1];



for p=1:size(saving,1)
%     best_saving=saving(p,1);
    i=saving(p,3);
    j=saving(p,4);
    
    if ignore_negative_savings
        cw_saving = D(i,1)+D(1,j)-D(i,j);
        if cw_saving<0
            break
        end
    end
    
    left_route = endnode_to_route(i);
    right_route = endnode_to_route(j);
    
    
    if isnan(left_route) || isnan(right_route) || left_route==right_route
        continue
    end
    
%     if isempty(left_route) || isempty(right_route) || left_route==right_route
%         continue
%     end
    
    if C
        merged_demand = route_demands(left_route)+route_demands(right_route);
        if merged_demand-C_EPS > C
            continue
        end
    end
    
    
%     if L>0.1
%         merged_cost = route_costs[left_route]-D[0,i]+\route_costs[right_route]-D[0,j]+\D[i,j]
%     end
    
    if C
        route_demands(left_route) = merged_demand;
    end
    
%     if L>0.1
%         route_costs(left_route) = merged_cost;
%     end

    if routes{left_route}(1)==i
        routes{left_route}=flip(routes{left_route});
    end

    if routes{right_route}(end)==j
        routes{right_route}=flip(routes{right_route});
    end

    if numel(routes{left_route})>1
        endnode_to_route( routes{left_route}(end) ) = nan;
    end
    
    if numel(routes{right_route})>1
        endnode_to_route( routes{right_route}(1) ) = nan;
    end
    
    endnode_to_route( routes{right_route}(end) ) = left_route;
    

    routes{left_route}=[routes{left_route},routes{right_route}];

    routes{right_route} = nan;

end

end