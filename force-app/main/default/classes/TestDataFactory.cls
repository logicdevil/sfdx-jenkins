public class TestDataFactory {

	public static User getUser() {

		String randomString = getRandomString(10);

		Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

		User singleUser = new User();
		singleUser.Email = 'test@email.com' + randomString;
		singleUser.LastName = 'TestUserLastName' + randomString;
		singleUser.FirstName = 'TestUserFirstName' + randomString;
		singleUser.Username = 'UserName' + singleUser.Email + randomString;
		singleUser.Alias = 'A' + randomString.substring(0, 7);
		singleUser.EmailEncodingKey = 'UTF-8';
		singleUser.LanguageLocaleKey = 'en_US';
		singleUser.LocaleSidKey = 'en_US';
		singleUser.TimeZoneSidKey = 'America/Los_Angeles';
		singleUser.ProfileId = p.Id;

		return singleUser;
	}

	public static Contact getContact() {

		String randomString = getRandomString();

		Contact singleContact = new Contact();
		singleContact.LastName = 'LastName' + randomString;

		return singleContact;
	}

	public static Account getAccount() {

		String randomString = getRandomString();

		Account singleAccount = new Account();
		singleAccount.Name = 'TestName' + randomString;

		return singleAccount;
	}

	public static Lead getLead() {

		String randomString = getRandomString();

		Lead singleLead = new Lead();
		singleLead.LastName = 'Name' + randomString;
		singleLead.Company = randomString;
		singleLead.Status = 'New';

		return singleLead;
	}

	public static Task getTask() {

		String randomString = getRandomString();

		Task singleTask = new Task();
		singleTask.Subject = 'TestSubject' + randomString;
		singleTask.OwnerId = UserInfo.getUserId();

		return singleTask;
	}

	public static Event getEvent() {

		String randomString = getRandomString();

		Event singleEvent = new Event();
		singleEvent.Subject = 'TestSubject' + randomString;
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


	private static String getRandomString() {

		return getRandomString(null);
	}

	private static String getRandomString(Integer maxSize) {

		Integer internalMaxSize = 16; //just a random number

		if (maxSize != null && maxSize > 0) {
			internalMaxSize = maxSize;
		}

		String randomString = String.valueOf(DateTime.now().getTime() * Math.random());
		randomString = (randomString.length() > internalMaxSize) ? randomString.substring(0, internalMaxSize) : randomString;

		return randomString;
	}
}