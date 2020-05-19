function heatmap3d(Bs)
    colormap=Bs(:,4);
    maxB=max(colormap);
    minB=min(colormap);
    if maxB==minB
        colormap=(colormap)/(maxB);
    else
        colormap=(colormap-minB)/(maxB-minB);
    end
    
end