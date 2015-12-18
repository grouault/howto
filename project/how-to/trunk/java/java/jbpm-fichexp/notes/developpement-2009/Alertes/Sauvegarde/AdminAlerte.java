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
import org.hibernate.criterion.Order;

import com.citedessciences.bdd.beans.HAlerte;
import com.citedessciences.bdd.beans.HDateEvenement;
import com.citedessciences.bdd.beans.HFicheExploitation;
import com.citedessciences.bdd.beans.HFicheExploitationCcv;
import com.citedessciences.bdd.beans.HFicheReservation;
import com.citedessciences.bdd.beans.HFicheccvDate;
import com.citedessciences.bdd.beans.HFicheexpDate;
import com.citedessciences.bdd.beans.HFicheresDate;
import com.citedessciences.bdd.beans.HRefDegreAlerte;
import com.citedessciences.bdd.beans.HUtilisateur;
import com.citedessciences.businesslogic.criteria.AlerteCriteria;
import com.citedessciences.businesslogic.entity.Alerte;
import com.citedessciences.businesslogic.entity.DateEvenement;
import com.citedessciences.businesslogic.entity.DegreAlerte;
import com.citedessciences.businesslogic.entity.Fiche;
import com.citedessciences.businesslogic.entity.FicheExploitation;
import com.citedessciences.businesslogic.entity.Localisation;
import com.citedessciences.businesslogic.mapping.AlerteMapper;
import com.citedessciences.businesslogic.mapping.FicheExploitationCCVMapper;
import com.citedessciences.businesslogic.mapping.FicheExploitationMapper;
import com.citedessciences.businesslogic.mapping.FicheReservationMapper;
import com.citedessciences.businesslogic.util.DateUtil;
import com.citedessciences.struts.util.RessourceFrontReader;

/**
 * Classe définissant les accès en base de données pour les alertes
 * 
 * @author SPIDER Business
 */
public class AdminAlerte extends Admin {

	private static final long serialVersionUID = -8918555264056600901L;

	private AlerteMapper alerteMapper = new AlerteMapper();

	/**
	 * Retourne une Alerte en fonction de son id unique
	 * 
	 * @param id
	 *            est un Integer qui représente l'id unique (NUMSEQALE en bdd)
	 * @param sessionHibernate
	 * @return Alerte
	 * @throws Exception
	 *             si une erreur de récupération en base est levée
	 */
	/*
	public Alerte get(Integer id, Session sessionHibernate) throws Exception {
		HAlerte alerteHibernate = (HAlerte) sessionHibernate.get(HAlerte.class,
				id);
		Alerte alerte = (Alerte) alerteMapper.BDDToMetier(alerteHibernate);
		List fiches = new ArrayList();
		AdminFicheReservation adminFicheReservation = new AdminFicheReservation();
		List ficheReservation = adminFicheReservation
				.getFichesReservationByIdAlerte(alerte.getId(),
						sessionHibernate);

		AdminFicheExploitation adminFicheExploitation = new AdminFicheExploitation();
		List ficheExploitation = adminFicheExploitation
				.getFicheExploitationByIdAlerte(alerte.getId(),
						sessionHibernate);

		AdminFicheExploitationCCV adminFicheExploitationCCV = new AdminFicheExploitationCCV();
		List ficheCCV = adminFicheExploitationCCV.getFicheCCVByIdAlerte(alerte
				.getId(), sessionHibernate);

		fiches.addAll(ficheReservation);
		fiches.addAll(ficheExploitation);
		fiches.addAll(ficheCCV);
		alerte.setFichesConcernees(fiches);
		return alerte;
	}
	*/
	
