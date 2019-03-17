%% Data Basics
% BY pavana Mysore Ganesh


t = readtable('Immunotherapy.xlsx');
% Changing the name of attributes
attributes = {'sex','age','time','warts','type','area','diameter','result'};
t.Properties.VariableNames=attributes;
%% For each attribute, find its correlation with result of treatment
for i = 1:numel(attributes)-1
correlation(i) = corr(t{:,attributes{i}},t{:,attributes{end}});
end
m = table(attributes(1:end-1)',correlation');
name = {'attributes','correlation'};
m.Properties.VariableNames = name;
disp(m)


%% t-test and find statistically significant attribute
testpos = t{:,'result'} == 1;
testneg = t{:,'result'} == 0;
for i = 1:numel(attributes)-1
    [~,pvalue(i)] = ttest2(t{testpos,attributes{i}},t{testneg,attributes{i}});
end
name2 = {'attributes','pvalue'};
s = table(attributes(1:end-1)',pvalue');
s.Properties.VariableNames = name2;
disp(s)
%  Thershold Value is 0.05
sig = attributes(pvalue<0.01);
fprintf('statistically significant attribute is %s\n', char(sig))

%% Report the correlation coefficients and the pvalues of the attributes in a tabular format.

t1 = table(attributes(1:end-1)',correlation',pvalue');
n3 = {'attributes','correlation','pvalue'};
t1.Properties.VariableNames = n3;
disp(t1)

%% Box plot for significant attribute
boxplot(t{:,'time'},t{:,'result'},'Labels',{'negative','positive'})
xlabel('result');
ylabel('time');









