package com.citedessciences.businesslogic.administration;

import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;

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
import com.citedessciences.businesslogic.entity.Fiche;
import com.citedessciences.businesslogic.entity.FicheExploitation;
import com.citedessciences.businesslogic.entity.RefLieu;
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


	public List calculateAlertes(Fiche fiche, Session sessionHibernate) {
		
		//Liste des alertes trouvées lors du calcul.
		List alertes = new ArrayList();
		
		//récupération de la liste des manifestations simultanées.
		List ficheSimultanées = this.getFichesSimultanées(fiche, sessionHibernate);
		
		
		//Parcours de la liste des manifestations simultanées.
		for (Iterator iterator = ficheSimultanées.iterator(); iterator.hasNext();) {
			
			Fiche ficheSimultanee = (Fiche) iterator.next();
			
			//récupération de l'ancienne algorithme(?).
			Integer ficheTransform = new Integer(0);
			if (fiche instanceof FicheExploitation) {
				FicheExploitation ficheExploitation = (FicheExploitation) fiche;
				ficheTransform = ficheExploitation.getFicheReservation();
			}
			
			if (ficheSimultanee != null && !ficheSimultanee.getId().equals(fiche.getId()) && (ficheTransform.equals(new Integer(0)))) {
			
				//Calcul des alertes liées à la position géographique.
				this.calculateAlertesGeographiques(fiche, ficheSimultanee, alertes);
				
				//Calcul des alertes liées au nuisance.
				this.calculateAlertesNuisances(fiche, ficheSimultanee, alertes);
				
			}
			
		}
		
		return alertes;
	}
	
	
	/**
	 * Calcule les alertes pour une fiche données. Pour générer une alerte, la
	 * fiche doit avoir comme point commun avec une autre fiche, les points
	 * suivants :
	 * <ul>
	 * <li>Se dérouler sur le même niveau</li>
	 * <li>Se dérouler sur le même quadrant</li>
	 * <li>Se dérouler sur le même lieu</li>
	 * </ul>
	 * Trois niveau d'alerte sont possible , représenté par une couleur:
	 * <ul>
	 * <li>Faible (Jaune), si les deux fiches sont sur le même niveau</li>
	 * <li>Moyen : (Orange), si les deux fiches sont sur le même quadrant</li>
	 * <li>Important : (Rouge), si les deux fiches sont sur le même Lieu</li>
	 * </ul>
	 * 
	 * @param fiche
	 * @param ficheSimultanee
	 * @param alertes: cette liste se voit ajoutée les alertes trouvées
	 * 					lors du calcul de la méthode.
	 */	
	private void calculateAlertesGeographiques(Fiche fiche, Fiche ficheSimultanee, List alertes){
		
		//récupération des lieux de la fiche.
		List listeLieuxFiches = fiche.getLieux();
		List listeLieuxFichesSimultanes = ficheSimultanee.getLieux();
		
		//parcours les lieux de la fiche.
		for (Iterator iterator = listeLieuxFiches.iterator(); iterator.hasNext();) {
			RefLieu	 lieuFiche = (RefLieu) iterator.next();
			
			//parcours les lieux de la ficheSimultanée.
			
			for (Iterator iterator2 = listeLieuxFichesSimultanes.iterator(); iterator2
					.hasNext();) {
				RefLieu lieuFicheSimultanee = (RefLieu) iterator2.next();
				
				//tester si les manifestations sont au même niveau.
				if (lieuFiche.getQuadrant().getIdNiveau().equals(lieuFicheSimultanee.getQuadrant().getIdNiveau())) {
					
					//création d'une alerte.
					Alerte alerte = this.createAlerte();
				
					
						//tester si les manifestations sont dans le même quadrant.
					
					
						//tester si les manifestations sont dans le même lieu.
				
					
				}
				
			}

		}
		

	}
	
	
	private void createAlerte(Fiche fiche, Fiche ficheSimultanee){
		Alerte alerte = new Alerte();
		String message = RessourceFrontReader.getInstance()
				.getMessage("objet.alertes");
		message = message.replaceAll("\\{0\\}", fiche.getTitre());
		message = message.replaceAll("\\{1\\}", ficheSimultanee.getTitre());
		alerte.setObjet(message);
		
		Date dateDebutFiche = fiche.getDateEvenementList().iterator().next();
		Date dateDebutFicheSimultanee = dateEvenementHibernate.getDateDebut();
		
		
		if (dateDebutFiche.after(dateDebutFicheSimultanee)) {
			alerte.setDateDebut(DateUtil.convertDateToCalendar(dateDebutFiche));
		} else {
			alerte.setDateDebut(DateUtil.convertDateToCalendar(dateDebutFicheSimultanee));
		}
		
		Date dateFinFiche = ;
		Date dateFinFicheSimultane = dateEvenementHibernate.getDateFin();
		if (dateFinFiche.before(dateFinFicheSimultane)) {
			alerte.setDateFin(DateUtil.convertDateToCalendar(dateFinFiche));
		} else {
			alerte.setDateFin(DateUtil.convertDateToCalendar(dateFinFicheSimultane));
		}
		List fiches = new ArrayList();
		fiches.add(fiche);
		fiches.add(ficheAlerte);
		alerte.setFichesConcernees(fiches);
		alerte.setDateEmission(new GregorianCalendar());		
	}
	
	
	/**
	 * Caclule des alertes pour une fiche donnée. Pour engendrer un calcul d'alertes de nuisances, 
	 * les conditions suivantes doivent être réunies:
	 * - les deux fiches ne doivent pas être deux fiches de déclaration de travaux.
	 * - la fiche ou la fiche simultanée présente une nuisance.
	 * 
	 * @param fiche
	 * @param ficheSimultanee
	 * @param alertes: cette liste se voit ajoutée les alertes trouvées
	 * 					lors du calcul de la méthode.
	 */
	private void calculateAlertesNuisances(Fiche fiche, Fiche ficheSimultanee, List alertes){
	
		//1- Tester si la  ficheSimultanée n'est pas une déclaration de travaux.
		
			// - Tester si la fiche est nuisible pour la ficheSimultanée.
	
		//2- Test si la fiche n'est pas une déclaration de travaux.
	
			// - Tester si la ficheSimultanée est nuisible pour la fiche.  
	
	}
	
	/**
	 * récupère les fiches se déroulant pendant la même période
	 * que la fiche passée en paramètre.
	 * @return
	 */
	private List getFichesSimultanées(Fiche fiche, Session sessionHibernate){
		List fichesSimultanees = new ArrayList();
		
		//récupération des dates événements qui coïncides avec les dates_évènement de la fiche.
		List datesEvenementSimultanees = this.getDateEvenementSimultanee(fiche, sessionHibernate);
		
		//pour chaque date évènement récupérée, on récupère la fiche associée.
		for (Iterator iterator = datesEvenementSimultanees.iterator(); iterator.hasNext();) {
			HDateEvenement hDateEvenement = (HDateEvenement) iterator.next();
			fichesSimultanees.add(this.getFicheSimultanee(hDateEvenement, sessionHibernate));
		}
		
		return fichesSimultanees;
	}
	
	/**
	 * récupère les dates évènements qui chevauche les dates évènements
	 * de la fiche passée en paramètre.
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
			//récupération des dates chevauchante pour la date évènement en cours de la fiche.
			List datesEvements = crit.list();		
			//ajout des dates évènements dans la liste.
			datesEvenementSimultanees.addAll(datesEvements);
		}
		return datesEvenementSimultanees;
	}
	
	/**
	 * réupère la fiche correspondant à la date-événement passée
	 * en paramètre.
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
	
}
