package com.citedessciences.struts.actions;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.citedessciences.businesslogic.administration.AdminFactory;
import com.citedessciences.businesslogic.entity.Astreinte;
import com.citedessciences.businesslogic.entity.EvenementExceptionnel;
import com.citedessciences.businesslogic.entity.Fiche;
import com.citedessciences.businesslogic.entity.InformationImportante;
import com.citedessciences.businesslogic.impression.ImpressionAgendaBean;
import com.citedessciences.businesslogic.util.DateUtil;
import com.citedessciences.struts.beans.AgendaBean;
import com.citedessciences.struts.beans.AgendaSectBean;
import com.citedessciences.struts.forms.AgendaPublicForm;
import com.citedessciences.struts.util.ApplicationResourcesProperties;
import com.citedessciences.struts.util.RessourceFrontReader;

/**
 * Action éxécutée lors de l'accès à l'agenda de la semaine
 * 
 * @author Sylvain KLAM
 *
 */
public class AgendaSemaineAction extends AgendaAction {

	/**
	 * Récupération des informations à afficher dans l'agenda
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		req.setAttribute("typeAgenda","semaine");
		ActionForward objActionForward;
		try {
			objActionForward = super.execute(mapping, form, req, res);
		} catch (Exception e) {
			objActionForward = mapping.findForward("error");
		}		
		return objActionForward;
	}

	/**
	 * Méthode lancée par défaut
	 */
	public ActionForward unspecified(ActionMapping mapping, ActionForm form, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		AgendaPublicForm formulaire = (AgendaPublicForm) form;

		// formatage - parsing de la date serveur afin d'obtenir une date du jour  à minuit pile : 
		SimpleDateFormat DATE_EVT = new SimpleDateFormat("dd/MM/yyyy", Locale.FRENCH);
		Date dateTmp = new Date();
		String dateStringTmp = DATE_EVT.format(dateTmp);
		dateTmp = DATE_EVT.parse(dateStringTmp);
		formulaire.setDateCourante(dateTmp);		
		
		AgendaBean agendaBean = getAgendaSemaine(req, dateTmp);
		req.setAttribute("agenda", agendaBean);
		req.getSession().setAttribute("page","tab.agenda");
		return mapping.findForward("success");
	}

	/**
	 * Action "Imprimer"
	 * 
	 * @param mapping
	 * @param form
	 * @param req
	 * @param resp
	 * @return
	 * @throws Exception
	 */
	public ActionForward imprimer(ActionMapping mapping, ActionForm form, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		// formatage - parsing de la date serveur afin d'obtenir une date du jour  à minuit pile : 
		SimpleDateFormat DATE_EVT = new SimpleDateFormat("dd/MM/yyyy", Locale.FRENCH);
		Date dateTmp = new Date();
		String dateStringTmp = DATE_EVT.format(dateTmp);
		dateTmp = DATE_EVT.parse(dateStringTmp);
		
		AgendaBean agendaBean = getAgendaSemaine(req, dateTmp);
		ImpressionAgendaBean impressionAgendaBean = new ImpressionAgendaBean(agendaBean);
		impressionAgendaBean.processPdf(resp, req);
		return null;
	}	

	public ActionForward imprimerDetail(ActionMapping mapping, ActionForm form, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		// formatage - parsing de la date serveur afin d'obtenir une date du jour  à minuit pile : 
		SimpleDateFormat DATE_EVT = new SimpleDateFormat("dd/MM/yyyy", Locale.FRENCH);
		Date dateTmp = new Date();
		String dateStringTmp = DATE_EVT.format(dateTmp);
		dateTmp = DATE_EVT.parse(dateStringTmp);
		
		AgendaBean agendaBean = getAgendaSemaine(req, dateTmp);
		ImpressionAgendaBean impressionAgendaBean = new ImpressionAgendaBean(agendaBean);
		impressionAgendaBean.processDetailPdf(resp, req);
		return null;
	}
	
	/**
	 * Récupération des informations à afficher dans l'agenda
	 * 
	 * @param req
	 * @return
	 */
	private AgendaBean getAgendaSemaine(HttpServletRequest req, Date dateForm) {

		Date debut = null;
		Date fin = null;		
		if (dateForm != null)
		{
			debut = DateUtil.getJeudi(dateForm).getTime();		
			
			fin = DateUtil.getMecredi(dateForm).getTime();
			
		}
		else
		{
			debut = DateUtil.getJeudi(new Date()).getTime();		
			
			fin = DateUtil.getMecredi(new Date()).getTime();
			
		}
		

		AgendaBean agenda = new AgendaBean(debut, fin);
		String debutString = RessourceFrontReader.getInstance()
				.dateToStringForForm(req, debut);
		String finString = RessourceFrontReader.getInstance()
				.dateToStringForForm(req, fin);
		
		List ficheMetierList = AdminFactory.getInstance()
				.getListeFicheValideByDatesAndTypeFiche(debutString, finString);
		agenda.setListFiches(ficheMetierList);
		List informationsImportantesList = AdminFactory.getInstance()
				.getListeInformationsImportantesByDate(debutString, finString);
		List astreintesList = AdminFactory.getInstance()
				.getListeAstreintesByDate(debutString, finString);
		List evenementExceptionnelList = AdminFactory.getInstance()
				.getListeEvenementsByDate(debutString, finString);

		AgendaSectBean section;
		
		if (informationsImportantesList.size() > 0) {
			section = agenda.getOrCreateSection(ApplicationResourcesProperties.getInstance().getApplicationResourcesProperties().getProperty("agenda.titre.infos"));
			for (Iterator iter = informationsImportantesList.iterator(); iter
					.hasNext();) {
				InformationImportante informationImportante = (InformationImportante) iter
						.next();
				section.createAgendaEv(informationImportante);
			}
		}
		
		if (evenementExceptionnelList.size() > 0) {
			section = agenda.getOrCreateSection(ApplicationResourcesProperties.getInstance().getApplicationResourcesProperties().getProperty("agenda.titre.eve.exceptionnels"));
			for (Iterator iter = evenementExceptionnelList.iterator(); iter
					.hasNext();) {
				EvenementExceptionnel evenementExceptionnel = (EvenementExceptionnel) iter
						.next();
				section.createAgendaEv(evenementExceptionnel);
			}
		}
		
		
		for (Iterator iter = ficheMetierList.iterator(); iter.hasNext();) {
			Fiche fiche = (Fiche) iter.next();
			
			section = agenda.getOrCreateSection(fiche.getTypeOperation().getTypeOperationRoot().getTitre());
			if (section.getLibelle().equalsIgnoreCase(fiche.getTypeOperation().getTypeOperationRoot().getTitre())) {
				section.createAgendaEv(fiche, debut, fin);
			}
		}

		if (astreintesList.size() > 0) {
			section = agenda.getOrCreateSection(ApplicationResourcesProperties.getInstance().getApplicationResourcesProperties().getProperty("agenda.titre.astreintes"));
			for (Iterator iter = astreintesList.iterator(); iter.hasNext();) {
				Astreinte astreinte = (Astreinte) iter.next();
				section.createAgendaEv(astreinte);
			}
		}

		//agenda.calculOptimisation();
		return agenda;
	}



	
}
