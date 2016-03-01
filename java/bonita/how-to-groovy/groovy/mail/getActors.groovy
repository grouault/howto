// recuperation contacts.
ProcessAPI processAPI = apiAccessor.getProcessAPI();
long actorId = processAPI.getActors(processDefinitionId, 0, 1, ActorCriterion.NAME_ASC).get(0).getId();

ActorInstance actorInstance = processAPI.getActorInitiator(processDefinitionId);
