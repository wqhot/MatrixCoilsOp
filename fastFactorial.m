%% ���ٽ׳�

%%
function fn=fastFactorial(n)
    %%���ټ���-�������Ľ׳˽��������������������
    global tableN;
    global tableFN;
    fn=[];
    for i=1:size(n,2)
        if isempty(find(tableN==n(i)))
            tableN=[tableN,n(i)];
            tableFN=[tableFN,factorial(n(i))];
        end
        fn=[fn,tableFN(find(tableN==n(i)))];
    end
    
end