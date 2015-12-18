/**
 * Projet Cité des Sciences
 */
package com.citedessciences.businesslogic.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Classe d'implémentation d'un utilisateur
 * 
 * @author sklam
 * 
 */
public class Utilisateur implements Serializable {
	
	private static final long serialVersionUID = -3874854695796092628L;

	private Integer id;

	private String login;
	
	private String nom;

	private String prenom;

	private String email;
	
	private String tel;

	private String secteur;

	private ArrayList categorieVisaList;

	private ArrayList listeRoles;
	
	private ArrayList rolesToAdd;

	private boolean actif = true;

	private boolean directeurNotRequired;

	private boolean chefDepartementNotRequired;
	
	private TaskDescription taskDescription;
	
	private Boolean chefProjet = null;
	
	private Boolean reprise = null;

	public boolean isChefDepartementNotRequired() {
		return chefDepartementNotRequired;
	}

	public void setChefDepartementNotRequired(boolean chefDepartementNotRequired) {
		this.chefDepartementNotRequired = chefDepartementNotRequired;
	}

	public boolean isDirecteurNotRequired() {
		return directeurNotRequired;
	}

	public void setDirecteurNotRequired(boolean directeurNotRequired) {
		this.directeurNotRequired = directeurNotRequired;
	}

	public boolean isActif() {
		return actif;
	}

	public void setActif(boolean actif) {
		this.actif = actif;
	}

	public Utilisateur() {
		this.nom = "";
		this.prenom = "";
		this.email = "";
		this.listeRoles = new ArrayList();
	}

	/**
	 * Liste des roles
	 * 
	 * @return
	 */
	public ArrayList getListeRoles() {
		return listeRoles;
	}

	public void setListeRoles(ArrayList listeRoles) {
		this.listeRoles = listeRoles;
	}

	/**
	 * Email
	 * 
	 * @return
	 */
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * Nom
	 * 
	 * @return
	 */
	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	/**
	 * Prénom
	 * 
	 * @return
	 */
	public String getPrenom() {
		return prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	/**
	 * Tel
	 * 
	 * @return tel
	 */
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSecteur() {
		return secteur;
	}

	public void setSecteur(String secteur) {
		this.secteur = secteur;
	}

	public ArrayList getCategorieVisaList() {
		return categorieVisaList;
	}

	public void setCategorieVisaList(ArrayList categorieVisaList) {
		this.categorieVisaList = categorieVisaList;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public TaskDescription getTaskDescription() {
		return taskDescription;
	}

	public void setTaskDescription(TaskDescription taskDescription) {
		this.taskDescription = taskDescription;
	}

	public Boolean getChefProjet() {
		return chefProjet;
	}

	public void setChefProjet(Boolean chefProjet) {
		this.chefProjet = chefProjet;
	}

	public Boolean getReprise() {
		return reprise;
	}

	public void setReprise(Boolean reprise) {
		this.reprise = reprise;
	}

	public boolean equals(Object arg0) {
		boolean boolToReturn = false;
		if(arg0 instanceof Utilisateur){
			if(arg0 != null){
				Utilisateur argUt = (Utilisateur)arg0;
				if((argUt.getId() != null) && (this.getId() != null) && (argUt.getId().equals(this.getId()))){
					boolToReturn = true;
				}
			}
		}
		return boolToReturn;
	}

	public List getRolesToAdd() {
		List newRoles = new ArrayList();
		if(rolesToAdd != null){
			for (Iterator iter = rolesToAdd.iterator(); iter.hasNext();) {
				Role role = (Role) iter.next();
				if(listeRoles != null){
					int index = listeRoles.indexOf(role);
					if(index != -1){
						Role roleComp = (Role) listeRoles.get(index);
						if(!roleComp.isActif()){
							index = -1;
						}
					}
					if(index == -1){
						newRoles.add(role);
					}
				}else{
					newRoles.add(role);
				}
			}
		}
		return newRoles;
	}
	
	public List getRolesToDelete() {
		List deleteRoles = new ArrayList();
		if(listeRoles != null){
			for (Iterator iter = listeRoles.iterator(); iter.hasNext();) {
				Role role = (Role) iter.next();
				if(rolesToAdd == null || !rolesToAdd.contains(role)){
					deleteRoles.add(role);
				}
			}
		}
		return deleteRoles;
	}

	public void setRolesToAdd(ArrayList rolesToAdd) {
		this.rolesToAdd = rolesToAdd;
	}

}
