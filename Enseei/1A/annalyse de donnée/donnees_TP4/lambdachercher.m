clear;
close all;
clc;

% Parametres pour l'affichage des donnees :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load donnees_app.mat;

% Donnees filtrees :
X = X_app;
Y = Y_app;

% Estimation du SVM lineaire (formulation duale) :

sigma  = 0.0001:0.0001:0.0015;
sigma = 1;
lambda = 50:2:2000;					% Ecart-type du noyau gaussien
pbon = zeros(length(sigma), length(lambda));
%for a = 1:15;
    for k = 1:976;
        
        [X_VS,w,c,code_retour] = SVM_2_souple(X,Y, lambda(k));
        
        % Si l'optimisation n'a pas converge :
        if code_retour ~= 1
	        return;
        end
       
        
        % Pourcentage de bonnes classifications des donnees de test :
        load donnees_test.mat;
        nb_donnees_test = size(X_test,1);
        nb_classif_OK = 0;
        for l = 1:nb_donnees_test
	        x_i = X_test(l,:);
	        prediction = sign(x_i*w - c);
	        if prediction==Y_test(l)
		        nb_classif_OK = nb_classif_OK+1;
	        end
        end
        pbon(k, 1) = double(nb_classif_OK/nb_donnees_test*100);
    end 
%end
plot(lambda, pbon);
%plot3(sigma, lambda, pbon);
xlabel("lambda");
ylabel("pourcentage de bonne classification");