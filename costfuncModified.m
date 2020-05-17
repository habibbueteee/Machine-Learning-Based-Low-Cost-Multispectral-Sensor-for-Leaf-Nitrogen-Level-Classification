function cost=costfuncModified(x,X,Y,CV)

[Mdl,out_test,Y_test]=trainSystem(x,X,Y,CV);
%%

[~,Result]= confusion.getMatrix(Y_test,out_test,0);

cost=1-abs(Result.MatthewsCorrelationCoefficient);


end