// Time-stamp: <08 déc 2009 08:30 queinnec@enseeiht.fr>

import java.sql.Array;
import java.util.concurrent.Semaphore;

public class PhiloSemAvecEtat implements StrategiePhilo {

    /****************************************************************/
    Semaphore[] philo; 
    EtatPhilosophe[] etat; //Le tableau des état permet d'autoriser un philosophe a manger seulement si ces voisins ne sont pas eux même en train de manger
    Semaphore mutex; //le mutex permet de gerer l'accée au tableau

    public PhiloSemAvecEtat (int nbPhilosophes) {
        philo= new Semaphore[nbPhilosophes];
        etat= new EtatPhilosophe[nbPhilosophes];
        mutex=new Semaphore(1);
        for (int i = 0; i < nbPhilosophes; i++) {
            philo[i] = new Semaphore(1);
            etat[i] = EtatPhilosophe.Pense;
        }
    }

    /** Le philosophe no demande les fourchettes.
     *  Précondition : il n'en possède aucune.
     *  Postcondition : quand cette méthode retourne, il possède les deux fourchettes adjacentes à son assiette. */
    public void demanderFourchettes (int no) throws InterruptedException{
        etat[no]=EtatPhilosophe.Demande;
        mutex.acquire(1);
        if (manger(no)){
            etat[no]=EtatPhilosophe.Mange;
            mutex.release(1); 
        }
        else {
            mutex.release(1);
            philo[no].acquire(1); //Il attend qu'on lui dise qu'il peut manger
            mutex.acquire(1);
            etat[no]=EtatPhilosophe.Mange;
            mutex.release(1);
        }
    }

    private boolean manger(int n) { //Le philosophe peut manger seulement si ces deux voisins ne sont pas entrain de manger
        return(etat[Main.PhiloGauche(n)]!=EtatPhilosophe.Mange && etat[Main.PhiloDroite(n)]!=EtatPhilosophe.Mange);
    }
    /** Le philosophe no rend les fourchettes.
     *  Précondition : il possède les deux fourchettes adjacentes à son assiette.
     *  Postcondition : il n'en possède aucune. Les fourchettes peuvent être libres ou réattribuées à un autre philosophe. */
    public void libererFourchettes (int no) throws InterruptedException{
        mutex.acquire(1);
        etat[no]=EtatPhilosophe.Pense;; //QUand le philosophe a finit de manger il pense, et il va informé ces voisins qu'il a finit de manger en modifiant leur sémaphore si il peuvent manger maintenant que lui a finit
        IHMPhilo.poser(Main.FourchetteDroite(no),EtatFourchette.Table);
        IHMPhilo.poser(Main.FourchetteGauche(no),EtatFourchette.Table);
        if (manger(Main.PhiloDroite(no))) {
            philo[Main.PhiloDroite(no)].release(1);
        }
        if (manger(Main.PhiloGauche(no))) {
            philo[Main.PhiloGauche(no)].release(1);
        }
        mutex.release(1);
    }

    /** Nom de cette stratégie (pour la fenêtre d'affichage). */
    public String nom() {
        return "Implantation Sémaphores, stratégie Philosophe avec etat";
    }

}

