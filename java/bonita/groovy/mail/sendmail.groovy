'Bonjour\n' +
'Votre demande demande de congé est accespté\n' +
'Nombre de jour : ' + request.getDayCount() + '\n' +
'Cordialement'

def out = "Bonjour \n"
out += "Votre demande demande de congé est accepté\n\n"
out += "Nombre de jour : " + request.getDayCount() + "\n\n"
return out

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
def out = "Bonjour " + userInitiator.getFirstName() + " " + userInitiator.getLastName() + "\n";
out += "Votre demande demande de congé est accepté\n\n";
out += "Nombre de jour : " + request.getDayCount() + "\n\n";
return out;