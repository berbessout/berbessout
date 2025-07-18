import math 
import numpy as np
import numpy as np
import numpy as np



################################################################################################
###################################### Interpolation - FONCTIONNEL ####################################
################################################################################################

def lagrange(XX, YY, x_int):
    #  fonction : lagrange                                                  
    #  semantique : calcule la valeur en x_int du polynome de Lagrange passant  
    #               par les points de coordonnées (XX,YY)                     
    #  params :                                                             
    #           - float x_int : abscisse du point dont on cherche l'ordonnée                
    #           - List<float> XX : liste des abscisses des points            
    #           - List<float> YY : liste des ordonnées des points            
    #  sortie : 
    #           - float y : valeur en x_int du polynome de Lagrange passant                 
    #           par les points de coordonnées (XX,YY)                         

    # calcul explicite du polynöme de Lagrange
    n = len(XX)
    y_int = 0
    for i in range(n):
        L = 1
        for j in range(n):
            if i != j:
                L *= (x_int - XX[j]) / (XX[i] - XX[j])
        y_int += L * YY[i]

    return y_int


################################################################################################
###################################### Interpolation - PARAMETRIQUE ###################################
################################################################################################

def tToEvaluate(borne_min, borne_max, nb_ech):
    x_fonc = []; x_tmp = borne_min
    pas = (borne_max - borne_min)/nb_ech
    while(x_tmp <= borne_max):
        x_fonc.append(x_tmp)
        x_tmp += pas
    x_fonc.append(borne_max) 
    
    return x_fonc

def lagrange_param(XX, YY, TT, list_tt):
    #  fonction : lagrange_param                                 
    #  semantique : applique la subdivion de Lagrange aux points (XX, YY)      
    #               placés en paramètres en suivant les temps indiqués      
    #  params :                                                             
    #           - List<float> XX : liste des abscisses des points de controle           
    #           - List<float> YY : liste des ordonnées des points de controle                  
    #           - List<float> TT : temps de controle                   
    #           - List<float> list_tt : échantillon des temps sur TT         
    #  sorties : 
    #           - List<float> xx : liste des abscisses des points de la courbe interpolante           
    #           - List<float> yy : liste des ordonnées des points de la courbe interpolante 
    
    xx = []
    yy = []

    for t in list_tt:
        xx.append(lagrange(TT, XX, t))
        yy.append(lagrange(TT, YY, t))

    return xx, yy

def parametrisation_reguliere(nb_echantillon : int, nb_points_controle : int) -> tuple:
    #  fonction : parametrisation_reguliere                                                  
    #  semantique : construit les ensembles de temps correspondant aux temps de controle
    #                et au temps selon la paramétrisation reguliere  
    #                      
    #  params :                                                             
    #           - int nb_echantillon : nombre d'évaluation  
    #           - nb_points_controle : nombre de points de controle                    
    #  sorties :  - List<float> T : temps de controle                  
    #            - List<float> tToEval : temps d'évaluation
    T = [i for i in range(nb_points_controle)]
    tToEval = np.linspace(0, nb_points_controle-1, nb_echantillon)
     
    return T, tToEval

def parametrisation_distance(nb_echantillon, XX, YY):
    #  fonction : parametrisation_distance                                                  
    #  semantique : construit les ensembles de temps correspondant aux temps de controle
    #                et au temps selon la paramétrisation distance  
    #                      
    #  params :                                                             
    #           - int nb_echantillon : nombre d'évaluation            
    #           - List<float> XX : liste des abscisses des points de controle       
    #           - List<float> YY : liste des ordonnées des points de controle     
    #  sorties :  - List<float> T : temps de controle                  
    #            - List<float> tToEval : temps d'évaluation 

    T = [0]
    for i in range(1, len(XX)):
        T.append(np.linalg.norm([XX[i] - XX[i-1], YY[i] - YY[i-1]]) + T[i-1])
    tToEval = np.linspace(0, T[-1], nb_echantillon)
    return T, tToEval

def parametrisation_racinedistance(nb_echantillon, XX, YY):
    #  fonction : parametrisation_racinedistance                                                  
    #  semantique : construit les ensembles de temps correspondant aux temps de controle
    #                et au temps selon la paramétrisation racine de distance  
    #                      
    #  params :                                                             
    #           - int nb_echantillon : nombre d'évaluation         
    #           - List<float> XX : liste des abscisses des points de controle       
    #           - List<float> YY : liste des ordonnées des points de controle    
    #  sorties :  - List<float> T : temps de controle                  
    #            - List<float> tToEval : temps d'évaluation  

    T = [0]
    for i in range(1, len(XX)):
        dt = np.sqrt(np.linalg.norm([XX[i] - XX[i-1], YY[i] - YY[i-1]]))
        T.append(dt + T[-1])
    tToEval = np.linspace(0, T[-1], nb_echantillon)
    return T, tToEval


