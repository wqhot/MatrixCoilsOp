%% ʹ���Ŵ��㷨�Ż�ģ��
% coilsMatrix����ʼ��Ȧ����ģ��
% ROI��ROI����
% crossoverP���ӽ�����
% mutationP���������
% pop����Ⱥ����
% G����������
% target����ֹĿ��
% targetROI��Ŀ��ų�
%%
function finalCoilsMatrix=GAopt(coilsMatrix,ROI,crossoverP,mutationP,pop,G,target,targetROI)
    tic;
    global defaultN;
    global LbtwUD;
    finalCoilsMatrix=zeros(pop,size(coilsMatrix,1)+1);
    %��ʼ����Ⱥ
    finalCoilsMatrix(1,1:end-1)=coilsMatrix(:,6)';
    finalCoilsMatrix(2,1:end-1)=coilsMatrix(:,6)';
    finalCoilsMatrix(3:end,1:end-1)=floor(rand(pop-2,size(coilsMatrix,1))*2*defaultN)-defaultN;
    tempCoilsMatrix=coilsMatrix;
    numofCoils=size(coilsMatrix,1);
    %Լ������
    %x-y��������Լ���������෴,�������   
    finalCoilsMatrix(:,numofCoils/4+1:numofCoils/2)=-finalCoilsMatrix(:,1:numofCoils/4);%�����෴
    finalCoilsMatrix(:,numofCoils/2+1:end-1)=finalCoilsMatrix(:,1:numofCoils/2);%�������
    toc;
    disp('��Ⱥ��ʼ�����');
    for i=1:G
        %������Ӧ��
        sumFitness=0;      
        for j=1:pop          
            tempCoilsMatrix(:,6)=finalCoilsMatrix(j,1:end-1)';
            Bs=ROIcalNew(ROI,tempCoilsMatrix,LbtwUD,400);
            tar=EfunNew(Bs, targetROI);
            finalCoilsMatrix(j,end)=1/tar;
            sumFitness=sumFitness+1/tar;
        end
        %����
        finalCoilsMatrix=sortrows(finalCoilsMatrix,-size(finalCoilsMatrix,2));
        if finalCoilsMatrix(1,end)>target
            break;
        end
        finalCoilsMatrix(:,end)= finalCoilsMatrix(:,end)/sumFitness;
        newfinalCoilsMatrix=[];
        %��������Ⱥ
        while(size(newfinalCoilsMatrix,1)<pop)
            %ѡ��һ�Ը�ĸ
            choose1=rand(1);
            choose2=rand(1);
            %��
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
            %ĸ
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
            %�Ƿ��ӽ���
            if rand(1)<crossoverP && father~=mother
                crossoverG=rand(1,numofCoils/4);
                %crossoverG(find(crossoverG<0.1))=-1;
                newOne(find(crossoverG<0.1))=finalCoilsMatrix(mother,find(crossoverG<0.1));
            end
            %�Ƿ���죿
            if rand(1)<mutationP
                mutationG=rand(1,numofCoils/4);
                newOne(find(mutationG<0.1))=floor(newOne(find(mutationG<0.1)).*(0.5+rand(size(find(mutationG<0.1)))));
            end
            %x-y��������Լ���������෴,�������   
            newOne(:,numofCoils/4+1:numofCoils/2)=-newOne(:,1:numofCoils/4);%�����෴
            newOne(:,numofCoils/2+1:end-1)=newOne(:,1:numofCoils/2);%�������
            newfinalCoilsMatrix=[newfinalCoilsMatrix;newOne];
        end
        dispContent=['��',num2str(i),'��������ɣ�������ӦֵΪ',num2str(finalCoilsMatrix(1,end)*sumFitness)];
        finalCoilsMatrix=newfinalCoilsMatrix;
        toc;
        
        disp(dispContent);
    end
end