function [] = train_gd(M,S,L)
load traindata_cfs.mat
% % To read the data from the input file and store it in matrix
% fid = fopen('Regression_dataset.txt');
% fmt=['%f %*s' repmat('%*d:%f',1,46) '%*[^\n]'];
% D = (textscan(fid,fmt));
% fclose(fid);
% Regression_dataset = cell2mat(D);
% 
% save fileformat.mat
% 
% %To retain the non-zero columns in the dataset
% Row = Regression_dataset(:,[2:6,12:46]);
% 
% % To fetch the number of rows and columns of input matrix

eeta = 1;
M_gd = M;
Lambda_gd = L;
Weights_gd = zeros(M_gd,1);
ERMS_vector_gd(1) = 2;


i=2;
while i<=No_rows_train
 format long;   
%Calculate Weight for each training Phi Matrix Row
%eetaform = eeta*(Training_target(i) - Weights_gd'*Phi_training(i,:)')*
%Phi_training(i,:)';
Weights_gd = Weights_gd + eeta*(Training_target(i) - Weights_gd'*Phi_training(i,:)')* Phi_training(i,:)';

%Calculate Error for Phi Matrix of Validation set
E1_validation_gd = (Phi_validation*Weights_gd-Validation_target)'*(Phi_validation*Weights_gd-Validation_target);
E2_validation_gd = 0.5*Lambda_gd*(Weights_gd'*Weights_gd);
E_validation_gd =  E1_validation_gd + E2_validation_gd;
ERMS_validation_gd_sqrt = sqrt(E_validation_gd/No_rows_validate);
ERMS_validation_gd = ERMS_validation_gd_sqrt;
ERMS_vector_gd(i) = ERMS_validation_gd;
Weight_vector_gd(:,i) = Weights_gd;

%If ERMS(i) is greater than ERMS(i-1), change the eeta value and proceed
if ERMS_vector_gd(i) > ERMS_vector_gd(i-1)
eeta = eeta*0.5;
else
eeta = eeta;
end;
i=i+1;
end;

%To find the minimum of calculated ERMS values
[row,col] = find(ERMS_vector_gd == min(ERMS_vector_gd(:)));
[max, position] = min(ERMS_vector_gd(:));
Weights_gd = Weight_vector_gd(:,position);

M_gd=7;
save train_gd.mat
end



