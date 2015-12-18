package com.citedessciences.bdd.beans;

import java.io.Serializable;
import java.util.Date;

public class HFicheDT implements Serializable {

	private static final long serialVersionUID = 1L;

	private java.lang.Integer id;
	
	private java.lang.String titre;
	
	private java.lang.String titreCourt;
	
	private java.util.Date dateCreation;
	
	private Date dateArchivage;
	
	private java.lang.String resume;
	
	private java.lang.String deroulement;
	
	private com.citedessciences.bdd.beans.HFicheDTAnnulee idFicheDTAnnulee;	
	
	private com.citedessciences.bdd.beans.HRefTypeOperation codeTypeOperation;
	
	private com.citedessciences.bdd.beans.HUtilisateur idChefProjet;
	
	private java.util.Set dateEvenement;
	
	private java.util.Set codeLocalisations;
	
	private java.util.Set codeNuisances;
	
	public java.lang.Integer getId() {
		return id;
	}
	public void setId(java.lang.Integer id) {
		this.id = id;
	}
	public java.lang.String getTitre() {
		return titre;
	}
	public void setTitre(java.lang.String titre) {
		this.titre = titre;
	}
	public java.lang.String getTitreCourt() {
		return titreCourt;
	}
	public void setTitreCourt(java.lang.String titreCourt) {
		this.titreCourt = titreCourt;
	}
	public java.util.Date getDateCreation() {
		return dateCreation;
	}
	public void setDateCreation(java.util.Date dateCreation) {
		this.dateCreation = dateCreation;
	}
	public Date getDateArchivage() {
		return dateArchivage;
	}
	public void setDateArchivage(Date dateArchivage) {
		this.dateArchivage = dateArchivage;
	}
	public java.lang.String getResume() {
		return resume;
	}
	public void setResume(java.lang.String resume) {
		this.resume = resume;
	}
	public java.lang.String getDeroulement() {
		return deroulement;
	}
	public void setDeroulement(java.lang.String deroulement) {
		this.deroulement = deroulement;
	}
	public com.citedessciences.bdd.beans.HFicheDTAnnulee getIdFicheDTAnnulee() {
		return idFicheDTAnnulee;
	}
	public void setIdFicheDTAnnulee(
			com.citedessciences.bdd.beans.HFicheDTAnnulee idFicheDTAnnulee) {
		this.idFicheDTAnnulee = idFicheDTAnnulee;
	}
	public com.citedessciences.bdd.beans.HRefTypeOperation getCodeTypeOperation() {
		return codeTypeOperation;
	}
	public void setCodeTypeOperation(
			com.citedessciences.bdd.beans.HRefTypeOperation codeTypeOperation) {
		this.codeTypeOperation = codeTypeOperation;
	}
	public com.citedessciences.bdd.beans.HUtilisateur getIdChefProjet() {
		return idChefProjet;
	}
	public void setIdChefProjet(
			com.citedessciences.bdd.beans.HUtilisateur idChefProjet) {
		this.idChefProjet = idChefProjet;
	}
	public java.util.Set getDateEvenement() {
		return dateEvenement;
	}
	public void setDateEvenement(java.util.Set dateEvenement) {
		this.dateEvenement = dateEvenement;
	}
	public java.util.Set getCodeLocalisations() {
		return codeLocalisations;
	}
	public void setCodeLocalisations(java.util.Set codeLocalisations) {
		this.codeLocalisations = codeLocalisations;
	}
	public java.util.Set getCodeNuisances() {
		return codeNuisances;
	}
	public void setCodeNuisances(java.util.Set codeNuisances) {
		this.codeNuisances = codeNuisances;
	}
	
	
}
