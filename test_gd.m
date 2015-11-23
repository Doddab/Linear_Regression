load train_gd.mat
load test_cfs.mat

%To calculate the ERMS for the Testing Gradient Descent phase
E1_testing_gd = (Phi_testing*Weights_gd-Testing_target)'*(Phi_testing*Weights_gd-Testing_target);
E2_testing_gd = 0.5*Lambda_gd*(Weights_gd'*Weights_gd);
E_testing_gd =  E1_testing_gd + E2_testing_gd;
ERMS_testing_gd = sqrt(E_testing_gd/No_rows_test);
rms_gd = ERMS_testing_gd;
Lambda_test_gd = Lambda_gd;
M_gd=M;
lambda_gd=Lambda_gd;

save test_gd.mat
