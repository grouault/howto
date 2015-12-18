package com.citedessciences.businesslogic.administration;

import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Expression;

import com.citedessciences.bdd.beans.HDateEvenement;
import com.citedessciences.bdd.beans.HFicheDT;
import com.citedessciences.bdd.beans.HFicheDtDate;
import com.citedessciences.bdd.beans.HFicheExploitation;
import com.citedessciences.bdd.beans.HFicheExploitationCcv;
import com.citedessciences.bdd.beans.HFicheReservation;
import com.citedessciences.bdd.beans.HFicheccvDate;
import com.citedessciences.bdd.beans.HFicheexpDate;
import com.citedessciences.bdd.beans.HFicheresDate;
import com.citedessciences.businesslogic.entity.Alerte;
import com.citedessciences.businesslogic.entity.DateEvenement;
import com.citedessciences.businesslogic.entity.DegreAlerte;
import com.citedessciences.businesslogic.entity.Fiche;
import com.citedessciences.businesslogic.entity.FicheDT;
import com.citedessciences.businesslogic.entity.FicheExploitation;
import com.citedessciences.businesslogic.entity.Point;
import com.citedessciences.businesslogic.entity.RefLieu;
import com.citedessciences.businesslogic.entity.RefTypeNuisance;
import com.citedessciences.businesslogic.mapping.FicheDTMapper;
import com.citedessciences.businesslogic.mapping.FicheExploitationCCVMapper;
import com.citedessciences.businesslogic.mapping.FicheExploitationMapper;
import com.citedessciences.businesslogic.mapping.FicheReservationMapper;
import com.citedessciences.businesslogic.util.DateUtil;
import com.citedessciences.struts.util.RessourceFrontReader;

/**
 * Service de gestion et calcul des alertes.
 * @author Rouault1
 *
 */
public class AdminAlertes extends Admin {

	private static Log log = LogFactory.getLog(AdminAlertes.class);
	
