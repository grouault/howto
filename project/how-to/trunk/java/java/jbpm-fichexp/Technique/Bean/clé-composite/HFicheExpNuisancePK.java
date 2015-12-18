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
		
		//v�rifier la nullite de obj
		if (obj == null) {
			return false;
		}
		//v�rifier si obj est une instance de l objet PK
		if (!(obj instanceof HFicheExpNuisancePK)) {
			return false;
		}
		
		HFicheExpNuisancePK that = (HFicheExpNuisancePK)obj;
		//v�rifier si le premier composant de la cl� n'est pas null pour les 2 objets
		if (this.idFiche==null || that.idTypeNuisance==null) {
			return false;
		}
		//v�rifier si le deuxi�me composant de la cl� n'est pas null pour les 2 objets
		if (this.idTypeNuisance == null || that.idTypeNuisance == null) {
			return false;
		}
		//v�rifier l'�galit� des premiers composants de la cl�.
		if (!this.idFiche.equals(that.idFiche)) {
			return false;
		}
		//v�rifier l'�galit� des seconds composants de la cl�.
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
