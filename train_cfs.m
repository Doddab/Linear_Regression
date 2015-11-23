function [] = train_cfs(M,S,L)
% To read the data from the input file and store it in matrix
fid = fopen('Project1_data.txt');
fmt=['%f %*s' repmat('%*d:%f',1,46) '%*[^\n]'];
D = (textscan(fid,fmt));
fclose(fid);
Regression_dataset = cell2mat(D);

save Project1_data.mat Regression_dataset

%To retain the non-zero columns in the dataset
Row = Regression_dataset(:,[2:6,12:46]);

% To fetch the number of rows and columns of input matrix
No_rows = size(Regression_dataset,1);
No_columns = size(Regression_dataset,2);

% To split the Training, Validation and Testing data sets into 80:10:10 ratio respectively
Training_dataset = round((80/100)*No_rows);
Validation_dataset = round((10/100)*No_rows);
Testing_dataset = Validation_dataset+1;
Testing_index = Training_dataset + Validation_dataset;
Training_indexn = Training_dataset + 1;
Validation_indexn = Testing_index + 1;

Training_limit = Row(1:Training_dataset,:);
Validation_limit = Row(Training_indexn:Testing_index,:);
Testing_limit = Row(Validation_indexn:end,:);

No_rows_train = size(Training_limit,1);
No_rows_validate = size(Validation_limit,1);
No_columns_train= size(Training_limit,2);
No_columns_validate= size(Validation_limit,2);
No_rows_test=size(Testing_limit,1);
No_columns_test= size(Testing_limit,2);

%To fetch the target data 
Target = Regression_dataset(:,1);

%To split the Target data as per the Training, testing and validation sets
Training_target = Target(1:Training_dataset,:);
Validation_target = Target(Training_indexn:Testing_index,:);
Testing_target = Target(Validation_indexn:end,:);
one_training = ones(Training_dataset,1);
one_validation = ones(Validation_dataset,1);
one_testing = ones(Testing_dataset,1);
Phi_training = [one_training];
Phi_validation = [one_validation];
Phi_testing = [one_testing];

%To generate the corresponding Identity matrix
Iden=eye(40,40);
Lambda=L;

%To generate the mean for Training dataset
mean_div = round(No_rows_train/M);
i=1;
while i<M
mu_count=i*mean_div;
if(i==1)
mu_start=1;
else
mu_start=mu_count/i; 
end
mu_training=mean(Training_limit(mu_start:mu_count,:)); 
mu_training=mu_training*1.3;

%To compute the Basis Functions 
S=S;
S = S.^2*Iden;
Z = inv(S);

j=1;
while j<=No_rows_train
diff=Training_limit(j,:) - mu_training;
sqs=2*S.^2;
Fi_training(j,:) = exp(-(diff*Z*diff'));
temp_training=Fi_training;
j=j+1;
end

%To compute the Design Matrix and weights from the list of Basis functions
Phi_training=[Phi_training temp_training];
Phi_traininginv=Phi_training'*Phi_training;
Phi_rows=size(Phi_traininginv,1);
Phi_columns=size(Phi_traininginv,2);
Identifier_training=eye(Phi_rows,Phi_columns);
Lambda=L;
Lambda_train=Lambda*Identifier_training;
Weights=inv(Lambda_train+(Phi_training'*Phi_training))*(Phi_training'*Training_target);


%To generate the mean for Validation dataset
mean_divv = round(No_rows_validate/M);
mu_count=i*mean_divv;
if(i==1)
mu_start=1;
else
mu_start=mu_count/i; 
end
mu_validation=mean(Validation_limit(mu_start:mu_count,:));  
mu_training=mu_training*1.3;

l=1;
while l<=No_rows_validate
diffv=Validation_limit(l,:) - mu_validation;
sqsv=2*S.^2;
format long;
Fi_validation(l,:) = exp(-(diffv*Z*diffv'));
temp_validation=Fi_validation;
l=l+1;
end;

%To compute the ERMS from the calculated weights
Phi_validation=[Phi_validation temp_validation];
i=i+1;
end;

m=1;
while m<9
E1_validate = (Phi_validation*Weights-Validation_target)'*(Phi_validation*Weights-Validation_target);
E2_validate = 0.5*Lambda*(Weights'*Weights);
E_validation =  E1_validate + E2_validate;
ERMS_validation = sqrt(E_validation/No_rows_validate);
ERMS_VAL_CFS(M,m) = ERMS_validation;
LAMBDA_VAL_CFS(M,m) = Lambda;
%ERMS_plot(M,L)=ERMS_validation;
%Lambda = Lambda - 0.10;
m=m+1;
end;

%M_cfs=7;
%save M_cfs

save traindata_cfs.mat

%test_cfs(mu_validation,Lambda,Weights,No_rows_test)
end
