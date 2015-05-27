% This one is a test with mfupdate working properly where all the nets are
% being trained to acheive the same results as MIT's work. It is the same as
% the test on the 29th April, but this time it is working!! (hopefully) THe
% nets are now initialised simply with the standard blf routine (using
% function randn). THis test was run using MATLAB vs 4 so that the mfupdate
% mex file could be used.

clear all

for i=0:9
  eval(['load /user/cs_neural/lawrennd/MIT/digits/vs4tr' num2str(i)])  
  [w, nd, v, lls]=blftest050597(a, 5);
  eval(['save train' num2str(i) '_' date ' w nd v lls a'])
  eval(['w' num2str(i) '=w;']);
  eval(['v' num2str(i) '=v;']);
  eval(['data' num2str(i) '=a;']);
  eval(['lls' num2str(i) '=lls;']);
   
end
eval(['save test_' date])
load /user/cs_neural/lawrennd/MIT/digits/vs4testdata

tests=0;
for k=0:9
  eval(['tests=tests+size(testdata' int2str(k) ', 1);'])
end
nd=[8 24 64];
x=0;

lll=zeros(tests, 10);
for k=0:9
  eval(['data=testdata' int2str(k) ';'])
  totaldata=size(data, 1);
  eval(['ntest' int2str(k) '=totaldata;'])
  for i=1:totaldata
    x=x+1;
    y=0;
    for j=0:9
      y=y+1;
      eval(['v=v' int2str(j) ';'])
      eval(['w=w' int2str(j) ';'])
      v(size(v, 2)-nd(3)+1:size(v,2))=data(i, :);
      v=mfupdate(w, nd, v, 1e-1);
      lll(x, y)=blfll(w, nd, v);
    end
    %disp(['Test number ' int2str(i) ', digit ' int2str(k) ' complete'])
  end
disp(['Test set for digit ' int2str(k) ' complete'])
end

mark1=ntest0      ; mark2=mark1+ntest1; mark3=mark2+ntest2; 
mark4=mark3+ntest3; mark5=mark4+ntest4; mark6=mark5+ntest5; 
mark7=mark6+ntest6; mark8=mark7+ntest7; mark9=mark8+ntest8; 
mark10=mark9+ntest9; 

target=zeros(size(lll, 1), 1);
target(1:mark1)=ones(ntest0, 1);
target(mark1+1:mark2)=ones(ntest1, 1)*2;
target(mark2+1:mark3)=ones(ntest2, 1)*3;
target(mark3+1:mark4)=ones(ntest3, 1)*4;
target(mark4+1:mark5)=ones(ntest4, 1)*5;
target(mark5+1:mark6)=ones(ntest5, 1)*6;
target(mark6+1:mark7)=ones(ntest6, 1)*7;
target(mark7+1:mark8)=ones(ntest7, 1)*8;
target(mark8+1:mark9)=ones(ntest8, 1)*9;
target(mark9+1:mark10)=ones(ntest9, 1)*10;
save confusion_data


