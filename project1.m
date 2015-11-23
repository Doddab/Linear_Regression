%Regression Project - LETOR problem
%To increment the values of M and L

    train_cfs(7,0.7,2);
    test_cfs;
    train_gd(7,0.8,2);
    test_gd;
 
    
fprintf('My ubit name is %s\n','harshith');
fprintf('My student number is %d\n',50134007);
fprintf('the model complexity M_cfs is %d\n', M_cfs);
fprintf('the model complexity M_gd is %d\n', M_gd);
fprintf('the regularization parameters lambda_cfs is %4.2f\n', lambda_cfs);
fprintf('the regularization parameters lambda_gd is %4.2f\n', lambda_gd);
fprintf('the root mean square error for the closed form solution is %4.2f\n', rms_cfs);
fprintf('the root mean square error for the gradient descent method is %4.2f\n', rms_gd);