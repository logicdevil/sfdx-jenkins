@IsTest
public class MapControllerTest {

	static final String RECORD_ID_ACCOUNT = '001000000000000';
	static final String EXPECTED_COORDINATES = '50.00000,50.00000';
	@TestVisible
	static final String EXPECTED_LATITUDE = '50.00000';
	@TestVisible
	static final String EXPECTED_LONGITUDE = '50.00000';

	@TestSetup
	static void setup() {

	}

	@IsTest
	static void getTomTomApiKey_Positive_Test() {

		ClassFactory.clearStubTypesByClassNamesMap();
		ClassFactory.putStubTypeByClassName(
				'QueryBuilder',
				new QueryBuilder().buildStub().addStubToString('SELECT Id, Key__c FROM Api_Key__c').applyStub()
		);
		ClassFactory.putStubTypeByClassName(
				'DatabaseProxy',
				(DatabaseProxy) Test.createStub(
						DatabaseProxy.class,
						new StubContainer.MapControllerTest_DatabaseProxyStub(StackTraceParser.getMethod())
				)
		);

		Test.startTest();
		String apiKey = MapController.getTomTomApiKey();
		Test.stopTest();

		System.assertEquals('TestApiKey', apiKey);
	}

	@IsTest
	static void getTomTomApiKey_KeyNotFound_Test() {

		ClassFactory.clearStubTypesByClassNamesMap();
		ClassFactory.putStubTypeByClassName(
				'QueryBuilder',
				new QueryBuilder().buildStub().addStubToString('SELECT Id, Key__c FROM Api_Key__c').applyStub()
		);
		ClassFactory.putStubTypeByClassName(
				'DatabaseProxy',
				(DatabaseProxy) Test.createStub(
						DatabaseProxy.class,
						new StubContainer.MapControllerTest_DatabaseProxyStub(StackTraceParser.getMethod())
				)
		);

		Boolean exceptionWasThrown = false;

		Test.startTest();
		try {
			String apiKey = MapController.getTomTomApiKey();
		} catch (AuraHandledException e) {
			exceptionWasThrown = true;
			System.assertEquals('System.AuraHandledException', e.getTypeName());
		}
		Test.stopTest();

		System.assert(exceptionWasThrown);
	}

	@IsTest
	static void getTomTomApiKey_UnhandledError_Test() {

		ClassFactory.clearStubTypesByClassNamesMap();
		ClassFactory.putStubTypeByClassName(
				'QueryBuilder',
				new QueryBuilder().buildStub().addStubToString('SELECT Id, Key__c FROM Api_Key__c').applyStub()
		);
		ClassFactory.putStubTypeByClassName(
				'DatabaseProxy',
				(DatabaseProxy) Test.createStub(
						DatabaseProxy.class,
						new StubContainer.MapControllerTest_DatabaseProxyStub(StackTraceParser.getMethod())
				)
		);

		Boolean exceptionWasThrown = false;

		Test.startTest();
		try {
			String apiKey = MapController.getTomTomApiKey();
		} catch (AuraHandledException e) {
			exceptionWasThrown = true;
			System.assertEquals('System.AuraHandledException', e.getTypeName());
		}
		Test.stopTest();

		System.assert(exceptionWasThrown);
	}

	@IsTest
	static void getRecordCoordinates_Positive_Test() {

		ClassFactory.clearStubTypesByClassNamesMap();
		ClassFactory.putStubTypeByClassName(
				'QueryBuilder',
				new QueryBuilder().buildStub().addStubToString('SELECT BillingLongitude, BillingLatitude FROM Account WHERE Id = \'' + RECORD_ID_ACCOUNT + '\'').applyStub()
		);
		ClassFactory.putStubTypeByClassName(
				'DatabaseProxy',
				(DatabaseProxy) Test.createStub(
						DatabaseProxy.class,
						new StubContainer.MapControllerTest_DatabaseProxyStub(StackTraceParser.getMethod())
				)
		);

		Test.startTest();
		String coordinates = MapController.getRecordCoordinates(RECORD_ID_ACCOUNT);
		Test.stopTest();

		System.assertEquals(EXPECTED_COORDINATES, coordinates);
	}

