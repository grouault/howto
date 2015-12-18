package com.citedessciences.bdd.beans;

import java.io.Serializable;

public class HFicheexpLocalisationKey implements Serializable {

	private static final long serialVersionUID = 7531470513678694898L;

	private volatile int hashValue = 0;

	private HRefLocalisation refLocalisation;

	private HFicheExploitation ficheExploitation;

	public HRefLocalisation getRefLocalisation() {
		return refLocalisation;
	}

	public void setRefLocalisation(HRefLocalisation refLocalisation) {
		hashValue = 0;
		this.refLocalisation = refLocalisation;
	}

	public HFicheExploitation getFicheExploitation() {
		return ficheExploitation;
	}

	public void setFicheExploitation(HFicheExploitation ficheExploitation) {
		hashValue = 0;
		this.ficheExploitation = ficheExploitation;
	}

	public boolean equals(Object rhs) {
		if (rhs == null)
			return false;
		if (!(rhs instanceof HFicheexpLocalisationKey))
			return false;
		HFicheexpLocalisationKey that = (HFicheexpLocalisationKey) rhs;
		if (this.getRefLocalisation() == null
				|| that.getRefLocalisation() == null) {
			return false;
		}
		if (!this.getRefLocalisation().equals(that.getRefLocalisation())) {
			return false;
		}
		if (this.getFicheExploitation() == null
				|| that.getFicheExploitation() == null) {
			return false;
		}
		if (!this.getFicheExploitation().equals(that.getFicheExploitation())) {
			return false;
		}
		return true;
	}

	public int hashCode() {
		if (this.hashValue == 0) {
			int result = 17;
			int refLocalisationValue = this.getRefLocalisation() == null ? 0
					: this.getRefLocalisation().hashCode();
			result = result * 37 + refLocalisationValue;
			int ficheExploitationValue = this.getFicheExploitation() == null ? 0
					: this.getFicheExploitation().hashCode();
			result = result * 37 + ficheExploitationValue;
			this.hashValue = result;
		}
		return this.hashValue;
	}
}