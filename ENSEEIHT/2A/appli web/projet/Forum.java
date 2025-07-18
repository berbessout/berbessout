package pck;

import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public abstract class Forum{
	@Id
	private int id;
	private String nom;
	private String description;
	
	@OneToMany(mappedBy = "forum")
	private Collection<Sujet> sujets;
	 
	public Forum() {
		super();
	}
	
	public Collection<Sujet> getSujets() {
		return sujets;
	}

	public void setSujets(Collection<Sujet> sujets) {
		this.sujets = sujets;
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

	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	
}