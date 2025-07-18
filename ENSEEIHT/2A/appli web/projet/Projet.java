package pck;

import java.util.Date;
import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Projet {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String nom;
	private String description;
	private Date dateDebut;
	private Date dateFin;
	private Statut statutProjet;
	
	@OneToMany(mappedBy = "projet")
	private Collection<Tache> taches;
	
	@OneToMany(mappedBy = "projets")
	private Collection<Utilisateur> utilisateurs;
	
	@OneToOne(mappedBy = "projet")
	private ForumProjet forum;
	
	public Projet() {
		super();
		taches = new ArrayList<Tache>();
		utilisateurs = new ArrayList<Utilisateur>();
		
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Collection<Utilisateur> getUtilisateurs() {
		return utilisateurs;
	}
	public void setUtilisateurs(Collection<Utilisateur> utilisateurs) {
		this.utilisateurs = utilisateurs;
	}
	
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	public Date getDateDebut() {
		return dateDebut;
	}
	public void setDateDebut(Date dateDebut) {
		this.dateDebut = dateDebut;
	}
	public Date getDateFin() {
		return dateFin;
	}
	public void setDateFin(Date dateFin) {
		this.dateFin = dateFin;
	}
	public Statut getStatutProjet() {
		return statutProjet;
	}
	public void setStatutProjet(Statut statutProjet) {
		this.statutProjet = statutProjet;
	}
	public Collection<Tache> getTaches() {
		return taches;
	}
	public void setTaches(Collection<Tache> taches) {
		this.taches = taches;
	}
	public ForumProjet getForum() {
		return forum;
	}
	public void setForum(ForumProjet forum) {
		this.forum = forum;
	}

}
