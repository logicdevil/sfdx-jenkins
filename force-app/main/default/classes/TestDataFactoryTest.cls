@IsTest
private with sharing class TestDataFactoryTest {

	@IsTest
	static void invokeAllMethods_Test() {

		Test.startTest();
		TestDataFactory.getUser();
		TestDataFactory.getAccount();
		TestDataFactory.getLead();
		TestDataFactory.getContact();
		TestDataFactory.getEvent();
		TestDataFactory.getTask();
		TestDataFactory.getEmailMessage();
		Test.stopTest();
	}
}