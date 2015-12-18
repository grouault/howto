package com.citedessciences.bdd.beans;

import java.io.Serializable;

public class HRoleUtilisateurPK implements Serializable {

	private static final long serialVersionUID = 8815539216989747120L;

	public static String PROP_ROLE = "HRefRole";

	public static String PROP_UTILISATEUR = "HUtilisateur";
	
	private com.citedessciences.bdd.beans.HRefRole codeRole;

	private com.citedessciences.bdd.beans.HUtilisateur numsequtr;

	public com.citedessciences.bdd.beans.HRefRole getCodeRole() {
		return codeRole;
	}

	public void setCodeRole(com.citedessciences.bdd.beans.HRefRole codeRole) {
		this.codeRole = codeRole;
	}

	public com.citedessciences.bdd.beans.HUtilisateur getNumsequtr() {
		return numsequtr;
	}

	public void setNumsequtr(
			com.citedessciences.bdd.beans.HUtilisateur numsequtr) {
		this.numsequtr = numsequtr;
	}

}