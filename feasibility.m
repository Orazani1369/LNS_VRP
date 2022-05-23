
function Isfeasible=feasibility(model,a,b,Cap)

r=model.r;
% J=model.J;
% c=model.c;

% for j=1:J
Isfeasible=sum(r(a))+r(b)<=Cap;
% end


end