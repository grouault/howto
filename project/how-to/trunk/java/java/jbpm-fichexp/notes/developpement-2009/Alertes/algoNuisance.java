package fr.exagone.jse.math;

public class CalculNuisance {
	
	/**
	 * algorithme d'initialisation du calcul des nuisances.
	 * @param args
	 */
	public static void main(String[] args) {
		
		//vérifier si les lieux sont identiques auquel cas la distance est de 0.
		
		//sinon, vérifier que les lieux sont dans le même batiment.
		
			//si oui,
		
				//récupération des informations des niveaux.
				int dist_N = 30;
		
				//information du quadrant de la fiche.
				double fiche_X = 2;
				double fiche_Y = 4;
				double fiche_Z = 3;
		
				//information du quadrant de la fiche simultanée.
				double ficheS_X = 1;
				double ficheS_Y = 2;
				double ficheS_Z = 2;
		
		
				//récupération des informations des quadrants.
		
					//récupération de la distance entre quadrant
						// si pas le même id niveau -> faire la moyenne des deux.
						double distQF = 10;
						double distQFS = 10;
						double distQ = (distQF + distQFS)/2;
						
						//vérification si paramétrage exceptionnel
							
		
						//ETABLISSSEMENT DU CALCUL
					
						double m1 = distQ * Math.pow((ficheS_X - fiche_X), 2);
						double m2 = distQ * Math.pow((ficheS_Y-fiche_Y),2);
						double m3 = dist_N * Math.pow ( (ficheS_Z - fiche_Z),2);
						double d =  Math.sqrt(m1 + m2 + m3);
						System.out.println(d);
						
				//récupération de la nuisance de plus haute intensité et de son plafond de propagation:
						double intensiteNuisance = 5;
						double ppf = 40;
						
				//calcul de la marge de dépassement:
						double md = ppf - d;
						
						String alerte = "";
						if (md>0 && md<50){
							alerte = "faible";
						}
						else if (md>50 && md<100) {
							alerte = "moyenne";
						}
						else if (md>10) {
							alerte = "importante";
						}
						
						System.out.println("alerte : " + alerte);
						
			//sinon
		
				//pas de calcul, et pas de nuisance.
		
	}
	
}
