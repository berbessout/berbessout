// Time-stamp: <08 déc 2009 08:30 queinnec@enseeiht.fr>

import java.sql.Array;
import java.util.concurrent.Semaphore;

public class PhiloSemMutex implements StrategiePhilo {

/*SI le philosophe est celui de numéro 0, alors on le fait prendre une fourchette à droite, sinon à gauche. */

    /****************************************************************/
    Semaphore[] fourchettes;
    Semaphore mutex;
    public PhiloSemMutex (int nbPhilosophes) {
        mutex=new Semaphore(1);
        fourchettes= new Semaphore[nbPhilosophes];
        for (int i = 0; i < nbPhilosophes; i++) {
            fourchettes[i] = new Semaphore(1);
        }
    }

    /** Le philosophe no demande les fourchettes.
     *  Précondition : il n'en possède aucune.
     *  Postcondition : quand cette méthode retourne, il possède les deux fourchettes adjacentes à son assiette. */
    public void demanderFourchettes (int no) throws InterruptedException{
            mutex.acquire(1);
            fourchettes[Main.FourchetteGauche(no)].acquire(1);
            IHMPhilo.poser(Main.FourchetteGauche(no),EtatFourchette.AssietteDroite);
            fourchettes[Main.FourchetteDroite(no)].acquire(1);
            IHMPhilo.poser(Main.FourchetteDroite(no),EtatFourchette.AssietteGauche);
            mutex.release(1);
        }

    /** Le philosophe no rend les fourchettes.
     *  Précondition : il possède les deux fourchettes adjacentes à son assiette.
     *  Postcondition : il n'en possède aucune. Les fourchettes peuvent être libres ou réattribuées à un autre philosophe. */
    public void libererFourchettes (int no){
        fourchettes[Main.FourchetteDroite(no)].release(1);
        IHMPhilo.poser(Main.FourchetteDroite(no),EtatFourchette.Table);
        fourchettes[Main.FourchetteGauche(no)].release(1);
        IHMPhilo.poser(Main.FourchetteGauche(no),EtatFourchette.Table);
    }

    /** Nom de cette stratégie (pour la fenêtre d'affichage). */
    public String nom() {
        return "Implantation Sémaphores, Mutex";
    }

}

