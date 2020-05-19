function F = myfun(b,xdata)
    F=b(1)+xdata(:,1)*b(2)+xdata(:,2)*b(3)+xdata(:,3)*b(4)+...
        xdata(:,4)*b(5)+xdata(:,5).^2*b(6)+xdata(:,6).^2*b(7);
end