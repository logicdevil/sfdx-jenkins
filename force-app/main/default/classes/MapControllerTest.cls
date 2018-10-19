@IsTest
private class MapControllerTest {

	static Integer numOfObjectsToBeReturned;

	@TestSetup
	static void setup() {

	}

	@IsTest
	static void getTomTomApiKey_Positive_Test() {

		MapController.queryBuilder = (QueryBuilder) Test.createStub(QueryBuilder.class, new QueryBuilderStub());
		MapController.databaseProxy = (DatabaseProxy) Test.createStub(DatabaseProxy.class, new DatabaseProxyStub());
		MapControllerTest.numOfObjectsToBeReturned = 1;

		Test.startTest();
		String apiKey = MapController.getTomTomApiKey();
		Test.stopTest();

		System.assertEquals('TestApiKey', apiKey);
	}

	@IsTest
	static void getTomTomApiKey_KeyNotFound_Test() {

		MapController.queryBuilder = (QueryBuilder) Test.createStub(QueryBuilder.class, new QueryBuilderStub());
		MapController.databaseProxy = (DatabaseProxy) Test.createStub(DatabaseProxy.class, new DatabaseProxyStub());
		MapControllerTest.numOfObjectsToBeReturned = 0;
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

		MapController.queryBuilder = (QueryBuilder) Test.createStub(QueryBuilder.class, new QueryBuilderStub());
		MapController.databaseProxy = (DatabaseProxy) Test.createStub(DatabaseProxy.class, new DatabaseProxyStub());
		MapControllerTest.numOfObjectsToBeReturned = -1;
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

	public class QueryBuilderStub implements System.StubProvider {

		public Object handleMethodCall(Object stubbedObject, String stubbedMethodName,
				Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames,
				List<Object> listOfArgs) {

			if (stubbedMethodName == 'addSObjectName') {
				return stubbedObject;
			}
			if (stubbedMethodName == 'addFields') {
				return stubbedObject;
			}
			if (stubbedMethodName == 'getQuery') {
				return 'SELECT Id, Key__c FROM Api_Key__c';
			}

			return null;
		}
	}

	public class DatabaseProxyStub implements System.StubProvider {

		public Object handleMethodCall(Object stubbedObject, String stubbedMethodName,
				Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames,
				List<Object> listOfArgs) {

			if (stubbedMethodName == 'query') {
				if (MapControllerTest.numOfObjectsToBeReturned == -1) {
					throw new QueryException();
				}
				if (MapControllerTest.numOfObjectsToBeReturned == 0) {
					return new List<Api_Key__c>();
				}
				if(MapControllerTest.numOfObjectsToBeReturned == 1) {
					return new List<Api_Key__c>{new Api_Key__c(Key__c='TestApiKey')};
				}
			}

			return null;
		}
	}
}