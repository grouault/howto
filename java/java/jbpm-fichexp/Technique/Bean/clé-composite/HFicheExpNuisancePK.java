package com.citedessciences.bdd.beans;

import java.io.Serializable;

public class HFicheExpNuisancePK implements Serializable {

	private static final long serialVersionUID = 1L;
	private HFicheExploitation idFiche;
	private HRefTypeNuisance idTypeNuisance;
	
	private volatile int hashValue = 0;
	
	public HFicheExploitation getIdFiche() {
		return idFiche;
	}
	public void setIdFiche(HFicheExploitation idFiche) {
		this.idFiche = idFiche;
	}
	public HRefTypeNuisance getIdTypeNuisance() {
		return idTypeNuisance;
	}
	public void setIdTypeNuisance(HRefTypeNuisance idTypeNuisance) {
		this.idTypeNuisance = idTypeNuisance;
	}
	
	public boolean equals(Object obj) {
		
		//vérifier la nullite de obj
		if (obj == null) {
			return false;
		}
		//vérifier si obj est une instance de l objet PK
		if (!(obj instanceof HFicheExpNuisancePK)) {
			return false;
		}
		
		HFicheExpNuisancePK that = (HFicheExpNuisancePK)obj;
		//vérifier si le premier composant de la clé n'est pas null pour les 2 objets
		if (this.idFiche==null || that.idTypeNuisance==null) {
			return false;
		}
		//vérifier si le deuxième composant de la clé n'est pas null pour les 2 objets
		if (this.idTypeNuisance == null || that.idTypeNuisance == null) {
			return false;
		}
		//vérifier l'égalité des premiers composants de la clé.
		if (!this.idFiche.equals(that.idFiche)) {
			return false;
		}
		//vérifier l'égalité des seconds composants de la clé.
		if (!this.idTypeNuisance.equals(that.idTypeNuisance)) {
			return false;
		}
		return true;
	}
	
	public int hashCode() {
		if (this.hashValue == 0) {
			int result = 0;
			int idFicheValue = this.getIdFiche()==null ? 0 : this.getIdFiche().hashCode();
			result += idFicheValue;
			int idTypeNuisance = this.getIdTypeNuisance()==null ? 0 : this.getIdTypeNuisance().hashCode();
			result += idTypeNuisance;
			this.hashValue = result;
		}
		return this.hashValue;
	}
	
}