	@IsTest
	static void getRecordCoordinates_HasNoAddress_Test() {

		ClassFactory.clearStubTypesByClassNamesMap();
		ClassFactory.putStubTypeByClassName(
				'QueryBuilder',
				new QueryBuilder().buildStub().addStubToString('SELECT BillingLongitude, BillingLatitude FROM Account WHERE Id = \'' + RECORD_ID_ACCOUNT + '\'').applyStub()
		);
		ClassFactory.putStubTypeByClassName(
				'DatabaseProxy',
				(DatabaseProxy) Test.createStub(
						DatabaseProxy.class,
						new StubContainer.MapControllerTest_DatabaseProxyStub(StackTraceParser.getMethod())
				)
		);

		Boolean exceptionWasThrown = false;

		Test.startTest();
		try {
			String coordinates = MapController.getRecordCoordinates(RECORD_ID_ACCOUNT);
		} catch (AuraHandledException e) {
			exceptionWasThrown = true;
			System.assertEquals('System.AuraHandledException', e.getTypeName());
		}
		Test.stopTest();

		System.assert(exceptionWasThrown);
	}

	@IsTest
	static void getRecordCoordinates_RecordDoesNotExist_Test() {

		ClassFactory.clearStubTypesByClassNamesMap();
		ClassFactory.putStubTypeByClassName(
				'QueryBuilder',
				new QueryBuilder().buildStub().addStubToString('SELECT BillingLongitude, BillingLatitude FROM Account WHERE Id = \'' + RECORD_ID_ACCOUNT + '\'').applyStub()
		);
		ClassFactory.putStubTypeByClassName(
				'DatabaseProxy',
				(DatabaseProxy) Test.createStub(
						DatabaseProxy.class,
						new StubContainer.MapControllerTest_DatabaseProxyStub(StackTraceParser.getMethod())
				)
		);

		Boolean exceptionWasThrown = false;

		Test.startTest();
		try {
			String coordinates = MapController.getRecordCoordinates(RECORD_ID_ACCOUNT);
		} catch (AuraHandledException e) {
			exceptionWasThrown = true;
			System.assertEquals('System.AuraHandledException', e.getTypeName());
		}
		Test.stopTest();

		System.assert(exceptionWasThrown);
	}

	@IsTest
	static void getRecordCoordinates_UnhandledError_Test() {

		ClassFactory.clearStubTypesByClassNamesMap();
		ClassFactory.putStubTypeByClassName(
				'QueryBuilder',
				new QueryBuilder().buildStub().addStubToString('SELECT BillingLongitude, BillingLatitude FROM Account WHERE Id = \'' + RECORD_ID_ACCOUNT + '\'').applyStub()
		);
		ClassFactory.putStubTypeByClassName(
				'DatabaseProxy',
				(DatabaseProxy) Test.createStub(
						DatabaseProxy.class,
						new StubContainer.MapControllerTest_DatabaseProxyStub(StackTraceParser.getMethod())
				)
		);

		Boolean exceptionWasThrown = false;

		Test.startTest();
		try {
			String coordinates = MapController.getRecordCoordinates(RECORD_ID_ACCOUNT);
		} catch (AuraHandledException e) {
			exceptionWasThrown = true;
			System.assertEquals('System.AuraHandledException', e.getTypeName());
		}
		Test.stopTest();

		System.assert(exceptionWasThrown);
	}

	@IsTest
	static void getUserCoordinates_Test() {

		ClassFactory.clearStubTypesByClassNamesMap();
		ClassFactory.putStubTypeByClassName(
				'QueryBuilder',
				new QueryBuilder().buildStub().addStubToString('SELECT Longitude, Latitude FROM User WHERE Id = \'' + UserInfo.getUserId() + '\'').applyStub()
		);
		ClassFactory.putStubTypeByClassName(
				'DatabaseProxy',
				(DatabaseProxy) Test.createStub(
						DatabaseProxy.class,
						new StubContainer.MapControllerTest_DatabaseProxyStub(StackTraceParser.getMethod())
				)
		);

		Test.startTest();
		String coordinates = MapController.getUserCoordinates();
		Test.stopTest();

		System.assertEquals(EXPECTED_COORDINATES, coordinates);
	}
}