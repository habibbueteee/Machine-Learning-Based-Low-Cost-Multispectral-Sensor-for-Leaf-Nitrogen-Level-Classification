%%
[DataAll,Target]=LoadData();



Data=[DataAll Target] ;

%%
X=Data(:,1:12);
Y=Data(:,13);
%%
X=zscore(X);
%% Shuffle
IndRand=randperm(numel(Y));
X=X(IndRand,:);
Y=Y(IndRand);
XY=[X Y];
%%

nvars = size(X,2);
a=[];
sp=[];
se=[];
pre=[];
fs=[];
co=[];
%%
for i=1:5
    
CV = cvpartition(Y,'Holdout',1/4,'Stratify',false);
costfunction= @(x) costfuncModified(x,X,Y,CV);
options = optimoptions('particleswarm','SwarmSize',200,'Display','iter','MaxIterations',500,'PlotFcn','pswplotbestf','FunctionTolerance',10e-12);
coeff = particleswarm(costfunction,nvars,-5*ones(nvars,1),5*ones(nvars,1),options);

[Mdl,out_test,Y_test]=trainSystem(coeff,X,Y,CV);
[c_matrixp,Result,RefereceResult]= confusion.getMatrix(Y_test,out_test);

a=[a RefereceResult.AccuracyOfSingle];
se=[se RefereceResult.Sensitivity];
sp=[sp RefereceResult.Specificity];
pre=[pre RefereceResult.Precision];
fs=[fs RefereceResult.F1_score];
co=[co ; abs(coeff)];

end


%%
for i=1:5
[trainInd,testInd] = dividerand(length(Y),0.80,.20,0);
X_train=X(trainInd,:);
X_test=X(testInd,:);
Y_train=Y(trainInd);
Y_test=Y(testInd);
fun=@(Train,Target) fitcensemble(Train,Target); 
Mdl=fun(X_train,Y_train);
ypred=predict(Mdl,X_test);

c=confusionmat(Y_test,ypred);
[Result,RefereceResult]=confusion.getValues(c);
acc(i)=Result.Accuracy;

end
mean(acc)
%%
XY=[X Y];
a=[];
b=[];
c=[];
d=[];
for i=1:length(XY(:,1))
    if XY(i,13)==1
        a=[a ; XY(i,1:12)];
    elseif XY(i,13)==2
        b=[b ; XY(i,1:12)];
     elseif XY(i,13)==3
        c=[c ; XY(i,1:12)];
     elseif XY(i,13)==4
        d=[d ; XY(i,1:12)];
    end
    
    
end
%%
%alm=[mean(a) ; mean(b) ; mean(c) ; mean(d)];
alm=[ mean(c) ; mean(d)];
vis=alm(:,1:6);
nir=alm(:,7:12);
%%
xnir=[610 680 730 760 810 860];
xvis=[450 500 550 570 600 650];
vis=vis./max(max(vis));
nir=nir./max(max(nir));

[~,idx]=sort(vis(:,1));
vis=vis(idx,:);

%%
createfigurevis(xvis,vis)
figure (1)

createfigurenir(xnir,nir)
figure (2)




%%

h1=hgload('canola_p1.fig');
h2=hgload('canola_p2.fig');
h3=hgload('corn_p1.fig');
h4=hgload('corn_p2.fig');
h5=hgload('soybean_p1.fig');
h6=hgload('soybean_p2.fig');
h7=hgload('wheat_p1.fig');
h8=hgload('wheat_p2.fig');


figure
s(1)=subplot(4,2,1);
s(2)=subplot(4,2,2);
s(3)=subplot(4,2,3);
s(4)=subplot(4,2,4);
s(5)=subplot(4,2,5);
s(6)=subplot(4,2,6);
s(7)=subplot(4,2,7);
s(8)=subplot(4,2,8);

copyobj(allchild(get(h1,'CurrentAxes')),s(1));
copyobj(allchild(get(h2,'CurrentAxes')),s(2));
copyobj(allchild(get(h3,'CurrentAxes')),s(3));
copyobj(allchild(get(h4,'CurrentAxes')),s(4));
copyobj(allchild(get(h5,'CurrentAxes')),s(5));
copyobj(allchild(get(h6,'CurrentAxes')),s(6));
copyobj(allchild(get(h7,'CurrentAxes')),s(7));
copyobj(allchild(get(h8,'CurrentAxes')),s(8));