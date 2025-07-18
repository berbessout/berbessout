
import numpy as np
import matplotlib.pyplot as plt 
import matplotlib.cm as cm
import math

## Renvoie nb_ech echantillon entre borne_min et borne_max
def tToEvaluate(borne_min, borne_max, nb_ech):
    x_fonc = []; x_tmp = borne_min
    pas = (borne_max - borne_min)/(nb_ech-1)
    while(x_tmp <= borne_max):
        x_fonc.append(x_tmp)
        x_tmp += pas
    x_fonc.append(borne_max) 
    
    return x_fonc

def echantillonnage(nb_ech):
    #  fonction : echantillonnage                                                  
    #  semantique : génére l'ensemble des temps d'évaluation 
    #               à partir du nombre d'échantillon                 
    #  params :                                                             
    #           - int nb_ech : nombre d'échantillon                 
    #  sortie :                      
    #            - List<float> list_tt : temps d'évaluation  


    return np.linspace(0, 1, nb_ech)

def facto(n):
    if n==0 :
        return(1)
    else:
        return(n*facto(n-1))

def k_parmi_n(k, n):
    return(facto(n)/(facto(n-k)*facto(k)))


def build_polys_bernstein(degre_max, list_tt):
    #  fonction : build_polys_bernstein                                                  
    #  semantique : construit les polynomes de Beisntein jusqu'au degré degre_max                
    #  params :                                                             
    #           - int degre_max : degré max         
    #           - float list_tt : t d'évaluation         
    #  sortie :  - List<Array<float, float>> liste_points: une liste contenant un 
    #              tableau de points  de taille nb_echantiilonx2 pour chaque 
    #              polynome de Bernstein
    tab=[]
    n=degre_max
    for i in range(degre_max+1):
        evaluation=[]
        for t in list_tt:
            if t== 0:
                evaluation.append((t, 1 if i==0 else 0))
            else:
                evaluation.append((t,k_parmi_n(i,degre_max)*(1-t)**(n-i)*(t**i)))
        tab.append(np.array(evaluation))
    return tab

def DeCasteljau(DD, tt):
    #  fonction : DeCasteljau                                                  
    #  semantique : applique l'aglgorithme de DCJ sur les valeurs de DD    
    #              pour une courbe définie par les points de controle                  
    #  params :                                                             
    #           - List<float> DD : liste de valeur à approximer (abscisses ou ordonnées)                        
    #           - float tt : temps d'évaluation     
    #                 
    #  sortie : - float d : valeur (abscisses ou ordonnées)  approximée en tt 
    #     
    d=0      
    n=len(DD)-1
    for i in range(len(DD)):
        d += DD[i]*k_parmi_n(i,n)*((1-tt)**(n-i))*(tt**i)
    return(d)


def subdivision(X,Y):
    #  fonction : subdivision                                                  
    #  semantique : correspond à 1 étape de subdivision
    #                             
    #  params :                                                             
    #           - List<float> XX : abscisses des point de controle       
    #           - List<float> YY : odronnees des point de controle        
    #                 
    #  sortie :  (List<float> QX, List<float> QY, List<float> RX, List<float> RY) : Listes contenant les abscisses et les ordonnées des
    #                                                                               deux nouvelles familles Q et R 

    n = len(X)
    QX, QY = [X[0]], [Y[0]]  # Points de contrôle pour la première nouvelle courbe Q
    RX, RY = [X[-1]], [Y[-1]]  # Points de contrôle pour la deuxième nouvelle courbe R
    
    
    for i in range(1, n):
        newX, newY = [], []
        for j in range(n - i):
            x = 0.5*X[j] + 0.5* X[j + 1]
            y = 0.5*Y[j] + 0.5* Y[j + 1]
            newX.append(x)
            newY.append(y)
        QX.append(newX[0])
        QY.append(newY[0])
        RX.append(newX[-1])
        RY.append(newY[-1])
        X, Y = newX, newY
    
    
    RX.reverse()
    RY.reverse()

    return QX, QY, RX, RY

def DeCasteljauSub(X, Y, nombreDeSubdivision):
    #  fonction : DeCasteljauSub                                                  
    #  semantique : renvoie la liste des points composant la courbe
    #              approximante selon un nombre de subdivision données                
    #  params :                                                             
    #           - List<float> XX : abscisses des point de controle       
    #           - List<float> YY : odronnees des point de controle  
    #           - int nombreDeSubdivision : nombre de subdivision        
    #                 
    #  sortie :  (List<float>, List<float>) : une liste avec les abscisses 
    #            et une liste avec les ordonnées des points de la courbe  

    if nombreDeSubdivision == 0:
        return (X, Y)
    
    
    QX, QY, RX, RY = subdivision(X, Y)
    
    XSubdivision, YSubdivision = DeCasteljauSub(QX, QY, nombreDeSubdivision - 1)

    XRSubdivision, YRSubdivision = DeCasteljauSub(RX, RY, nombreDeSubdivision - 1)

    return (XSubdivision + XRSubdivision[1:], YSubdivision + YRSubdivision[1:])



def approximation_3D(XX, YY, ZZ, list_tt):
    #  fonction : approximation_3D                                                  
    #  semantique : calcule les points atteints par la courbe en chauqe temps d'évaluation     
    #                                    
    #  params :                                                             
    #           - Array<float> XX : coorodnnées X des points de controle 3D         
    #           - Array<float> YY : coorodnnées Y des points de controle 3D         
    #           - Array<float> ZZ : coorodnnées Z des points de controle 3D        
    #           - List<float> list_tt : temps d'évaluation                
    #  sortie :
    #           - Array<float> pos : coordonnées 3D des points de la courbe approximée,
    
    pos = []
    for t in list_tt:
        pos.append((DeCasteljau(XX, t), DeCasteljau(YY, t), DeCasteljau(ZZ, t)))
    return pos

def approximation_surface(XX, YY, ZZ, list_tt, nb_point_grille):
    #  fonction : appromation_surface                                                  
    #  semantique : calcule les points atteints par la surface en chauqe temps d'évaluation     
    #                                    
    #  params :                                                             
    #           - Array<float> XX : coorodnnées X des points de controle 3D         
    #           - Array<float> YY : coorodnnées Y des points de controle 3D         
    #           - Array<float> ZZ : coorodnnées Z des points de controle 3D        
    #           - List<float> list_tt : temps d'évaluation                
    #  sortie : 
    #           - Array<vfloat> : coordonnées 3D des points de la surface approximée, 
    #             la dimension associée est : (nb_echantillon, nb_echantillon, 3)
    
    grid_points = np.zeros((nb_point_grille, len(list_tt), 3))
    for i in range(nb_point_grille):
        grid_points[i] = approximation_3D(XX[i], YY[i], ZZ[i], list_tt)

    interpolated_points = np.zeros((len(list_tt), len(list_tt), 3))

    for i in range(len(list_tt)):
       interpolated_points[:, i] = approximation_3D(grid_points[:, i, 0], grid_points[:, i, 1], grid_points[:, i, 2], list_tt)

    return interpolated_points



