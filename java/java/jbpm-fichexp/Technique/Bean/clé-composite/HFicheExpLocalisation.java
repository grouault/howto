package com.citedessciences.bdd.beans;

import java.io.Serializable;

public abstract class HFicheexpLocalisation implements Serializable {

	private int hashValue = 0;

	private HFicheexpLocalisationKey id;

	public HFicheexpLocalisation(HFicheexpLocalisationKey id) {
		this.setId(id);
	}

	public HFicheexpLocalisationKey getId() {
		return this.id;
	}

	public void setId(HFicheexpLocalisationKey id) {
		this.hashValue = 0;
		this.id = id;
	}

	public boolean equals(Object rhs) {
		if (rhs == null)
			return false;
		if (!(rhs instanceof HFicheexpLocalisation))
			return false;
		HFicheexpLocalisation that = (HFicheexpLocalisation) rhs;
		if (this.getId() == null || that.getId() == null)
			return false;
		return (this.getId().equals(that.getId()));
	}

	public int hashCode() {
		if (this.hashValue == 0) {
			int result = 17;
			if (this.getId() == null) {
				result = super.hashCode();
			} else {
				result = this.getId().hashCode();
			}
			this.hashValue = result;
		}
		return this.hashValue;
	}
}
