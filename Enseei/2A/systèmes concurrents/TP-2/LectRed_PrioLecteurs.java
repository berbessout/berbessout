// Time-stamp: <28 oct 2022 09:24 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux lecteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioLecteurs implements LectRed
{
    
    private ReentrantLock mon;
    private int nbL;
    private int nbLA;
    private boolean red;
    private Condition LectureOK;
    private Condition EcritureOK;

    public LectRed_PrioLecteurs() {
        this.mon = new ReentrantLock();
        this.nbL = 0;
        this.nbLA = 0;
        this.red = false;
        this.LectureOK = mon.newCondition();
        this.EcritureOK = mon.newCondition();
    }

    public void demanderLecture() throws InterruptedException {
        mon.lock();
        while (red) {
            nbLA ++;
            LectureOK.await();
            nbLA --;
        }
        nbL ++;
        if (nbLA > 0) {
            LectureOK.signal();
        }
        mon.unlock();
    }

    public void terminerLecture() throws InterruptedException {
        mon.lock();
        nbL --;
        if (nbL == 0 && nbLA == 0) {
            EcritureOK.signal();
        }
        mon.unlock();
    }

    public void demanderEcriture() throws InterruptedException {
        mon.lock();
        while (!(nbL == 0 && nbLA == 0 && !red)) {
            EcritureOK.await();
        }
        red=true;
        mon.unlock();
    }

    public void terminerEcriture() throws InterruptedException {
        mon.lock();
        red = false;
        if (nbLA == 0) {
            EcritureOK.signal();
        } else {
            LectureOK.signal();
        }
        mon.unlock();
    }

    public String nomStrategie() {
        return "Stratégie: Priorité Lecteurs.";
    }
}
