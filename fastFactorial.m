%% 快速阶乘

%%
function fn=fastFactorial(n)
    %%加速计算-将计算后的阶乘结果保存下来，后续调用
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