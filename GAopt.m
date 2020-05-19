%% 使用遗传算法优化模型
% coilsMatrix：初始线圈参数模型
% ROI：ROI区域
% crossoverP：杂交概率
% mutationP：变异概率
% pop：种群个数
% G：进化代数
% target：中止目标
% targetROI：目标磁场
%%
function finalCoilsMatrix=GAopt(coilsMatrix,ROI,crossoverP,mutationP,pop,G,target,targetROI)
    tic;
    global defaultN;
    global LbtwUD;
    finalCoilsMatrix=zeros(pop,size(coilsMatrix,1)+1);
    %初始化种群
    finalCoilsMatrix(1,1:end-1)=coilsMatrix(:,6)';
    finalCoilsMatrix(2,1:end-1)=coilsMatrix(:,6)';
    finalCoilsMatrix(3:end,1:end-1)=floor(rand(pop-2,size(coilsMatrix,1))*2*defaultN)-defaultN;
    tempCoilsMatrix=coilsMatrix;
    numofCoils=size(coilsMatrix,1);
    %约束条件
    %x-y方向特殊约束：左右相反,上下相等   
    finalCoilsMatrix(:,numofCoils/4+1:numofCoils/2)=-finalCoilsMatrix(:,1:numofCoils/4);%左右相反
    finalCoilsMatrix(:,numofCoils/2+1:end-1)=finalCoilsMatrix(:,1:numofCoils/2);%上下相等
    toc;
    disp('种群初始化完成');
    for i=1:G
        %计算适应度
        sumFitness=0;      
        for j=1:pop          
            tempCoilsMatrix(:,6)=finalCoilsMatrix(j,1:end-1)';
            Bs=ROIcalNew(ROI,tempCoilsMatrix,LbtwUD,400);
            tar=EfunNew(Bs, targetROI);
            finalCoilsMatrix(j,end)=1/tar;
            sumFitness=sumFitness+1/tar;
        end
        %排序
        finalCoilsMatrix=sortrows(finalCoilsMatrix,-size(finalCoilsMatrix,2));
        if finalCoilsMatrix(1,end)>target
            break;
        end
        finalCoilsMatrix(:,end)= finalCoilsMatrix(:,end)/sumFitness;
        newfinalCoilsMatrix=[];
        %产生新种群
        while(size(newfinalCoilsMatrix,1)<pop)
            %选出一对父母
            choose1=rand(1);
            choose2=rand(1);
            %父
            sumTemp=0;
            for j=1:pop
                if finalCoilsMatrix(j,end)+sumTemp>=choose1
                    father=j;
                    break;
                else
                    sumTemp=sumTemp+finalCoilsMatrix(j,end);
                end
                father=j;
            end
            %母
            sumTemp=0;
            for j=1:pop
                if finalCoilsMatrix(j,end)+sumTemp>=choose2
                    mother=j;
                    break;
                else
                    sumTemp=sumTemp+finalCoilsMatrix(j,end);
                end
                mother=j;
            end
            newOne=finalCoilsMatrix(father,:);
            %是否杂交？
            if rand(1)<crossoverP && father~=mother
                crossoverG=rand(1,numofCoils/4);
                %crossoverG(find(crossoverG<0.1))=-1;
                newOne(find(crossoverG<0.1))=finalCoilsMatrix(mother,find(crossoverG<0.1));
            end
            %是否变异？
            if rand(1)<mutationP
                mutationG=rand(1,numofCoils/4);
                newOne(find(mutationG<0.1))=floor(newOne(find(mutationG<0.1)).*(0.5+rand(size(find(mutationG<0.1)))));
            end
            %x-y方向特殊约束：左右相反,上下相等   
            newOne(:,numofCoils/4+1:numofCoils/2)=-newOne(:,1:numofCoils/4);%左右相反
            newOne(:,numofCoils/2+1:end-1)=newOne(:,1:numofCoils/2);%上下相等
            newfinalCoilsMatrix=[newfinalCoilsMatrix;newOne];
        end
        dispContent=['第',num2str(i),'代计算完成，最优适应值为',num2str(finalCoilsMatrix(1,end)*sumFitness)];
        finalCoilsMatrix=newfinalCoilsMatrix;
        toc;
        
        disp(dispContent);
    end
end