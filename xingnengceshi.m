testCoilsMatrix=CoilsMatrix;
BsTest=ROIcalNew(ROI,testCoilsMatrix,LbtwUD,400);


testCoilsMatrix=coilsMatrix;
testCoilsMatrix(:,6)=finalCoilsMatrix(1,1:end-1)';
drawResult(testCoilsMatrix);