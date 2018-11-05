@IsTest
private class DatabaseProxyTest {

	@TestSetup
	static void setup() {
		Account singleAccount = TestDataFactory.getAccount();
		insert singleAccount;
	}

	@IsTest
	static void query_Test() {

		String query = 'SELECT Id FROM Account';
		Test.startTest();
		List<Account> accounts = new DatabaseProxy().query(query);
		Test.stopTest();

		System.assertEquals(1, accounts.size());
	}
}