package pck;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Notification {
	@Id
	private int id;
	private String contenu;
	private Boolean lue;
	private Date dateHeure;
	
	@ManyToOne
	private Sujet sujet;
	
	

	public Notification() {
		super();
	}
	public Date getDateHeure() {
		return dateHeure;
	}
	public void setDateHeure(Date dateHeure) {
		this.dateHeure = dateHeure;
	}
	public Boolean getLue() {
		return lue;
	}
	public void setLue(Boolean lue) {
		this.lue = lue;
	}
	public String getContenu() {
		return contenu;
	}
	public void setContenu(String contenu) {
		this.contenu = contenu;
	}
	public Sujet getSujet() {
		return sujet;
	}
	public void setSujet(Sujet sujet) {
		this.sujet = sujet;
	}
	
}
