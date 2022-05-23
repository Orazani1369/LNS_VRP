clc;
clearvars;
close all;

%% Problem Definition

model=CreateModel();        % Select Model of the Problem
CostFunction=@(q) MyCost(q,model);       % Cost Function

alpha1=0.15; %percent of destroy customers

%% SA Parameters

MaxIt=400;      % Maximum Number of Iterations



T0=10;          % Initial Temperature

alpha=0.2;     % Temperature Damping Rate


tour=parallel_savings_init(model);  % Create initail solution by CW Saving
tour(cellfun(@(routes) any(isnan(routes)),tour)) = [];
for i=1:numel(tour)
    tour{i}=[1,tour{i},1];
end



x.tour=tour;

x.Cost=DisAllRoute(model,x.tour);

% Update Best Solution Ever Found
BestSol=x;

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,3);



T=T0;

tic;
%% SA Main Loop

for it=1:MaxIt



    % Create Destroy
    [xnew.Ldestroy,xnew.list,m]=CreateDestroy(model,x.tour,alpha1);
    try

        [xnew.Lrepair,xnew.unrouted,n]=CreateRepair(model,xnew);
    catch
        break
    end
    xnew.Cost=DisAllRoute(model,xnew.Lrepair);



    if xnew.Cost<=x.Cost
        % xnew is better, so it is accepted
        x=xnew;
        x.tour=xnew.Lrepair;
    else
        % xnew is not better, so it is accepted conditionally
        delta=xnew.Cost-x.Cost;
        p=exp(-delta/T);

        if rand<=p
            x=xnew;
            x.tour=xnew.Lrepair;
        end

    end

    % Update Best Solution
    if x.Cost<=BestSol.Cost
        BestSol=x;
    end

    % Store Best Cost
    BestCost(it,:)=[m,n,BestSol.Cost];


    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it,3))]);

    % Reduce Temperature
    T=alpha*T;


end



%% Results
disp(['  Time = '  num2str(toc)]);

disp(['GAP LNS = ' (num2str((min(BestCost(:,3))-model.Best)/model.Best*100)) ' %']);


figure(1);
plot(BestCost(:,3),'LineWidth',2);
xlabel('Iteration');
ylabel("Cost");

figure(2);
PlotSolution(model,BestSol.tour);
