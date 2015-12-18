	private List getCategorieVisaBeanList(List list, HttpServletRequest p_request) {
		List categorieVisaListToReturn = new ArrayList();
		TreeMap categorieVisaBeanList = new TreeMap();
		for (Iterator iter = list.iterator(); iter.hasNext();) {
			Utilisateur viseur = (Utilisateur) iter.next();
			List categorieVisaList = viseur.getCategorieVisaList();
			if (categorieVisaList != null && categorieVisaList.size() > 0) {
				for (Iterator iterator = categorieVisaList.iterator(); iterator
						.hasNext();) {
					CategorieVisa categorieVisa = (CategorieVisa) iterator
							.next();

					Object o = categorieVisaBeanList.get(categorieVisa
							.getLibelle());
					if (o == null) {
						CategorieVisaBean categorieVisaBean = new CategorieVisaBean();
						categorieVisaBean.setCommentaire(categorieVisa
								.getCommentaire());
						categorieVisaBean.setId(categorieVisa.getId());
						categorieVisaBean
								.setLibelle(categorieVisa.getLibelle());
						if (isCategorieViseur(viseur, categorieVisaBean)) {
							categorieVisaBean.getActeurBeanList().add(
									getActeurBean(viseur, p_request));
						}
						categorieVisaBeanList.put(categorieVisaBean
								.getLibelle(), categorieVisaBean);
					} else {
						CategorieVisaBean categorieVisaBean = (CategorieVisaBean) o;
						if (isCategorieViseur(viseur, categorieVisaBean)) {
							categorieVisaBean.getActeurBeanList().add(
									getActeurBean(viseur, p_request));
						}
					}
				}
			} else {

			}
		}
		categorieVisaListToReturn.addAll(categorieVisaBeanList.values());
		return categorieVisaListToReturn;
	}