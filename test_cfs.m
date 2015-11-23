	load traindata_cfs.mat   
    %function [] = test_cfs(Mut,Lam,Wei,No_rows_test)
% 	for r = 1:6
% 	for y = 1:No_rows_test
% 	difft = Testing_limit(y,:) - mu_validation;
% 	format long;
%   	Fi_testing(y,:) = exp(-(difft*Z*difft'));
% 	tempt_testing = Fi_testing;
% 	end;
% 	Phi_testing = [Phi_testing tempt_testing];
% 	end;

r=1;
y=1;
while r<M
while y<=No_rows_test
	difft = Testing_limit(y,:) - mu_validation;
	format long;
  	Fi_testing(y,:) = exp(-(difft*Z*difft'));
	tempt_testing = Fi_testing;
    y=y+1;
end;
    Phi_testing = [Phi_testing tempt_testing];
    r=r+1;
end;

E1_testing = (Phi_testing*Weights-Testing_target)'*(Phi_testing*Weights-Testing_target);
E2_testing = 0.5*Lambda*(Weights'*Weights);
E_testing =  E1_testing + E2_testing;
ERMS_testing = sqrt(E_testing/No_rows_test);
ERMS_VAL_CFS = ERMS_testing;
LAMBDA_VAL_CFS = Lambda;
M_cfs=M;
lambda_cfs=Lambda;
rms_cfs=ERMS_testing;
%Lambda = Lambda - 0.09;

save test_cfs.mat