	/**
	 * Récupération de la liste des alertes en fonction des critères renseignés
	 * dans l'objet AlerteCriteria
	 * 
	 * @param alerteCriteria
	 *            contient les critères
	 * @param sessionHibernate
	 * @return Liste d'objet Alerte
	 * @throws Exception
	 *             s'il y a un problème en base de données
	 * @see AlerteCriteria
	 */
	public List getAlertes(Session sessionHibernate,
			AlerteCriteria alerteCriteria) throws Exception {
		Criteria crit = sessionHibernate.createCriteria(HAlerte.class);
		if (alerteCriteria.getObjet() != null) {
			if (alerteCriteria.getObjet().equals("asc")) {
				crit.addOrder(Order.asc(HAlerte.PROP_OBJET));
			} else {
				crit.addOrder(Order.desc(HAlerte.PROP_OBJET));
			}
		} else if (alerteCriteria.getStatut() != null) {
			if (alerteCriteria.getStatut().equals("asc")) {
				crit.addOrder(Order.asc(HAlerte.PROP_DATE_LEVEE));
			} else {
				crit.addOrder(Order.desc(HAlerte.PROP_DATE_LEVEE));
			}
		} else if (alerteCriteria.getNiveau() != null) {
			if (alerteCriteria.getNiveau().equals("asc")) {
				crit.addOrder(Order.asc(HAlerte.PROP_CODE_DEGRE_ALERTE));
			} else {
				crit.addOrder(Order.desc(HAlerte.PROP_CODE_DEGRE_ALERTE));
			}
		} else if (alerteCriteria.getDateEmission() != null) {
			if (alerteCriteria.getDateEmission().equals("asc")) {
				crit.addOrder(Order.asc(HAlerte.PROP_DATE_EMISSION));
			} else {
				crit.addOrder(Order.desc(HAlerte.PROP_DATE_EMISSION));
			}
		}

		if (alerteCriteria.isEnCours() != null) {
			if (new Integer(1).equals(alerteCriteria.isEnCours())) {
				crit = crit.add(Expression.isNull(HAlerte.PROP_DATE_LEVEE));
			} else {
				crit = crit.add(Expression.isNotNull(HAlerte.PROP_DATE_LEVEE));
			}
		}
		
		if (alerteCriteria.getIdFicheDT() != null) {
			crit = crit.createCriteria(HAlerte.PROP_FICHE_DT).add(Expression.eq("id", alerteCriteria.getIdFicheDT()));
		} else if (alerteCriteria.getIdFicheCCV() != null) {
			crit = crit.createCriteria(HAlerte.PROP_FICHE_EXPLOITATION_CCV).add(Expression.eq(HFicheExploitationCcv.PROP_ID, alerteCriteria.getIdFicheCCV()));
		} else if (alerteCriteria.getIdFicheExp() != null) {
			crit = crit.createCriteria(HAlerte.PROP_FICHE_EXPLOITATION).add(Expression.eq(HFicheExploitation.PROP_ID, alerteCriteria.getIdFicheExp()));
		} else if (alerteCriteria.getIdFicheRes() != null) {
			crit = crit.createCriteria(HAlerte.PROP_FICHE_RESERVATION).add(Expression.eq(HFicheReservation.PROP_ID, alerteCriteria.getIdFicheRes()));
		} 
		
		if (alerteCriteria.getIdChefProjet() != null) {
			crit = crit.createAlias(HAlerte.PROP_CHEF_PROJET, "CHEF");
			crit.add(Expression.eq("CHEF." + HUtilisateur.PROP_NUMSEQUTR,
					alerteCriteria.getIdChefProjet()));
		}

		List listOfHibObject = scroll(alerteCriteria, crit);
		AlerteMapper mapper = new AlerteMapper();
		List alertesList = mapper.BDDToMetier(listOfHibObject);
		return alertesList;
	}
	

