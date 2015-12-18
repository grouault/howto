/**
 * Projet Cité des Sciences
 */
package com.citedessciences.businesslogic.mapping;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.citedessciences.bdd.beans.HRefCategorieVisa;
import com.citedessciences.bdd.beans.HRefRole;
import com.citedessciences.bdd.beans.HRoleUtilisateur;
import com.citedessciences.bdd.beans.HRoleUtilisateurPK;
import com.citedessciences.bdd.beans.HUtilisateur;
import com.citedessciences.bdd.constants.BDDConstants;
import com.citedessciences.businesslogic.constants.AdminConstants;
import com.citedessciences.businesslogic.entity.CategorieVisa;
import com.citedessciences.businesslogic.entity.Role;
import com.citedessciences.businesslogic.entity.Utilisateur;
import com.citedessciences.businesslogic.workflow.WKFConstants;

/**
 * Classe de mapping de l'objet Utilisateur sur l'ensemble des couches de
 * l'application
 * 
 * @author sklam
 * 
 */
public class UtilisateurMapper implements MappingInterface {

	// private AdminUtilisateur adminUtilisateur = new AdminUtilisateur();

	public List BDDToMetier(List l, boolean useVisas) {
		ArrayList utilisateurAsMetierToReturn = new ArrayList();
		Iterator it = l.iterator();
		while (it.hasNext()) {
			HUtilisateur utilisateurHibernate = (HUtilisateur) it.next();
			Utilisateur utilisateur = (Utilisateur) BDDToMetier(utilisateurHibernate, useVisas);
			utilisateurAsMetierToReturn.add(utilisateur);
		}
		return utilisateurAsMetierToReturn;
	}

	public List BDDToMetier(List l) {
		return null;
	}
	
	public List MetierToBDD(List l) {
		// TODO Auto-generated method stub
		return null;
	}

	public List MetierToStruts(List o) {
		// TODO Auto-generated method stub
		return null;
	}

	public List StrutsToMetier(List l) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * Mapping BDD -> Métier
	 */
	public Object BDDToMetier(Object o) {
		return null;
	}
	
	/**
	 * Mapping BDD -> Métier
	 * @param o : objet sur lequel on travaille
	 * @param useVisas : indique si l'on doit récuperer ou non les visas	 * 
	 * @return
	 */
	public Object BDDToMetier(Object o, boolean useVisas) {
		com.citedessciences.bdd.beans.HUtilisateur u = (com.citedessciences.bdd.beans.HUtilisateur) o;
		Utilisateur utilisateur = new Utilisateur();
		utilisateur.setLogin(u.getLogin());
		utilisateur.setId(u.getNumsequtr());
		utilisateur.setEmail(u.getEmail());
		utilisateur.setNom(u.getNom());
		utilisateur.setPrenom(u.getPrenom());
		utilisateur.setSecteur(u.getSecteur());
		utilisateur.setTel(u.getTel());

		if (u.getActif().equals(AdminConstants.ACTIF)) {
			utilisateur.setActif(true);
		} else {
			utilisateur.setActif(false);
		}

		if (u.getChefDeptNotRequired().equals(AdminConstants.ACTIF)) {
			utilisateur.setChefDepartementNotRequired(true);
		} else {
			utilisateur.setChefDepartementNotRequired(false);
		}

		if (u.getDirecteurNotRequired().equals(AdminConstants.ACTIF)) {
			utilisateur.setDirecteurNotRequired(true);
		} else {
			utilisateur.setDirecteurNotRequired(false);
		}

		// Catégorie visa
		if (useVisas) {		
			Set setCategorie = u.getRefCategorieVisas();
			ArrayList categorieVisalist = new ArrayList();		
			Iterator iterator = setCategorie.iterator();
			
			while (iterator.hasNext())
			{
				HRefCategorieVisa categorieUtilisateur = (HRefCategorieVisa)iterator.next();
				CategorieVisa categorieVisa = new CategorieVisa();
				categorieVisa.setCommentaire(categorieUtilisateur.getCommentaire());
				categorieVisa.setId(categorieUtilisateur.getId());
				categorieVisa.setLibelle(categorieUtilisateur.getLibelleCategorie());
				categorieVisalist.add(categorieVisa);
			}
			utilisateur.setCategorieVisaList(categorieVisalist);
		}
		
		// Roles utilisateur
		Set s = u.getRoleUtilisateurs();
		ArrayList roleList = new ArrayList();

		java.util.Iterator it = s.iterator();

		boolean isChefProjet = false;
		boolean isReprise = false;
		
		while (it.hasNext()) {
			HRoleUtilisateur roleUtilisateur = (HRoleUtilisateur) it.next();
			Role role = new Role();
			if(roleUtilisateur.getActif().equals(new Integer(0))){
				role.setActif(false);
			}else{
				role.setActif(true);
			}
			role.setId(roleUtilisateur.getId().getCodeRole().getId());
			role.setLibelle(roleUtilisateur.getId().getCodeRole().getLibelleRole());
			role.setSwimlaneJBPM(mapSwimlaneJBPM(role.getLibelle()));
			roleList.add(role);
			if(role.getId().equals(Role.ROLE_CHEF_DE_PROJET) && role.isActif()){
				isChefProjet = true;
			}
			if(role.getId().equals(Role.ROLE_REPRISE)&& role.isActif()){
				isReprise = true;
			}
		}
		if(isChefProjet){
			utilisateur.setChefProjet(Boolean.TRUE);
		}else{
			utilisateur.setChefProjet(Boolean.FALSE);
		}
		if(isReprise){
			utilisateur.setReprise(Boolean.TRUE);
		}else{
			utilisateur.setReprise(Boolean.FALSE);
		}
		utilisateur.setListeRoles(roleList);
		
		return utilisateur;
	}

