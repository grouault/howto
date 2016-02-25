import org.bonitasoft.engine.api.IdentityAPI;
import org.bonitasoft.engine.identity.ContactData;
import org.bonitasoft.engine.identity.User;

// recuperation initiateur du processus.
def processInstance = apiAccessor.processAPI.getProcessInstance(processInstanceId);
long initiatorUserId = processInstance.getStartedBy();
// recuperation user
IdentityAPI identityAPI = apiAccessor.getIdentityAPI();
User userInitiator = identityAPI.getUser(initiatorUserId);
ContactData contactData = identityAPI.getUserContactData(initiatorUserId, false);
// contenu EMAIL
def out = "Bonjour " + userInitiator.getFirstName() + " " + userInitiator.getLastName() + "<br/>";
out += "Votre demande demande de congé est accepté.<br/>";
out += "Nombre de jour : " + request.getDayCount() + "<br/>";
out += "Cordialement";
return out;

// recuperation des acteurs