public class TestDataFactory {

	public static User getUser() {

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
	
}