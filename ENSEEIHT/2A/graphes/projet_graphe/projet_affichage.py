import pandas as pd
import networkx as nx
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import itertools
from collections import Counter
import math

def lecture_des_donnees(f): #
    df = pd.read_csv(f, header=0, index_col=0).values
    print(df)
    return(df)

def affichage_du_graphe(pos, km, titre): #prend en entrée une liste de positions et une liste de portées et renvoie une liste de matrice d'adjacence en affichant les graphes correspondants
    m=[]
    n=len(pos)
    figure = plt.figure(1, figsize=(14,7))
    for k in range(len(km)):
        matrice_adjacence = np.zeros((n, n))
        ax = figure.add_subplot(1,len(km),k+1, projection='3d')
        ax.set_title(f'{titre} - Portée {km[k]}km')

        for point in pos:
            ax.scatter(point[0], point[1], point[2], c='blue')

        for (i, j) in itertools.combinations(range(n), 2):
            if np.linalg.norm(pos[i] - pos[j]) < km[k] * 1000:
                ax.plot(*zip(pos[i], pos[j]), c='red')
                matrice_adjacence[i, j] = 1
                matrice_adjacence[j, i] = 1
        m.append(matrice_adjacence.copy())
    plt.tight_layout() 
    plt.show()
    return(m)

def traitement(m): #prend en entrée une matrice d'adjacence et renvoie le degré moyen de l'essaim
    
    #création des figures
    fig = plt.figure(2, figsize=(14,7))
    degre = fig.add_subplot(1,2,1)
    degre.set_title('Distribution du degré')
    degre.set_xlabel('Degré')
    degre.set_ylabel('Fréquence')
    clustering = fig.add_subplot(1,2,2)
    clustering.set_title('Distribution du degré de Clustering')
    clustering.set_xlabel('degré de Clustering')
    clustering.set_ylabel('Fréquence')
    plt.tight_layout()
    plt.tight_layout()


    couleur = ['blue', 'red', 'green']

    for i in range(len(m)):
        #calcul du degre
        somme_degres = np.sum(m[i], axis=0)
        degre_moyen = np.mean(somme_degres) 
        distrib_degre = Counter(somme_degres)
        # Séparer les clés et les valeurs pour le tracé
        coeffs, freqs = zip(*distrib_degre.items())
        # Tracer l'histogramme
        degre.bar(coeffs, freqs,0.9, color = couleur[i], label = f'Portée {(i+1)*20}km')


        #calcul du degre de clustering
        G = nx.from_numpy_array(m[i])
        clustering_coeffs = nx.clustering(G)
        clustering_moyen = np.mean(list(clustering_coeffs.values()))
        coeffs_frequencies = Counter(clustering_coeffs.values())
        # Séparer les clés et les valeurs pour le tracé
        coeffs, freqs = zip(*coeffs_frequencies.items())

        # Tracer l'histogramme
        clustering.bar(coeffs, freqs,0.03, color = couleur[i], label = f'Portée {(i+1)*20}km')
        print(f"Portée {(i+1)*20}km :")
        print(f"degré moyen: {degre_moyen}")
        print(f"Clustering moyen: {clustering_moyen}")
        print('\n')

       


    degre.legend()
    clustering.legend()
    plt.show()
    
def chemins(m, titre):
    fig = plt.figure(3, figsize=(14,7))
    plt.suptitle(titre, fontsize=16)
    graphe_longueurs_chemins = fig.add_subplot(1,3,1, projection='3d')
    graphe_longueurs_chemins.set_title('longueur des plus courts chemins')
    graphe_longueurs_chemins.set_zlabel('longueur')
    distribution_longueurs_chemins = fig.add_subplot(1,3,2)
    distribution_longueurs_chemins.set_title('Distribution des longueurs des plus courts chemins')
    distribution_longueurs_chemins.set_xlabel('longueur')
    distribution_longueurs_chemins.set_ylabel('Fréquence')
    Distribution_nombre_chemins = fig.add_subplot(1,3,3)
    Distribution_nombre_chemins.set_title('Distribution du nombre des plus courts chemins')
    Distribution_nombre_chemins.set_xlabel('nombre des plus courts chemins')
    Distribution_nombre_chemins.set_ylabel('Fréquence')
    plt.tight_layout()


    G = nx.from_numpy_array(m)
    longueurs = dict(nx.all_pairs_shortest_path_length(G))
    longueurs_chemins = np.zeros(np.shape(m))

    # Calcul de la longueur des plus courts chemins
    for i in longueurs.keys():
        for j in longueurs[i].keys():
            longueurs_chemins[i,j] = longueurs[i][j]
    x, y =[i for i in range(len(m[0])) for _ in range(len(m[0]))], [i for i in range(len(m[0]))]*len(m[0]) 
    z = longueurs_chemins.flatten()
    graphe_longueurs_chemins.scatter(x, y, z, c='blue')


    # Distribution de la longueur des plus courts chemins
    distribution_longueurs = Counter(longueurs_chemins.flatten())
    coeffs, freqs = zip(*distribution_longueurs.items())
    distribution_longueurs_chemins.bar(coeffs, freqs,0.9, color = 'blue')

    # Distribution du nombre des plus courts chemins
    nombre_chemins = dict(nx.all_pairs_shortest_path(G))
    distribution_nombre_chemins = Counter([len(nombre_chemins[i][j]) for i in nombre_chemins.keys() for j in nombre_chemins[i].keys()])
    coeffs, freqs = zip(*distribution_nombre_chemins.items())
    Distribution_nombre_chemins.bar(coeffs, freqs,0.9, color = 'blue')

    plt.show()

