package pck;

import javax.persistence.Entity;

import javax.persistence.OneToOne;

@Entity
public class ForumProjet extends Forum{
	
	@OneToOne
	private Projet projet;
	
	public ForumProjet() {
		super();
	}

	public Projet getProjet() {
		return projet;
	}

	public void setProjet(Projet projet) {
		this.projet = projet;
	}
}
