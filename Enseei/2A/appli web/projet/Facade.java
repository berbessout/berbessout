package pck;


import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.ejb.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Singleton
public class Facade {
	
	@PersistenceContext
	EntityManager em;
	
	Utilisateur userCo ;
	
	public Facade() {}
	
	public Utilisateur getUserco() {
		return(this.userCo);
	}
	
	public boolean inscription(String user, String mdp, Utilisateur.Role role) {
		Utilisateur nouveau = new Utilisateur();
		nouveau.setMdp(mdp);
		nouveau.setNom(user);
		nouveau.setRole(role);
		nouveau.setProjets(new ArrayList<Projet>());
		if(em.find(Utilisateur.class, user) == null) {
			this.userCo = nouveau;
			em.persist(nouveau);
			return true;
		}
		return false;
	}
	
	public Utilisateur connexion(String user, String mdp) { //renvoyer plutot l'utilisateur pour verifier si il est nul dans la servlet
		Utilisateur us = em.find(Utilisateur.class, user);
		if (us!=null){
			if (mdp.equals(us.getMdp())) {
				this.userCo=us;
				return us ;
			}
		}
		return null ;
	}
	
	
	public void modifie(String user, String mdp) {
		Utilisateur us = em.find(Utilisateur.class, userCo.getNom());
		us.setMdp(mdp);
		this.userCo.setMdp(mdp);
	}
	
	
	
	
	public void deconnexion() {
		userCo=null;
	}
	
	
	
	public Projet getProjet(int id) {
		return em.find(Projet.class, id);
	}
	
	public Collection<Projet> listeprojets(Utilisateur us){
		return(us.getProjets());
	}
	
	
	public void ajouterMessageSujet(String nom,int idSujet, String texte){
        Utilisateur utilisateur = em.find(Utilisateur.class, nom);
        Sujet sujet = em.find(Sujet.class, idSujet);
        Message message = new Message();
        message.setContenu(texte);
        message.setSujet(sujet);
        message.setUtilisateur(utilisateur);
        message.setDateheure(new Date());
        sujet.getMessages().add(message);
        utilisateur.getMessages().add(message);
        
        em.merge(utilisateur);
        em.merge(sujet);
       
        em.persist(message);
    }

    
    public int ajouterProjet(String nom, String description,Date dateDebut, Date dateFin){
    	Projet projet = new Projet();
    	projet.setDescription(description);
    	projet.setDateDebut(dateDebut);
    	projet.setDateFin(dateFin);
    	projet.setStatutProjet(Statut.ENCOURS);
    	ForumProjet forumProjet = new ForumProjet();
    	forumProjet.setProjet(projet);
    	projet.setForum(forumProjet);
    	
    	userCo.getProjets().add(projet);
    	em.persist(projet);
    	em.persist(forumProjet);
    	return projet.getId();
    	
    }
    
     public void ajouterUtilisateurProjet(String nom, int idProjet){
    	Utilisateur utilisateur = em.find(Utilisateur.class, nom);
    	Projet projet = em.find(Projet.class, idProjet);
    	projet.getUtilisateurs().add(utilisateur);
    	utilisateur.getProjets().add(projet);
    	
    	em.merge(projet);
    	em.merge(utilisateur);
    }
    
    public int ajouterTacheProjet(String titre, String description, Date dateEcheance, Priorite priorite, int idProjet){
    	Projet projet = em.find(Projet.class, idProjet);
    	Tache tache = new Tache();
    	tache.setTitre(titre);
    	tache.setDateEcheance(dateEcheance);
    	tache.setPriorite(priorite);
    	tache.setDescription(description);
    	tache.setProjet(projet);
    	projet.getTaches().add(tache);
    	em.persist(tache);
    	em.merge(projet);
    	
    	return tache.getId();
    }
    
    
    public Collection<Utilisateur> getEleves(){
    	Collection<Utilisateur> listeUtilisateurs = em.createQuery("from Utilisateur", Utilisateur.class).getResultList();
    	Collection<Utilisateur> eleves = new ArrayList<>();
    	for (Utilisateur u : listeUtilisateurs) {
    		if(u.getRole().equals(Utilisateur.Role.ELEVE)){
    			eleves.add(u);
    		}
    	}
    	return eleves;
    }
    
    public void ajouterForumLibre(String nom, String description){}
    
    public void ajouterSujetForum(int idForum, String nom, String decsription){}
    
    
    
   

	
}