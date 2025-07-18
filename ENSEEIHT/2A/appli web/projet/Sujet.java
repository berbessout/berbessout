package pck;
import java.sql.Date;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Sujet {
	@Id
	private int id;
	private String titre;
	private String description;
	private Date dateCreation;
	
	@ManyToOne
	private ForumProjet forum;
	
	@OneToMany(mappedBy = "sujet")
	private Collection<Message> messages;
	
	@OneToMany(mappedBy = "sujet")
	private Collection<Notification> notifications;
	
	public Sujet() {
		super();
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
	public ForumProjet getForum() {
		return forum;
	}
	public void setForum(ForumProjet forum) {
		this.forum = forum;
	}
	public Collection<Message> getMessages() {
		return messages;
	}
	public void setMessages(Collection<Message> messages) {
		this.messages = messages;
	}
	public Collection<Notification> getNotifications() {
		return notifications;
	}
	public void setNotifications(Collection<Notification> notifications) {
		this.notifications = notifications;
	}
	public String getTitre() {
		return titre;
	}
	public void setTitre(String titre) {
		this.titre = titre;
	}
	public Date getDateCreation() {
		return dateCreation;
	}
	public void setDateCreation(Date dateCreation) {
		this.dateCreation = dateCreation;
	}
	
		
}