	/**
	 * Calcule les alertes pour une fiche données. Pour générer une alerte, la
	 * fiche doit avoir comme point commun avec une autre fiche, les points
	 * suivants :
	 * <ul>
	 * <li>Se dérouler sur la même période</li>
	 * <li>Se dérouler sur le même lieu</li>
	 * </ul>
	 * Trois niveau d'alerte sont possible , représenté par une couleur:
	 * <ul>
	 * <li>Faible (Jaune), si les deux fiches sont sur le même Super espace</li>
	 * <li>Moyen : (Orange), si les deux fiches sont sur le même Espace</li>
	 * <li>Important : (Rouge), si les deux fiches sont sur le même Lieu</li>
	 * </ul>
	 * 
	 * @param fiche
	 *            La fiche référence pour déterminer les alertes
	 * @param sessionHibernate
	 * @return Liste d'objet Alerte
	 */
	public List calculateAlertes(Fiche fiche, Session sessionHibernate) {
		List datesEvenement = fiche.getDateEvenementList();
		List alertes = new ArrayList();
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
			List datesEvementsHibernate = crit.list();
			for (Iterator iterator = datesEvementsHibernate.iterator(); iterator.hasNext();) {
				HDateEvenement dateEvenementHibernate = (HDateEvenement) iterator
						.next();
				Fiche ficheAlerte = null;
				if (dateEvenementHibernate.getFicheccvDateSet() != null
						&& dateEvenementHibernate.getFicheccvDateSet().size() > 0) {
					HFicheccvDate ficheCcvDate = (HFicheccvDate) dateEvenementHibernate
							.getFicheccvDateSet().iterator().next();
					HFicheExploitationCcv ficheExploitationHibernate = ficheCcvDate
							.getId().getFicheExploitationCcv();
					FicheExploitationCCVMapper mapper = new FicheExploitationCCVMapper();
					ficheAlerte = (Fiche) mapper
							.BDDToMetier(ficheExploitationHibernate, false,
									sessionHibernate);
				} else if (dateEvenementHibernate.getFicheresDateSet() != null
						&& dateEvenementHibernate.getFicheresDateSet().size() > 0) {
					HFicheresDate ficheResDate = (HFicheresDate) dateEvenementHibernate
							.getFicheresDateSet().iterator().next();
					HFicheReservation ficheReservationHibernate = ficheResDate
							.getId().getFicheReservation();
					FicheReservationMapper mapper = new FicheReservationMapper();
					ficheAlerte = (Fiche) mapper.BDDToMetier(
							ficheReservationHibernate, false, sessionHibernate);
				} else if (dateEvenementHibernate.getFicheexpDateSet() != null
						&& dateEvenementHibernate.getFicheexpDateSet().size() > 0) {
					HFicheexpDate ficheExpDate = (HFicheexpDate) dateEvenementHibernate
							.getFicheexpDateSet().iterator().next();
					HFicheExploitation ficheExploitationHibernate = ficheExpDate
							.getId().getFicheExploitation();
					FicheExploitationMapper mapper = new FicheExploitationMapper();
					ficheAlerte = (Fiche) mapper
							.BDDToMetier(ficheExploitationHibernate, false,
									sessionHibernate);
				}
				Integer ficheTransform = new Integer(0);
				if (fiche instanceof FicheExploitation) {
					FicheExploitation ficheExploitation = (FicheExploitation) fiche;
					ficheTransform = ficheExploitation.getFicheReservation();
				}
				if (ficheAlerte != null && !ficheAlerte.getId().equals(fiche.getId()) && (ficheTransform.equals(new Integer(0)))) {
					
					List lstLocalisationsFiche = fiche.getLocalisations();
					List lstLocalisationFicheAlerte = new ArrayList();
					
					for (Iterator iterLocalisationsFiche = lstLocalisationsFiche.iterator(); iterLocalisationsFiche.hasNext();) {
						Localisation objLocalisationFiche = (Localisation) iterLocalisationsFiche.next();
						Localisation objSuperEspace = sameSuperEspace(objLocalisationFiche, ficheAlerte);
						if (objSuperEspace != null) {
							lstLocalisationFicheAlerte.add(objSuperEspace);
						}
					}

					if (!lstLocalisationFicheAlerte.isEmpty()) {
						Alerte alerte = new Alerte();
						String message = RessourceFrontReader.getInstance()
								.getMessage("objet.alertes");
						message = message.replaceAll("\\{0\\}", fiche
								.getTitre());
						message = message.replaceAll("\\{1\\}", ficheAlerte
								.getTitre());
						alerte.setObjet(message);
						Date dateDebutFiche2 = dateEvenementHibernate
								.getDateDebut();
						if (dateDebut.after(dateDebutFiche2)) {
							alerte.setDateDebut(DateUtil
									.convertDateToCalendar(dateDebut));
						} else {
							alerte.setDateDebut(DateUtil
									.convertDateToCalendar(dateDebutFiche2));
						}
						Date dateFinFiche2 = dateEvenementHibernate
								.getDateFin();
						if (dateFin.before(dateFinFiche2)) {
							alerte.setDateFin(DateUtil
									.convertDateToCalendar(dateFin));
						} else {
							alerte.setDateFin(DateUtil
									.convertDateToCalendar(dateFinFiche2));
						}
						List fiches = new ArrayList();
						fiches.add(fiche);
						fiches.add(ficheAlerte);
						alerte.setFichesConcernees(fiches);
						alerte.setDateEmission(new GregorianCalendar());
						
						alertes.addAll(getAlertes(lstLocalisationsFiche, lstLocalisationFicheAlerte, alerte));
					}
				}
			}

		}
		return alertes;
	}

	/**
	 * Sauvegarde l'alerte en base de donnée
	 * 
	 * @param alerte
	 *            Alerte à sauvegarder
	 * @param sessionHibernate
	 * @throws Exception
	 *             levée s'il y a un problème en base de donnée
	 */
	/*
	public void saveOrUpdate(Alerte alerte, Session sessionHibernate)
			throws Exception {
		HAlerte alerteHibernate = null;
		if (alerte.getId() != null) {
			alerteHibernate = (HAlerte) sessionHibernate.get(HAlerte.class,
					alerte.getId());
		} else {
			alerteHibernate = new HAlerte();
		}
	
		if (alerte.getDegreAlerte() != null
				&& alerte.getDegreAlerte().getId() != null) {
			HRefDegreAlerte refDegreAlerte = (HRefDegreAlerte) sessionHibernate
					.get(HRefDegreAlerte.class, alerte.getDegreAlerte().getId());
			alerteHibernate.setCodeDegreAlerte(refDegreAlerte);
		}
	
		if (alerte.getDateCommentaire() != null ) {
			//mise en place du commentaire de l'allerte
			alerteHibernate.setCommentaire(alerte.getCommentaire());
			//mise en place de la date du commentaire
			alerteHibernate.setDateCommentaire(DateUtil
					.convertCalendarToDate(alerte.getDateCommentaire()));
		}
		alerteHibernate.setCorps(alerte.getCorps());
		alerteHibernate.setDateDebutAlerte(DateUtil
				.convertCalendarToDate(alerte.getDateDebut()));
		alerteHibernate.setDateEmission(DateUtil.convertCalendarToDate(alerte
				.getDateEmission()));
		alerteHibernate.setDateFinAlerte(DateUtil.convertCalendarToDate(alerte
				.getDateFin()));
		if (alerte.getDateLevee() != null) {
			alerteHibernate.setDateLevee(DateUtil.convertCalendarToDate(alerte
					.getDateLevee()));
		} else {
			alerteHibernate.setDateLevee(null);
		}
		alerteHibernate.setObjet(alerte.getObjet());
	
		sessionHibernate.saveOrUpdate(alerteHibernate);
	}
	*/

	/**
	 * Cette method reçoit une alerte
	 * Elle calcule le niveau de cette alerte et retourne une liste 
	 * d'alertes en fonction de la règle de gestion suivante:
	 * 
	 * <li>Faible (Jaune), si les deux fiches sont sur le même Super espace</li>
	 * <li>Moyen (Orange), si les deux fiches sont sur le même Espace</li>
	 * <li>Important (Rouge), si les deux fiches sont sur le même Lieu</li>
	 * 
	 * @param p_lstLocalisationFiche : Liste d'objet Localisation
	 * @param p_lstLocalisationFicheEnAlerte : Liste d'objet Localisation
	 * @return List
	 */
	private List getAlertes(List p_lstLocalisationFiche, List p_lstLocalisationFicheEnAlerte, Alerte p_objAlerte) {
		
		List lstAlertes = new ArrayList();
		
		for (Iterator iter = p_lstLocalisationFiche.iterator(); iter.hasNext();) {
			Localisation objLocalisation = (Localisation) iter.next();
			int nNiveauLocalisation = objLocalisation.getNiveau();
			Alerte objAlerte = copyAlerte(p_objAlerte);
			
			switch (nNiveauLocalisation){
			case Localisation.NIVEAU_SUPER_ESPACE:
				for (Iterator iterator = p_lstLocalisationFicheEnAlerte.iterator(); iterator.hasNext(); ) {
					Localisation objLocalisationEnAlerte = (Localisation) iterator.next();
					int nNiveauLocalisationAlerte = objLocalisationEnAlerte.getNiveau();
					switch (nNiveauLocalisationAlerte){
					case Localisation.NIVEAU_SUPER_ESPACE:
						if (objLocalisationEnAlerte.getId().intValue() == objLocalisation.getId().intValue()){
							// même super espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);
						}
						break;
					case Localisation.NIVEAU_ESPACE:
						if (objLocalisationEnAlerte.getRoot().getId().intValue() == objLocalisation.getId().intValue()){
							// même espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);
						}
						break;
					case Localisation.NIVEAU_LIEU:
						if (objLocalisationEnAlerte.getRoot().getId().intValue() == objLocalisation.getId().intValue()){
							// même lieu
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);
						}
						break;
					default: 
						// rien à faire
					}
				}
				break;
			case Localisation.NIVEAU_ESPACE:
				for (Iterator iterator = p_lstLocalisationFicheEnAlerte.iterator(); iterator.hasNext(); ) {
					Localisation objLocalisationEnAlerte = (Localisation) iterator.next();
					int nNiveauLocalisationAlerte = objLocalisationEnAlerte.getNiveau();
					switch (nNiveauLocalisationAlerte){
					case Localisation.NIVEAU_SUPER_ESPACE:
						if (objLocalisationEnAlerte.getId().intValue() == objLocalisation.getRoot().getId().intValue()){
							// même super espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);
						}
						break;
					case Localisation.NIVEAU_ESPACE:
						if (objLocalisationEnAlerte.getId().intValue() == objLocalisation.getId().intValue()){
							// même espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_MOYEN);
						} else if (objLocalisationEnAlerte.getRoot().getId().intValue() == objLocalisation.getRoot().getId().intValue()){
							// même super espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);
						}
						break;
					case Localisation.NIVEAU_LIEU:
						if (objLocalisationEnAlerte.getLieuParent().getId().intValue() == objLocalisation.getId().intValue()){
							// même espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_MOYEN);
						} else if (objLocalisationEnAlerte.getRoot().getId().intValue() == objLocalisation.getRoot().getId().intValue()){
							// même super espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);
						}
						break;
					default: 
						// rien à faire
					}
				}
				break;
			case Localisation.NIVEAU_LIEU:
				for (Iterator iterator = p_lstLocalisationFicheEnAlerte.iterator(); iterator.hasNext(); ) {
					Localisation objLocalisationEnAlerte = (Localisation) iterator.next();
					int nNiveauLocalisationAlerte = objLocalisationEnAlerte.getNiveau();
					switch (nNiveauLocalisationAlerte){
					case Localisation.NIVEAU_SUPER_ESPACE:
						if (objLocalisationEnAlerte.getId().intValue() == objLocalisation.getRoot().getId().intValue()){
							// même super espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);
						}
						break;
					case Localisation.NIVEAU_ESPACE:
						if (objLocalisationEnAlerte.getId().intValue() == objLocalisation.getLieuParent().getId().intValue()){
							// même espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_MOYEN);
						} else if (objLocalisationEnAlerte.getRoot().getId().intValue() == objLocalisation.getRoot().getId().intValue()){
							// même super espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);
						}
						break;
					case Localisation.NIVEAU_LIEU:
						if (objLocalisationEnAlerte.getId().intValue() == objLocalisation.getId().intValue()){
							// même lieu
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_IMPORTANT);
						} else if (objLocalisationEnAlerte.getLieuParent().getId().intValue() == objLocalisation.getLieuParent().getId().intValue()){
							// même espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_MOYEN);
						} else if (objLocalisationEnAlerte.getRoot().getId().intValue() == objLocalisation.getRoot().getId().intValue()){
							// même super espace
							objAlerte.setDegreAlerte(DegreAlerte.DEGRE_ALERTE_FAIBLE);							
						}
						break;
					default: 
						// rien à faire
					}
				}
				break;
			default :
				// rien à faire ici
			}
			// on ajoute cette alerte si il n'y a pas déjà une alerte de même niveau
			safeAddAlerte(lstAlertes, objAlerte);
		}

		return lstAlertes;
	}

	/**
	 * ajoute une alerte p_objAlerte à la liste p_lstAlertes 
	 * uniquement si il n'existe pas déjà une alerte de ce niveau dans p_lstAlertes
	 * @param p_lstAlertes
	 * @param p_objAlerte
	 */
	private void safeAddAlerte(List p_lstAlertes, Alerte p_objAlerte) {
		if (p_objAlerte.getDegreAlerte() != null){
			boolean bExistAlert = false;
			for (Iterator iterAlertes = p_lstAlertes.iterator(); iterAlertes.hasNext(); ){
				Alerte element = (Alerte)iterAlertes.next();
				if (element.getDegreAlerte().equals(p_objAlerte.getDegreAlerte())){
					bExistAlert = true;
					break;
				}
			}
			if (!bExistAlert){
				p_lstAlertes.add(p_objAlerte);
			}
		}
	}

	/**
	 * retourne une copie de l'objet p_objAlerte
	 * @param p_objAlerte
	 * @return
	 */
	private Alerte copyAlerte(Alerte p_objAlerte) {
		Alerte objAlerteCopy = new Alerte();
		objAlerteCopy.setObjet(p_objAlerte.getObjet());
		objAlerteCopy.setDateDebut(p_objAlerte.getDateDebut());
		objAlerteCopy.setDateFin(p_objAlerte.getDateFin());
		objAlerteCopy.setFichesConcernees(p_objAlerte.getFichesConcernees());
		objAlerteCopy.setDateEmission(p_objAlerte.getDateEmission());	
		return objAlerteCopy;
	}

	/**
	 * Verifie si les localisations de la fiche en alerte sont sur le même super espace que la localisation p_objLocalisation 
	 * 
	 * @param p_objLocalisation: Localisation de la fiche sur laquelle on travaille
	 * @param p_objFicheEnAlerte: Fiche en alerte avec la fiche sur laquelle on travaille
	 * 
	 * @return Retourne le Super Espace si au moins une localisation de la fiche en alerte est sur le même super espace que p_objLocalisation 
	 */
	private Localisation sameSuperEspace(Localisation p_objLocalisation, Fiche p_objFicheEnAlerte) {
		
		List lstLocalisationFicheAlerte = p_objFicheEnAlerte.getLocalisations();
		Localisation objSuperEspace = null;
		
		for (Iterator iter = lstLocalisationFicheAlerte.iterator(); iter.hasNext();) {
			Localisation localisation = (Localisation) iter.next();
			if (p_objLocalisation.getRoot().equals(localisation.getRoot())) {
				objSuperEspace = localisation;
				break;
			}
		}
		return objSuperEspace;
	}
}
