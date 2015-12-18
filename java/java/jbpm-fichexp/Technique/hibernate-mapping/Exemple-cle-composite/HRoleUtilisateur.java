package com.citedessciences.bdd.beans;

import java.io.Serializable;

public class HRoleUtilisateur implements Serializable {
	
	private static final long serialVersionUID = 7945788819219687390L;

	public static String REF = "HRoleUtilisateur";

	public static String PROP_ACTIF = "Actif";

	public static String PROP_ID = "Id";
	
	public static String PK = "HRoleUtilisateurPK";

	private com.citedessciences.bdd.beans.HRoleUtilisateurPK id;

	private java.lang.Integer actif;

	public com.citedessciences.bdd.beans.HRoleUtilisateurPK getId() {
		return id;
	}

	public void setId(com.citedessciences.bdd.beans.HRoleUtilisateurPK id) {
		this.id = id;
	}

	public java.lang.Integer getActif() {
		return actif;
	}

	public void setActif(java.lang.Integer actif) {
		this.actif = actif;
	}
}