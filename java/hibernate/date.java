    	List<Sujet> toReturn = getCurrentSession()
    			.createQuery("from Sujet sujet where sujet.dateFin > :dateDuJour and temoinSuppression = false")
                .setParameter("dateDuJour", new Date(), DateType.INSTANCE)
    			.list();
        
    	return toReturn;
