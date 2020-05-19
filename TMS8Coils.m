function CoilsMatrix=TMS8Coils(r)
    global defaultN;
    global defaultI;
    global defaultd;
    CoilsMatrix=[];
    rho=r;
    theta=pi/2;
    CoilsMatrix=[CoilsMatrix;rho,theta,0,r,r,defaultN,defaultI,defaultd];
    CoilsMatrix=[CoilsMatrix;rho,-theta,0,-r,r,defaultN,-defaultI,defaultd];

end