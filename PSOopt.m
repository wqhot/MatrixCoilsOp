function finalCoilsMatrix=PSOopt(coilsMatrix,ROI,pop,G,target,targetROI)
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
    HistoryFinalCoilsMatrix=finalCoilsMatrix;%��ʷ���Ž�
    c1=1.4962;             %��֪ѧϰ����  
    c2=1.4962;             %���ѧϰ����  
    w=0.7298;              %����Ȩ��
    r=1;                   %Լ������
    nv=floor(pop/20);      %������������
    if nv<1
        nv=1;
    end
    V=zeros(pop,size(coilsMatrix,1));%λ�ø����ٶȾ���
    for i=1:G
        %������Ӧ��
        Fitness=0;
        for j=1:pop          
            tempCoilsMatrix(:,6)=finalCoilsMatrix(j,1:end-1)';
            Bs=ROIcalNew(ROI,tempCoilsMatrix,LbtwUD,400);
            tar=EfunNew(Bs, targetROI);
            finalCoilsMatrix(j,end)=1/tar;
            if 1/tar>HistoryFinalCoilsMatrix(j,end)
                HistoryFinalCoilsMatrix(j,:)=finalCoilsMatrix(j,:);
            end
            if 1/tar>Fitness
                Fitness=1/tar;
            end
        end       
        if Fitness>target
            finalCoilsMatrix=sortrows(finalCoilsMatrix,-size(finalCoilsMatrix,2));
            break;
        end
%         if i==1
%             HistoryFinalCoilsMatrix=finalCoilsMatrix;
%         end
        %�����ٶ�
        
        %ȫ������Ⱥ�㷨
%         [BestHistory,BestIndex]=sortrows(HistoryFinalCoilsMatrix,-size(HistoryFinalCoilsMatrix,2));
%         V=w*V+c1.*rand(size(V)).*(HistoryFinalCoilsMatrix(:,1:end-1)-finalCoilsMatrix(:,1:end-1))+...
%             c2.*rand(size(V)).*(repmat(BestHistory(1,1:end-1),pop,1)-finalCoilsMatrix(:,1:end-1));
        %�ֲ�����Ⱥ�㷨
        for j=1:pop
            if nv*(i-1)*2+1>pop
                neibor=1:pop;
            else
                neibor=[j-nv*(i-1):1:j+nv*(i-1)];
                neibor(neibor<1)=neibor(neibor<1)+pop;
                neibor(neibor>pop)=neibor(neibor>pop)-pop;
            end
            [BestHistory,BestIndex]=sortrows(HistoryFinalCoilsMatrix(neibor,:),-size(HistoryFinalCoilsMatrix,2));
            V(j,:)=w*V(j,:)+c1.*rand(size(V(j,:))).*(HistoryFinalCoilsMatrix(j,1:end-1)-finalCoilsMatrix(j,1:end-1))+...
                c2.*rand(size(V(j,:))).*(BestHistory(1,1:end-1)-finalCoilsMatrix(j,1:end-1));
        end
        finalCoilsMatrix(:,1:end-1)=floor(finalCoilsMatrix(:,1:end-1)+r*V);
        %x-y��������Լ���������෴,�������   
        finalCoilsMatrix(:,numofCoils/4+1:numofCoils/2)=-finalCoilsMatrix(:,1:numofCoils/4);%�����෴
        finalCoilsMatrix(:,numofCoils/2+1:end-1)=finalCoilsMatrix(:,1:numofCoils/2);%�������       
        dispContent=['��',num2str(i),'��������ɣ�������ӦֵΪ',num2str(Fitness)];
        toc;        
        disp(dispContent);       
    end   
    finalCoilsMatrix=sortrows(finalCoilsMatrix,-size(finalCoilsMatrix,2));
end