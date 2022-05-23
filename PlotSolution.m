function PlotSolution3(model,tour)

J=numel(tour);



x=model.x;
y=model.y;
x0=x(1);
y0=y(1);





Colors=hsv(J*1);


for j=1:J
    
    if isempty(tour{j})
        continue;
    end
    
    X=[x0 x(tour{j}(2:end-1)) x0];
    Y=[y0 y(tour{j}(2:end-1)) y0];
    
    Color=1*Colors(j,:);
    

    
    plot(X,Y,'-o',...
        'Color',Color,...
        'LineWidth',2,...
        'MarkerSize',10,...
        'MarkerFaceColor',Color);
    
    hold on;
    
    
end

    plot(x0,y0,'ks',...
    'LineWidth',2,...
    'MarkerSize',15,...
    'MarkerFaceColor','yellow');
    hold on;

for i=2:numel(x)
    text(x(i)-.5,y(i)+2,num2str(i));
end


 Legend=cell(numel(tour),1);
 for iter=1:numel(tour)
   Legend{iter}=strcat('Route ', num2str(iter));
   
 end
 legend(Legend);
 


end

