package com.citedessciences.bdd.beans;

import java.io.Serializable;

public class HFicheExpNuisance implements Serializable {

	private static final long serialVersionUID = 1L;
	private int hashValue = 0;
	
	private HFicheExpNuisancePK id;

	public HFicheExpNuisancePK getId() {
		return id;
	}

	public void setId(HFicheExpNuisancePK id) {
		this.id = id;
	}
	
	public boolean equals(Object obj) {
		if (obj==null) {
			return false;
		}
		if (!(obj instanceof HFicheExpNuisance)) {
			return false;
		}
		
		HFicheExpNuisance that = (HFicheExpNuisance)obj;
		if (this.id==null || that.id==null) {
			return false;
		}
		return(this.id.equals(that.id));
	}

	public int hashCode() {
		if (this.hashValue == 0) {
			int result = 0;
			if(this.getId() == null){
				result = super.hashCode();
			}
			else {
				result = this.getId().hashCode();
			}
			this.hashValue = result;
		}
		return this.hashValue;
	}
}
