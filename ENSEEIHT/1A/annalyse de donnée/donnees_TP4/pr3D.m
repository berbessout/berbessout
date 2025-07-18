clear;
close all;
clc;

% Parametres pour l'affichage des donnees :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load donnees_train_3caracteristiques.mat;

% Donnees non filtrees :
X = X_train;
Y = Y_train;

% Estimation du SVM avec noyau gaussien :
sigma = 0.036;					% Ecart-type du noyau gaussien
lambda = 10000;
[X_VS,Y_VS,Alpha_VS,c,code_retour] = SVM_3_souple(X,Y,sigma, lambda);

% Si l'optimisation n'a pas converge :
if code_retour ~= 1
	return;
end


%
% Pourcentage de bonnes classifications des donnees de test :
load donnees_test_3caracteristiques.mat;
nb_donnees_test = size(X_test,1);
nb_classif_OK = 0;
for i = 1:nb_donnees_test
	x_i = X_test(i,:);
	prediction = sign(exp(-sum((X_VS-x_i).^2,2)/(2*sigma^2))'*diag(Y_VS)*Alpha_VS-c);
	if prediction==Y_test(i)
		nb_classif_OK = nb_classif_OK+1;
	end
end
fprintf('Pourcentage de bonnes classifications : %.1f %%\n',double(nb_classif_OK/nb_donnees_test*100));