def parametrisation_Tchebycheff(nb_echantillon, XX):
    #  fonction : parametrisation_Tchebycheff                                                  
    #  semantique : construit les ensembles de temps correspondant aux temps de controle
    #                et au temps selon la paramétrisation de Tchebycheff  
    #                      
    #  params :                                                             
    #           - int nb_echantillon : nombre d'évaluation          
    #           - List<float> XX : liste des abscisses des points de controle          
    #  sorties :  - List<float> T : temps de controle                  
    #            - List<float> tToEval : temps d'évaluation   

    T = []
    for i in range(len(XX)):
        t = np.cos(((2 * i + 1)/ (2 * len(XX))) * np.pi )
        T.append(t)
    
    tToEval = np.linspace(T[0], T[-1],  nb_echantillon)
    
    return T, tToEval


def neville(XX, YY, TT, tt):
    #  fonction : neville                                                  
    #      semantique : calcule le point atteint par la courbe en tt sachant     
    #                   qu'elle passe par les (XX,YY) en TT                       
    #      params :                                                             
    #               - List<float> XX : liste des abscisses des points de controle       
    #               - List<float> YY : liste des ordonnées des points de controle            
    #               - List<float> TT : liste des temps de controle        
    #               - float tt : temps où on cherche le point de la courbe             
    #      sortie : 
    #                - float x : abscisse du point atteint en tt 
    #                - float y : ordonnée du point atteint en tt 
    
    if len(XX) == 1:
        return XX[0], YY[0]
    else:
       x1, y1 =  neville(XX[1:], YY[1:], TT[1:], tt) 
       x2, y2 =  neville(XX[:-1], YY[:-1], TT[:-1], tt)
       return ((TT[0] - tt)*x1 + (tt - TT[-1])*x2)/ (TT[0] - TT[-1]),  ((TT[0] - tt)*y1 + (tt - TT[-1])*y2)/ (TT[0] - TT[-1])


def neville_param(XX, YY, TT, list_tt):
    # fonction : neville_param                                   
    #  semantique : applique l'algorithme de Neville aux points de controle (XX,YY)       
    #               placés en paramètres en suivant les temps de controle TT     
    #  params :                                                             
    #           - List<float> XX : liste des abscisses des points de controle           
    #           - List<float> YY : liste des ordonnées des points de controle           
    #           - List<float> TT : temps de controle                
    #           - List<float> list_tt : échantillon des temps sur TT         
    #  sortie : 
    #           - List<float> xx : liste des abscisses des points de la courbe interpolante           
    #           - List<float> yy : liste des ordonnées des points de la courbe interpolante                                                      
    xx = []; yy = []
    for t in list_tt:
        x, y = neville(XX, YY, TT, t)
        xx.append(x)
        yy.append(y)
    return xx, yy


################################################################################################
###################################### Interpolation - SURFACE FONCTIONNEL #####################
################################################################################################

def lagrange_3D(XX, YY, ZZ, TT, list_tt):
    #  fonction : lagrange_3D                                                  
    # 
    #  params :                                                             
    #           - List<float> XX : liste des abscisses des points de controle           
    #           - List<float> YY : liste des ordonnées des points de controle                  
    #           - List<float> ZZ : liste des cotes des points de controle                  
    #           - List<float> TT : temps de controle                   
    #           - List<float> list_tt : échantillon des temps sur TT         
    #  sorties : 
    #           - List<float> pos : liste des coordonnées 3D des points de la surface interpolante
    
    pos = []

    for t in list_tt:
        pos.append((lagrange(TT, XX, t), lagrange(TT, YY, t), lagrange(TT, ZZ, t)))
    return pos



def interpolate_surface(XX, YY, ZZ, TT, list_tt, nb_point_grille):
    #  fonction : interpolate_surface                                                  
    #      semantique : calcule le point atteint par la surface en tt sachant     
    #                   qu'elle passe par les (XX,YY) en TT                       
    #      params :                                                             
    #               - Array<float> XX : coorodnnées X des points de controle 3D         
    #               - Array<float> YY : coorodnnées Y des points de controle 3D         
    #               - Array<float> ZZ : coorodnnées Z des points de controle 3D        
    #               - List<float> TT : temps de de controle 
    #               - List<float> list_tt : échantillon des temps sur TT                
    #      sortie : 
    #               - Array<vfloat> : coordonnées 3D des points de la surface interpolante, 
    #                 la dimension associée est : (nb_evaluation, nb_evaluation, 3)
    
    # Créer une grille de points pour l'évaluation de la surface
    grid_points = np.zeros((nb_point_grille, len(list_tt), 3))
    for i in range(np.shape(XX)[0]):
        grid_points[i] = lagrange_3D(XX[i], YY[i], ZZ[i], TT, list_tt)
    
    # Initialiser la matrice des points interpolés
    interpolated_points = np.zeros((len(list_tt), len(list_tt), 3))
    
    # Interpoler les points de la grille
    for i in range(len(list_tt)):

       interpolated_points[:, i] = lagrange_3D(grid_points[:, i, 0], grid_points[:, i, 1], grid_points[:, i, 2], TT, list_tt)

    return interpolated_points