def chemins_avec_poids(m, titre):
    fig = plt.figure(4, figsize=(14,7))
    plt.suptitle(titre, fontsize=16)
    graphe_longueurs_chemins = fig.add_subplot(1,3,1, projection='3d')
    graphe_longueurs_chemins.set_title('longueur des plus courts chemins')
    graphe_longueurs_chemins.set_zlabel('longueur')
    distribution_longueurs_chemins = fig.add_subplot(1,3,2)
    distribution_longueurs_chemins.set_title('Distribution des longueurs des plus courts chemins')
    distribution_longueurs_chemins.set_xlabel('longueur')
    distribution_longueurs_chemins.set_ylabel('Fréquence')
    Distribution_nombre_chemins = fig.add_subplot(1,3,3)
    Distribution_nombre_chemins.set_title('Distribution du nombre des plus courts chemins')
    Distribution_nombre_chemins.set_xlabel('nombre des plus courts chemins')
    Distribution_nombre_chemins.set_ylabel('Fréquence')
    plt.tight_layout()

    G = nx.from_numpy_array(m)
    longueurs = dict(nx.all_pairs_dijkstra_path_length(G, weight='weight'))
    longueurs_chemins = np.zeros(np.shape(m))

    # Calcul de la longueur des plus courts chemins
    for i in longueurs.keys():
        for j in longueurs[i].keys():
            longueurs_chemins[i,j] = longueurs[i][j]
    x, y =[i for i in range(len(m[0])) for _ in range(len(m[0]))], [i for i in range(len(m[0]))]*len(m[0]) 
    z = longueurs_chemins.flatten()
    graphe_longueurs_chemins.scatter(x, y, z, c='blue')

    # Distribution de la longueur des plus courts chemins
    distribution_longueurs = Counter([math.floor(i/100)*100 for i in longueurs_chemins.flatten()])
    coeffs, freqs = zip(*distribution_longueurs.items())
    distribution_longueurs_chemins.bar(coeffs[1:], freqs[1:],100, color = 'blue')

    # Distribution du nombre des plus courts chemins
    nombre_chemins = dict(nx.all_pairs_dijkstra_path(G))
    distribution_nombre_chemins = Counter([len(nombre_chemins[i][j]) for i in nombre_chemins.keys() for j in nombre_chemins[i].keys()])
    coeffs, freqs = zip(*sorted(distribution_nombre_chemins.items()))
    Distribution_nombre_chemins.plot(coeffs, freqs,0.9, color = 'blue')

    plt.show()

def traitement_avec_poids(pos, titre):
    m=[]
    n=len(pos)
    figure = plt.figure(1, figsize=(14,7))

    matrice_adjacence = np.zeros((n, n))
    for (i, j) in itertools.combinations(range(n), 2):
        if np.linalg.norm(pos[i] - pos[j]) < 60 * 1000:
            matrice_adjacence[i, j] = (np.linalg.norm(pos[i] - pos[j])/1000)**2
            matrice_adjacence[j, i] = (np.linalg.norm(pos[i] - pos[j])/1000)**2
    chemins_avec_poids(matrice_adjacence, titre)


if __name__ == '__main__':

    positions = [(lecture_des_donnees('topology_low.csv'), 'Densité Faible'),(lecture_des_donnees('topology_avg.csv'), 'Densité Moyenne'),(lecture_des_donnees('topology_high.csv'), 'Densité Forte')]
    km = [20, 40, 60]

    for pos in positions:
        matrice_adjacence = affichage_du_graphe(pos[0], km, pos[1])
        print(pos[1] + ' :')
        traitement(matrice_adjacence)
        for i in range(len(matrice_adjacence)):
            chemins(matrice_adjacence[i], F'Chemin le plus court - {pos[1]} - Portée {km[i]}km')
        traitement_avec_poids(pos[0], F'Chemin le plus court avec poids - {pos[1]} - Portée {60}km')
        print('\n')








