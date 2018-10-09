@IsTest
private class TestDataFactoryTest {

	@IsTest
	static void test() {

		User singleUser = TestDataFactory.getPredictableUser();
		User secondUser = TestDataFactory.getRandomUser();
		User thirdUser = TestDataFactory.getSalesAgent();
		Account singleAccount = TestDataFactory.getAccount();
		Contact singleContact = TestDataFactory.getContact();
		Lead singleLead = TestDataFactory.getLead();
		Task singleTask = TestDataFactory.getTask();
		Event singleEvent = TestDataFactory.getEvent();
		EmailMessage singleMessage = TestDataFactory.getEmailMessage();
		String accommodationRegion = TestDataFactory.getAccommodationRegion();

		System.assertNotEquals(null, singleUser);
		System.assertNotEquals(null, singleAccount);
		System.assertNotEquals(null, singleContact);
		System.assertNotEquals(null, singleLead);
		System.assertNotEquals(null, singleTask);
		System.assertNotEquals(null, singleEvent);
	}
}