	/**
	 * Mapping Métier -> BDD
	 */
	public Object MetierToBDD(Object o) {
		com.citedessciences.bdd.beans.HUtilisateur uBDD = new com.citedessciences.bdd.beans.HUtilisateur();
		Utilisateur u = (Utilisateur) o;

		// Informations utilisateur
		if(u.isActif()){
			uBDD.setActif(AdminConstants.ACTIF);
		}else{
			uBDD.setActif(AdminConstants.INACTIF);
		}
		uBDD.setEmail(u.getEmail());
		uBDD.setTel(u.getTel());
		uBDD.setNom(u.getNom());
		uBDD.setPrenom(u.getPrenom());
		uBDD.setNumsequtr(u.getId());

		// Catégories visa
		
		ArrayList categorieVisaList = u.getCategorieVisaList();
		HashSet setCategorie = new HashSet();
		for (int i=0;i<categorieVisaList.size();i++)
		{
			CategorieVisa categorieVisa = (CategorieVisa)categorieVisaList.get(i);
			HRefCategorieVisa refCategorieVisa = new HRefCategorieVisa();
			refCategorieVisa.setId(categorieVisa.getId());
			
			setCategorie.add(refCategorieVisa);
		}
//		uBDD.setRefCategorieVisas(setCategorie);
		
		// Roles
		
		ArrayList listeRoles = u.getListeRoles();
		HashSet setRole = new HashSet();
		for (int i = 0; i < listeRoles.size(); i++) {
			Role roleUtilisateur = (Role) listeRoles.get(i);
			HRoleUtilisateur roleUtilisateurHibernate = new HRoleUtilisateur();

			if (roleUtilisateur.isActif())
				roleUtilisateurHibernate.setActif(AdminConstants.ACTIF);
			else
				roleUtilisateurHibernate.setActif(AdminConstants.INACTIF);

			HRefRole refRole = new HRefRole();
			refRole.setId(roleUtilisateur.getId());

			HRoleUtilisateurPK roleUtilisateurPK = new HRoleUtilisateurPK();
			roleUtilisateurPK.setCodeRole(refRole);
			roleUtilisateurPK.setNumsequtr(uBDD);
			roleUtilisateurHibernate.setId(roleUtilisateurPK);

			setRole.add(roleUtilisateurHibernate);
		}
		uBDD.setRoleUtilisateurs(setRole);
		return uBDD;
	}
	
	/**
	 * Mapping role utilisateur BDD avec swimlane JBPM
	 * 
	 * @param role
	 * @return
	 */
	 public String mapSwimlaneJBPM(String role) {
		  String swimlane = "";
		  if (role.equalsIgnoreCase(BDDConstants.ROLE_ADMINISTRATEURCELLULE)) {
		   swimlane = WKFConstants.SWIMLANE_VALIDATIONCELLULE;
		  } else if (role.equalsIgnoreCase(BDDConstants.ROLE_ADMINISTRATEURPREVALIDEUR)) {
		   swimlane = WKFConstants.SWIMLANE_PREVALIDATION;
		  } else if (role.equalsIgnoreCase(BDDConstants.ROLE_ADMINISTRATEURVALIDEUR)) {
		   swimlane = WKFConstants.SWIMLANE_VALIDATION;
		  } else if (role.equalsIgnoreCase(BDDConstants.ROLE_CHEFDEPARTEMENT)) {
		   swimlane = WKFConstants.SWIMLANE_CHEFDEPARTEMENT;
		  } else if (role.equalsIgnoreCase(BDDConstants.ROLE_CHEFPROJET)) {
		   swimlane = WKFConstants.SWIMLANE_CHEFPROJET;
		  } else if (role.equalsIgnoreCase(BDDConstants.ROLE_DIRECTEUR)) {
		   swimlane = WKFConstants.SWIMLANE_DIRECTEUR;
		  } else if (role.equalsIgnoreCase(BDDConstants.ROLE_VISEURCOMPLEMENTAIRE)) {
		   swimlane = WKFConstants.SWIMLANE_VISEURCOMPLEMENTAIRE;
		  } else if (role.equalsIgnoreCase(BDDConstants.ROLE_VISEURPRINCIPAL)) {
		   swimlane = WKFConstants.SWIMLANE_VISEUROBLIGATOIRE;
		  }
		  return swimlane;	 
	}

	/**
	 * Mapping Struts -> Métier
	 * 
	 * @deprecated
	 */
	public Object StrutsToMetier(Object o) {
		return null;
	}

	/**
	 * Mapping Métier -> Struts
	 * 
	 * @deprecated
	 */
	public Object MetierToStruts(Object o) {

		return null;
	}


}
