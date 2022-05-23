function D=distance(dc,a)

D=0; 

    for k=1:numel(a)-1
%         D=D+dc(a(k),a(k+1));
        D=D+dc(a(k)+(a(k+1)-1)*size(dc,1));
    end


% ndx=a(1:end-1);
% ndx = ndx + (a(2:end) - 1).*size(dc,1);
% D=sum(dc(ndx));


% D = sum(dc(sub2ind([size(dc,1) size(dc,2)],a(1:end-1),a(2:end))));



end