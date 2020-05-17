function [Mdl,out_test,Y_test]=trainSystem(x,X,Y,CV)
w=repmat(x(1:size(X,2)),size(X,1),1);
X=w.*X;
%% hold-out


X_train=X(CV.training,:);
Y_train=Y(CV.training);

X_test=X(CV.test,:);
Y_test=Y(CV.test);

%%
Mdl = fitctree(X_train,Y_train);
out_test=predict(Mdl,X_test);
end