	public List calculateAlertes(Fiche fiche, Session sessionHibernate) {
		List datesEvenement = fiche.getDateEvenementList();
		List alertes = new ArrayList();
		
		//Parcours de la liste des datesEvenements retourn�es.
		for (Iterator iter = datesEvenement.iterator(); iter.hasNext();) {
			
			DateEvenement dateEvenementFiche = (DateEvenement) iter.next();
			
			//r�cup�ration des dates �v�nements qui co�ncides avec les dates_�v�nement de la fiche.
			List datesEvenementSimultanees = this.getDateEvenementSimultanee(fiche, sessionHibernate);
			
			//pour chaque date �v�nement r�cup�r�e, on r�cup�re la fiche associ�e.
			for (Iterator iterator = datesEvenementSimultanees.iterator(); iterator.hasNext();) {
				HDateEvenement hDatesEvenementSimultane = (HDateEvenement) iterator.next();
				Fiche ficheSimultanee = this.getFicheSimultanee(hDatesEvenementSimultane, sessionHibernate);
		
				//r�cup�ration de l'ancienne algorithme(?).
				Integer ficheTransform = new Integer(0);
				if (fiche instanceof FicheExploitation) {
					FicheExploitation ficheExploitation = (FicheExploitation) fiche;
					ficheTransform = ficheExploitation.getFicheReservation();
				}
			
				//comparer les lieux de la fiche simultan�es avec lieux de la fiche 
				if (ficheSimultanee != null && !ficheSimultanee.getId().equals(fiche.getId()) && (ficheTransform.equals(new Integer(0)))) {
					
					//r�cup�ration des dates dans un tableau.
					Date[] tabDates  = this.getTabDates(dateEvenementFiche, hDatesEvenementSimultane); 
					
					//Calcul des alertes li�es � la position g�ographique.
					this.calculateAlertesGeographiques(fiche, ficheSimultanee, alertes, tabDates);
					
					//Calcul des alertes li�es au nuisance.
					//this.calculateAlertesNuisances(fiche, ficheSimultanee, tabDates);
					
				}
				
				
			}//for dateEvenementSimultane.
			
		}
		return alertes;
	}	
	
	
	/**
	 * Calcule les alertes pour une fiche donn�es. Pour g�n�rer une alerte, la
	 * fiche doit avoir comme point commun avec une autre fiche, les points
	 * suivants :
	 * <ul>
	 * <li>Se d�rouler sur le m�me niveau</li>
	 * <li>Se d�rouler sur le m�me quadrant</li>
	 * <li>Se d�rouler sur le m�me lieu</li>
	 * </ul>
	 * Trois niveau d'alerte sont possible , repr�sent� par une couleur:
	 * <ul>
	 * <li>Faible (Jaune), si les deux fiches sont sur le m�me niveau</li>
	 * <li>Moyen : (Orange), si les deux fiches sont sur le m�me quadrant</li>
	 * <li>Important : (Rouge), si les deux fiches sont sur le m�me Lieu</li>
	 * </ul>
	 * 
	 * @param fiche
	 * @param ficheSimultanee
	 * @param alertes: cette liste se voit ajout�e les alertes trouv�es
	 * 					lors du calcul de la m�thode.
	 */	
	private void calculateAlertesGeographiques(Fiche fiche, Fiche ficheSimultanee, List alertes, Date[] tabDates){
		
		//r�cup�ration des lieux de la fiche.
		List listeLieuxFiches = fiche.getLieux();
		List listeLieuxFichesSimultanes = ficheSimultanee.getLieux();
		
		//parcours les lieux de la fiche.
		for (Iterator iterator = listeLieuxFiches.iterator(); iterator.hasNext();) {
			RefLieu	 lieuFiche = (RefLieu) iterator.next();
			
			//parcours les lieux de la ficheSimultan�e.
			
			for (Iterator iterator2 = listeLieuxFichesSimultanes.iterator(); iterator2
					.hasNext();) {
				RefLieu lieuFicheSimultanee = (RefLieu) iterator2.next();
				
				//tester si les manifestations sont au m�me niveau.				
				boolean bCriteresLieux = this.criteresNullitesLieux(lieuFiche, lieuFicheSimultanee);
					
				if (bCriteresLieux) {
					if (lieuFiche.getQuadrant().getIdNiveau().getId().equals(lieuFicheSimultanee.getQuadrant().getIdNiveau().getId())) {
						
						//cr�ation d'une alerte.
						Alerte alerte = this.createAlerteLieux(fiche, ficheSimultanee, tabDates);
					
						//tester si les manifestations sont dans le m�me quadrant.
						if (lieuFiche.getQuadrant().equals(lieuFicheSimultanee.getQuadrant())){
							//positionnement d'un alerte orange
							alerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_MOYEN);
						}
						
						//tester si les manifestations sont dans le m�me lieu.
						if(lieuFiche.equals(lieuFicheSimultanee)){
							//positionnement d'une alerte rouge
							alerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_IMPORTANT);
						}
						
						//ajout de l'alerte � la liste des alertes.
						alertes.add(alerte);
					}	
				}	
					
			}
		}
		
	}
	
	/**
	 * retourne sous forme de tableau les dates de fin et de d�but:
	 *  de l'�venementDate de fiche: tab[0]
	 *  de l'�v�nementDate de fiche: tab[1]
	 *  de l'�venementDate de ficheSimultane: tab[2]
	 *  de l'�v�nementDate de ficheSimultane: tab[3]
	 * @return tabDate[]
	 */
	private Date[] getTabDates(DateEvenement dateEvenementFiche, HDateEvenement dateEvenementSimultane){
		Date[] tabDate = new Date[4];
		tabDate[0] = dateEvenementFiche.getDateDebut().getTime();
		tabDate[1] = dateEvenementFiche.getDateFin().getTime();
		tabDate[2] = dateEvenementSimultane.getDateDebut();
		tabDate[3] = dateEvenementSimultane.getDateFin();
		return tabDate;
	}
	
	/**
	 * Cr�ation d'une alerte de degr� faible car les manifestations se d�roulent
	 * au moins sur le m�me niveau.
	 * @param fiche
	 * @param ficheSimultanee
	 * @param tabDates
	 * @return
	 */
	private Alerte createAlerteLieux(Fiche fiche, Fiche ficheSimultanee, Date[] tabDates){
		Alerte alerte = new Alerte();
		String message = RessourceFrontReader.getInstance().getMessage("objet.alertes");
		message = message.replaceAll("\\{0\\}", fiche.getTitre());
		message = message.replaceAll("\\{1\\}", ficheSimultanee.getTitre());
		alerte.setObjet(message);
		
		Date dateDebutFiche = tabDates[0];
		Date dateDebutFicheSimultanee = tabDates[2];
		
		if (dateDebutFiche.after(dateDebutFicheSimultanee)) {
			alerte.setDateDebut(DateUtil.convertDateToCalendar(dateDebutFiche));
		} else {
			alerte.setDateDebut(DateUtil.convertDateToCalendar(dateDebutFicheSimultanee));
		}
		
		Date dateFinFiche = tabDates[1];
		Date dateFinFicheSimultane = tabDates[3];
		if (dateFinFiche.before(dateFinFicheSimultane)) {
			alerte.setDateFin(DateUtil.convertDateToCalendar(dateFinFiche));
		} else {
			alerte.setDateFin(DateUtil.convertDateToCalendar(dateFinFicheSimultane));
		}
		List fiches = new ArrayList();
		fiches.add(fiche);
		fiches.add(ficheSimultanee);
		alerte.setFichesConcernees(fiches);
		alerte.setDateEmission(new GregorianCalendar());
		//positionnement du degr� d'alerte � faible.
		alerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);
		return alerte;
	}
	
	
	/**
	 * Caclule des alertes li�es aux nuisanes. 
	 * Le premier test consiste � v�rifier que si la fiche est nuisible pour la fiche existante ou simultan�e.
	 * Le second test consiste � tester si la fiche existante est nuisible pour la fiche en cr�ation.
	 * Note: 
	 * - aucune fiche ne peut-�tre nuisible � une fiche de type d�claration de travaux.
	 * - la fiche ou la fiche simultan�e pr�sente une nuisance.
	 * 
	 * @param fiche
	 * @param ficheSimultanee
	 * @param alertes: cette liste se voit ajout�e les alertes trouv�es
	 * 					lors du calcul de la m�thode.
	 */
	private void calculateAlertesNuisances(Fiche fiche, Fiche ficheSimultanee, List alertes){
	
		//A- Condition n�cessaire au premier test: 
		// la  ficheSimultan�e n'est pas une d�claration de travaux et la fiche pr�sente des nuisances.
		if (!(ficheSimultanee instanceof FicheDT) && fiche.getNuisances()!=null) {
		
			//r�cup�ration des nuisances.
			List listNuisanceFiche = fiche.getNuisances();
			
			//on ne garde que la nuisance d'intensit� la plus forte.
			RefTypeNuisance nuisance = null;
			//faire le test pour chaque nuisance.
			for (Iterator iterator = listNuisanceFiche.iterator(); iterator.hasNext();) {
				RefTypeNuisance nuisanceCourante = (RefTypeNuisance) iterator.next();
				if (nuisance==null && nuisanceCourante.getIntensite()!=null) {
					nuisance = nuisanceCourante;
				}
				else{
					if(nuisanceCourante!=null && nuisanceCourante.getIntensite()!=null){
						if(nuisanceCourante.getIntensite().intValue()>nuisanceCourante.getIntensite().intValue()){
							nuisance = nuisanceCourante;
						}
					}
				}
				
			}
				
			if (nuisance!=null && nuisance.getIntensite()!=null) {
				
				//r�cup�ration du plafond de propagation de la nuisance.
				
				
				
				//
				//le test de nuisance doit �tre fait chaque lieux des deux fiches.
				//
				
				//r�cup�ration des lieux de la fiche.
				List listeLieuxFiches = fiche.getLieux();
				List listeLieuxFichesSimultanes = ficheSimultanee.getLieux();
				
				//parcourir les lieux de la fiche.
				for (Iterator iterator2 = listeLieuxFiches.iterator(); iterator2.hasNext();) {
					RefLieu lieuFiche = (RefLieu) iterator2.next();
					
					//parcours les lieux de la ficheSimultan�e.
					
					for (Iterator iterator3 = listeLieuxFichesSimultanes.iterator(); iterator3.hasNext();) {
						RefLieu lieuFicheSimultanee = (RefLieu) iterator3.next();		
						
						//Test de nullit� des lieux: n�cessaire car r�cup�ration des informations sur les quadrants correspondant.			
						boolean bCriteresLieux = this.criteresNullitesLieux(lieuFiche, lieuFicheSimultanee);
							
						if (bCriteresLieux) {
							
							//Existe-t-il un parametrage exceptionnel entre les deux fiches (?) -
							//TODO: appel� une m�thode: getException(id_quadrant1, id_quadrant2);
						
							//1- calcul de la distance entre les lieux.
								//calcul en mode normal - v�rification si les lieux sont bien dans le m�me b�timent.
								
									//tester la non nullit� des coordonn�es.
								
										//r�cup�ration des donn�es du premier lieu.
										double coord_x1 =  (double)(lieuFiche.getQuadrant().getCoordX().intValue());
										double coord_y1 = (double)(lieuFiche.getQuadrant().getCoordY().intValue());
										double coord_z1 = (double)(lieuFiche.getQuadrant().getIdNiveau().getEtage().intValue());
										double dist_q1 = (double)(lieuFiche.getQuadrant().getIdNiveau().getDistanceQuadrant().intValue());
										Point pointFiche = new Point(coord_x1, coord_y1, coord_z1, dist_q1);
										
										//r�cup�ration des donn�es du second lieu.
										double coord_x2 =  (double)(lieuFicheSimultanee.getQuadrant().getCoordX().intValue());
										double coord_y2 = (double)(lieuFicheSimultanee.getQuadrant().getCoordY().intValue());
										double coord_z2 = (double)(lieuFicheSimultanee.getQuadrant().getIdNiveau().getEtage().intValue());
										double dist_q2 = (double)(lieuFicheSimultanee.getQuadrant().getIdNiveau().getDistanceQuadrant().intValue());
										Point pointFicheSimultanee = new Point(coord_x2, coord_y2, coord_z2, dist_q2);
										
										//r�cup�ration de la distance entre les niveaux. Les lieux sont dans le m�me b�timent.
										double distNiv = (double)(lieuFiche.getQuadrant().getIdNiveau().getBatiment().getDistanceNiveaux().intValue());
										
										//calcul de la distance entre les points.
										double distanceCalculer = calculateDistance(pointFiche, pointFicheSimultanee, distNiv);
	
								//calcul en mode exceptionnel.
								
						}							
					}	
				}//for lieux
							
			}//if nuisance
				

		
		}	
		
		//B- Test si la fiche n'est pas une d�claration de travaux.
			// - Tester si la ficheSimultan�e est nuisible pour la fiche. 
	
	}
	

	/**
	 * r�cup�re les dates �v�nements qui chevauche les dates �v�nements
	 * de la fiche pass�e en param�tre.
	 * @param fiche
	 * @return
	 */
	private List getDateEvenementSimultanee(Fiche fiche, Session sessionHibernate){
		List datesEvenementSimultanees = new ArrayList();
		
		List datesEvenement = fiche.getDateEvenementList();
		for (Iterator iter = datesEvenement.iterator(); iter.hasNext();) {
			DateEvenement dateEvenement = (DateEvenement) iter.next();
			Date dateDebut = dateEvenement.getDateDebut().getTime();
			Date dateFin = dateEvenement.getDateFin().getTime();
			Criteria crit = sessionHibernate
					.createCriteria(HDateEvenement.class);

			Criterion dateDebutCriterion = Expression.and(Expression.le(
					HDateEvenement.PROP_DATEDEBUT, dateDebut), Expression.ge(
					HDateEvenement.PROP_DATEFIN, dateDebut));
			Criterion dateFinCriterion = Expression.and(Expression.le(
					HDateEvenement.PROP_DATEDEBUT, dateFin), Expression.ge(
					HDateEvenement.PROP_DATEFIN, dateFin));
			Criterion dateOutSide = Expression.and(Expression.ge(
					HDateEvenement.PROP_DATEDEBUT, dateDebut), Expression.le(
					HDateEvenement.PROP_DATEFIN, dateFin));

			Criterion orCriterion = Expression.or(dateDebutCriterion,
					dateFinCriterion);
			orCriterion = Expression.or(orCriterion, dateOutSide);

			crit.add(orCriterion);
			//r�cup�ration des dates chevauchante pour la date �v�nement en cours de la fiche.
			List datesEvements = crit.list();		
			//ajout des dates �v�nements dans la liste.
			datesEvenementSimultanees.addAll(datesEvements);
		}
		return datesEvenementSimultanees;
	}
	
	/**
	 * r�cup�re la fiche correspondant � la date-�v�nement pass�e
	 * en param�tre.
	 * @param dateEvenement
	 * @return
	 */
	private Fiche getFicheSimultanee(HDateEvenement dateEvenementHibernate, Session sessionHibernate){
		Fiche ficheSimultanee = null;
		if (dateEvenementHibernate.getFicheccvDateSet() != null
				&& dateEvenementHibernate.getFicheccvDateSet().size() > 0) {
			HFicheccvDate ficheCcvDate = (HFicheccvDate) dateEvenementHibernate.getFicheccvDateSet().iterator().next();
			HFicheExploitationCcv ficheExploitationHibernate = ficheCcvDate.getId().getFicheExploitationCcv();
			FicheExploitationCCVMapper mapper = new FicheExploitationCCVMapper();
			ficheSimultanee = (Fiche) mapper.BDDToMetier(ficheExploitationHibernate, false,sessionHibernate);
		} 
		else if (dateEvenementHibernate.getFicheresDateSet() != null
				&& dateEvenementHibernate.getFicheresDateSet().size() > 0) {
			HFicheresDate ficheResDate = (HFicheresDate) dateEvenementHibernate.getFicheresDateSet().iterator().next();
			HFicheReservation ficheReservationHibernate = ficheResDate.getId().getFicheReservation();
			FicheReservationMapper mapper = new FicheReservationMapper();
			ficheSimultanee = (Fiche) mapper.BDDToMetier(ficheReservationHibernate, false, sessionHibernate);
		} 
		else if (dateEvenementHibernate.getFicheexpDateSet() != null
				&& dateEvenementHibernate.getFicheexpDateSet().size() > 0) {
			HFicheexpDate ficheExpDate = (HFicheexpDate) dateEvenementHibernate.getFicheexpDateSet().iterator().next();
			HFicheExploitation ficheExploitationHibernate = ficheExpDate.getId().getFicheExploitation();
			FicheExploitationMapper mapper = new FicheExploitationMapper();
			ficheSimultanee = (Fiche) mapper.BDDToMetier(ficheExploitationHibernate, false,sessionHibernate);
		}		
		else if (dateEvenementHibernate.getFichedtDateSet()!=null && dateEvenementHibernate.getFichedtDateSet().size()>0) {
			HFicheDtDate ficheDtDate = (HFicheDtDate)dateEvenementHibernate.getFichedtDateSet().iterator().next();
			HFicheDT ficheDtHibernate = ficheDtDate.getId().getFicheDT();
			FicheDTMapper mapper = new FicheDTMapper();
			ficheSimultanee = (Fiche) mapper.BDDToMetier(ficheDtHibernate, false, sessionHibernate);
		}
		return ficheSimultanee;
	}
	
	/**
	 * Teste les crit�res de nullit�.
	 * @return
	 */
	private boolean criteresNullitesLieux(RefLieu lieuFiche, RefLieu lieuFicheSimultane){
		
		boolean isCriteresFiche = true;
		
		//test de la nullit� du lieu et du quadrant de la fiche.
		if (lieuFiche == null || lieuFiche.getQuadrant()==null || lieuFiche.getQuadrant().getIdNiveau()==null) {
				isCriteresFiche = false;
				String msgError = "Les informations (quadrant-niveau) " + lieuFiche.getLibelleLieu() + " (" + lieuFiche.getIdLieu() + ") sont mal renseign�es";
				log.error(msgError);				
		}

		boolean isCriteresFicheS = true;
		//test de la nullit� du lieu et du quadrant de la fiche simultan�e.
		if (lieuFicheSimultane==null || lieuFicheSimultane.getQuadrant()==null || lieuFicheSimultane.getQuadrant().getIdNiveau()==null) {
			isCriteresFicheS = false;
			String msgError = "Les informations (quadrant-niveau) " + lieuFicheSimultane.getLibelleLieu() + " (" + lieuFicheSimultane.getIdLieu() + ") sont mal renseign�es";
			log.error(msgError);	
		}	
		
		return (isCriteresFicheS && isCriteresFiche);
	}
	
	
	/**
	 * permet de calculer la distance entre deux points.
	 * @param p1
	 * @param p2
	 * @param distN
	 * @return
	 */
	private double calculateDistance(Point p1, Point p2, double distN){
		double distP = 0;//distance entre les points.
		
		//le calcul correspond � la racine carr�e de trois membres.
			//membre1: calcul sur les coordonn�es en x
			double m1 = p1.getDist_q() * Math.pow(p2.getCoord_x() - p1.getCoord_x(),2);
			
			//membre2: calcul sur les cooredonn�es en y;
			double m2 = p2.getDist_q() * Math.pow(p2.getCoord_y()- p1.getCoord_y(),2);
			
			//membre3: calcul sur les coordonn�es en z;
			double m3 = distN * Math.pow(p2.getCoord_z() - p1.getCoord_z(), 2);
			
		distP = Math.sqrt(m1 + m2 + m3);
			
		return distP;
	}
	
}
