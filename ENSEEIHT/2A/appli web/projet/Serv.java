package pck;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pck.*;

/**
 * Servlet implementation class Serv
 */
@WebServlet("/Serv")
public class Serv extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	Facade facade;
    /**
     * Default constructor. 
     */
    public Serv() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String op = request.getParameter("operation");
		
		if (op.equals("connexion")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			Utilisateur enregistre = facade.connexion(username, password);
			if (enregistre != null ) {
				request.getRequestDispatcher("index.html").forward(request, response);
			}
			else {
				request.getRequestDispatcher("connexionFailConnect.html").forward(request, response);
			}
		}
		
		if (op.equals("s'inscrire")) {
			request.getRequestDispatcher("Inscription.html").forward(request, response);
		}
		
		if (op.equals("inscription")) {
			boolean insc=false;
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String role = request.getParameter("role");
			if (role.equals("enseignant")) {
				insc = facade.inscription(username, password,Utilisateur.Role.PROF);
			}
			else {	
				insc = facade.inscription(username, password,Utilisateur.Role.ELEVE);
			}
			if (insc) {
				request.getRequestDispatcher("index.html").forward(request, response);
			}else {
				request.getRequestDispatcher("connexionFailInscri.html").forward(request, response);
			}
		}
		
		if (op.equals("Modifier")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			facade.modifie(username,password);
			request.getRequestDispatcher("index.html").forward(request, response);
		}
		
		if (op.equals("Deconnexion")) {
			facade.deconnexion();
			request.getRequestDispatcher("connexion.html").forward(request, response);
		}
		if (op.equals("Profil")) {
			Utilisateur utilisateur = facade.getUserco();
			request.setAttribute("utilisateur", utilisateur);
			request.getRequestDispatcher("profil.jsp").forward(request, response);
		}
		if (op.equals("Projet")) {
			Utilisateur utilisateur = facade.getUserco();
			Collection<Projet> listeprojet = facade.listeprojets(utilisateur);
			request.setAttribute("listeprojet", listeprojet);
			if(utilisateur.getRole().equals(Utilisateur.Role.PROF)){
				request.getRequestDispatcher("projetsProfs.jsp").forward(request, response);
			}
			else {
				request.getRequestDispatcher("projetsEleve.jsp").forward(request, response);
			}				
		}
		if(op.equals("Consulter un projet")) {
			String id = request.getParameter("idProjet");
			int idProjet = Integer.parseInt(id);
			Projet p = facade.getProjet(idProjet);
			request.setAttribute("projet", p);
			request.getRequestDispatcher("ConsulterProjet.html").forward(request, response);
		}
		if(op.equals("Creeunnouveauprojet")) {
			Collection<Utilisateur> eleves = facade.getEleves();
			request.setAttribute("eleves", eleves);
			request.getRequestDispatcher("CreeProjet.jsp").forward(request, response);
		}
		if(op.equals("CreationdunProjet")) {
			String nom = request.getParameter("nom");
	        String description = request.getParameter("description");
	        String dateDebut = request.getParameter("dateDebut");
	        String dateFin = request.getParameter("dateFin");
	        //String[] idsEleves = request.getParameterValues("idpersonne");
	        //p.setDateDebut(dateFormat.parse(dateDebut));
	        int i = facade.ajouterProjet(nom,  description,new Date(), new Date());
	        request.getRequestDispatcher("index.html").forward(request, response);
	        
		
		}
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
