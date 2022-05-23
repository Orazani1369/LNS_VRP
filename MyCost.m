function [z, sol]=MyCost(q,model)



    sol=ParseSolution(q,model);
    

    Cost=sol.Cost;
    pen_1=sol.MeanCV;
    pen_2=sol.MeanCV2;
    pen_3=sol.MeanCV3;% Sokht;

    BIGM = 1e7;
        
    z = Cost + BIGM*(pen_1+pen_2+pen_3);


end