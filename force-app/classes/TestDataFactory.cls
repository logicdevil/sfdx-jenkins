public class TestDataFactory {

	public static User getPredictableUser() {

		Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

		User singleUser = new User();
		singleUser.Email = 'test@email.com';
		singleUser.LastName = 'TestUserLastName';
		singleUser.FirstName = 'TestUserFirstName';
		singleUser.Username = 'UserName' + singleUser.Email;
		singleUser.Alias = 'A';
		singleUser.EmailEncodingKey = 'UTF-8';
		singleUser.LanguageLocaleKey = 'en_US';
		singleUser.LocaleSidKey = 'en_US';
		singleUser.TimeZoneSidKey = 'America/Los_Angeles';
		singleUser.ProfileId = p.Id;

		return singleUser;
	}

	public static User getRandomUser() {

		String randomNumber = ('' + (DateTime.now().getTime() * Math.random()));
		randomNumber = (randomNumber.length() > 16) ? randomNumber.substring(0, 16) : randomNumber;

		Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

		User singleUser = new User();
		singleUser.Email = 'test@email.com' + randomNumber;
		singleUser.LastName = 'TestUserLastName' + randomNumber;
		singleUser.FirstName = 'TestUserFirstName' + randomNumber;
		singleUser.Username = 'UserName' + singleUser.Email + randomNumber;
		singleUser.Alias = 'A' + randomNumber.substring(0, 7);
		singleUser.EmailEncodingKey = 'UTF-8';
		singleUser.LanguageLocaleKey = 'en_US';
		singleUser.LocaleSidKey = 'en_US';
		singleUser.TimeZoneSidKey = 'America/Los_Angeles';
		singleUser.ProfileId = p.Id;

		return singleUser;
	}

	public static User getSalesAgent() {
		Profile p = [SELECT Id FROM Profile WHERE Name = 'Belvilla Sales Agent'];
		User u = getPredictableUser();
		u.ProfileId = p.Id;
		return u;
	}

	public static Contact getContact() {

		String randomNumber = ('' + (DateTime.now().getTime() * Math.random()));
		randomNumber = (randomNumber.length() > 16) ? randomNumber.substring(0, 16) : randomNumber;

		Contact singleContact = new Contact();
		singleContact.LastName = 'LastName' + randomNumber;

		return singleContact;
	}

	public static Account getAccount() {

		String randomNumber = ('' + (DateTime.now().getTime() * Math.random()));
		randomNumber = (randomNumber.length() > 16) ? randomNumber.substring(0, 16) : randomNumber;

		Account singleAccount = new Account();
		singleAccount.Name = 'TestName' + randomNumber;

		return singleAccount;
	}

	public static Lead getLead() {

		String randomNumber = ('' + (DateTime.now().getTime() * Math.random()));
		randomNumber = (randomNumber.length() > 16) ? randomNumber.substring(0, 16) : randomNumber;

		Lead singleLead = new Lead();
		singleLead.LastName = 'Name' + randomNumber;
		singleLead.Company = randomNumber;
		singleLead.External_Id__c = randomNumber;
		singleLead.Status = 'New';//status.MasterLabel;

		return singleLead;
	}

	public static Task getTask() {

		String randomNumber = ('' + (DateTime.now().getTime() * Math.random()));
		randomNumber = (randomNumber.length() > 16) ? randomNumber.substring(0, 16) : randomNumber;

		Task singleTask = new Task();
		singleTask.Subject = 'TestSubject' + randomNumber;
		singleTask.OwnerId = UserInfo.getUserId();

		return singleTask;
	}

	public static Event getEvent() {

		String randomNumber = ('' + (DateTime.now().getTime() * Math.random()));
		randomNumber = (randomNumber.length() > 16) ? randomNumber.substring(0, 16) : randomNumber;

		Event singleEvent = new Event();
		singleEvent.Subject = 'TestSubject' + randomNumber;
		singleEvent.OwnerId = UserInfo.getUserId();
		singleEvent.DurationInMinutes = 60;
		singleEvent.ActivityDateTime = Datetime.now().addDays(1);

		return singleEvent;
	}

	public static EmailMessage getEmailMessage() {

		EmailMessage singleMessage = new EmailMessage();
		singleMessage.Subject = 'TestSubject';

		return singleMessage;
	}

	public static Id getAccommodationRecordTypeId() {
		return Schema.SObjectType.Account.getRecordTypeInfosByName().get('Belvilla Accommodation').getRecordTypeId();
	}

	public static String getAccommodationStatus() {
		String result = '';
		Schema.DescribeFieldResult fieldResult = Account.Accommodation_Status__c.getDescribe();
		List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
		for (Schema.PicklistEntry entry : picklistEntries) {
			if (entry.getValue() != 'W') {
				result = entry.getValue();
			}
		}
		return result;
	}

	public static String getAccommodationRegion() {
		List<String> result = new List<String>();
		Schema.DescribeFieldResult fieldResult = Account.BV_Region_Name__c.getDescribe();
		List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
		return picklistEntries[0].getValue();
	}

	public static List<String> getCompoundStringForTest() {
		return new List<String>{
				getAccommodationRegion() + AgentByRegionStringConstructor.SEPARATOR + getSalesAgentId()
		};
	}

	private static Id getSalesAgentId() {
		return [SELECT id FROM User WHERE Username LIKE '%UserName%'][0].id;
	}
}