package pck;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;



@Entity
public class Utilisateur {
	enum Role {PROF,ELEVE};
	@Id
	private String nom;
	private String mdp;
	private Role role;
	
	@OneToMany
	private Collection<Projet> projets;
	
	@OneToMany(mappedBy = "utilisateur")
	private Collection<Message> messages;



	public Collection<Projet> getProjets() {
		return projets;
	}

	public void setProjets(Collection<Projet> projets) {
		this.projets = projets;
	}

	public Collection<Message> getMessages() {
		return messages;
	}

	public void setMessages(Collection<Message> messages) {
		this.messages = messages;
	}
	
    public String getNom() {
        return nom;
    }

    public String getMdp() {
        return mdp;
    }



    public void setNom(String nomUtilisateur) {
        this.nom = nomUtilisateur;
    }

    public void setMdp(String motDePasse) {
        this.mdp = motDePasse;
    }

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}


}
