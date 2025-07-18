import java.util.LinkedList;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;


/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux rédacteurs,
 * implantation: avec un moniteur. */
public class LectRed_Equite implements LectRed
{
    private ReentrantLock moniteur;
    private int nbL;
    private boolean red;
    private LinkedList<Condition> listeProchain;
    private Condition Sas;
    private boolean SasVide;

    public LectRed_Equite() {
        this.moniteur = new ReentrantLock();
        this.nbL = 0;
        this.red = false;
        this.listeProchain = new LinkedList<Condition>();
        this.Sas = moniteur.newCondition();
        this.SasVide = true;
    }

    public void demanderLecture() throws InterruptedException {
        moniteur.lock();
        if (!(!red && !SasVide && listeProchain.isEmpty())) {
            Condition con = moniteur.newCondition();
            listeProchain.addLast(con);
            con.await();
        }
        nbL ++;
        if (!listeProchain.isEmpty()) {
            listeProchain.removeFirst().signal();
        } 
        moniteur.unlock();
    }

    public void terminerLecture() throws InterruptedException {
        moniteur.lock();
        nbL --;
        if (!SasVide && !listeProchain.isEmpty()){
            listeProchain.removeFirst().signal();
        } 
        if (nbL == 0) {              
                Sas.signal();
            }
        
        moniteur.unlock();
    }

    public void demanderEcriture() throws InterruptedException {
        moniteur.lock();
        if (!((nbL == 0) && listeProchain.isEmpty() && !red)) {
            Condition con = moniteur.newCondition(); 
            listeProchain.addLast(con);
            con.await();
        }
        SasVide = true;
        while (!(nbL == 0)) {
            Sas.await();;
        }
        SasVide = false;
        red = true ;
        moniteur.unlock();
    }

    public void terminerEcriture() throws InterruptedException {
        moniteur.lock();
        red = false;
        Sas.signal();
        if (!(listeProchain.isEmpty())) {
            listeProchain.removeFirst().signal();
        }
        moniteur.unlock();
    }

    public String nomStrategie() {
        return "Stratégie: Equite.";
    }
}