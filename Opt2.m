function [p] = Opt2(p,D)
n = numel(p);
zmin = -1;
while zmin < 0
    zmin = 0;
    i = 0;
    b = p(n);
    while i < n-2
        a = b;
        i = i+1;
        b = p(i);
        Dab = D(a,b);
        j = i+1;
        d = p(j);
        while j < n
            c = d;
            j = j+1;
            d = p(j);
            z = (D(a,c) - D(c,d)) + D(b,d) - Dab;
            if z < zmin
                zmin = z;
                imin = i;
                jmin = j;
            end
        end
    end
    if zmin < 0
%         disp(imin)
%         disp(jmin)
        p(imin:jmin-1) = p(jmin-1:-1:imin);
    end
end

 