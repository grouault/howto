import org.bonitasoft.engine.api.IdentityAPI;
import org.bonitasoft.engine.api.ProcessAPI;
import org.bonitasoft.engine.bpm.actor.ActorCriterion;
import org.bonitasoft.engine.bpm.actor.ActorInstance;
import org.bonitasoft.engine.bpm.actor.ActorMember;
import org.bonitasoft.engine.identity.ContactData;
import org.bonitasoft.engine.identity.User;

// recuperation initiateur du processus.
def processInstance = apiAccessor.processAPI.getProcessInstance(processInstanceId);
long initiatorUserId = processInstance.getStartedBy();

// recuperation user
IdentityAPI identityAPI = apiAccessor.getIdentityAPI();
User userInitiator = identityAPI.getUser(initiatorUserId);
ContactData contactData = identityAPI.getUserContactData(initiatorUserId, false);

// recuperation contacts.
ProcessAPI processAPI = apiAccessor.getProcessAPI();
long actorId = processAPI.getActors(processDefinitionId, 0, 1, ActorCriterion.NAME_ASC).get(0).getId();

// actor initiator
ActorInstance actorInitiator = processAPI.getActorInitiator(processDefinitionId);
ActorInstance actorInstance = processAPI.getActor(actorId);
List<ActorMember> members = processAPI.getActorMembers(actorId, 2, 4);

// recuperation du manager valideur.
long managerId = userInitiator.getManagerUserId();
User userManager = identityAPI.getUser(managerId);

// contenu EMAIL
def out = "Bonjour " + userInitiator.getFirstName() + " " + userInitiator.getLastName() + "<br/><br/>";
out += "Votre demande demande de congé est accepté.<br/>";
out += "Nombre de jour : " + request.getDayCount() + "<br/>";
out += "Commentaire : " + request.getManagerComment() + "<br/><br/>";
out += "Validé par : " + userManager.getLastName() + "<br/><br/>";
out += "Cordialement.";
return out;