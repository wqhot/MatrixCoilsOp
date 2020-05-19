model1=mphopen('E:\wq\仿真\MatrixCOils_4_27.mph');
table=importdata('E:\wq\仿真\线圈对照表.xlsx');
result=importdata('result52_2.xlsx');


for i=1:size(table,1)
    labelName=cell2mat(table(i,2));
    labelName=labelName(6:end);
    labelNum=str2num(labelName);
    %model.param.set(['N',num2str(i)], '300');
    if result(labelNum)<0
        model1.component('comp1').physics('mf').feature(cell2mat(table(i,1))).feature('cre1').set('Reverse', true);
    else
        model1.component('comp1').physics('mf').feature(cell2mat(table(i,1))).feature('cre1').set('Reverse', false);
    end
    model1.component('comp1').physics('mf').feature(cell2mat(table(i,1))).set('N', abs(result(labelNum)));
end


mphsave(model1,'E:\wq\仿真\MatrixCOils_5_2.mph');