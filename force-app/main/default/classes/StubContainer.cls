@IsTest
public with sharing class StubContainer {

	public class MapControllerTest_DatabaseProxyStub implements System.StubProvider {

		String testMethodName;

		public MapControllerTest_DatabaseProxyStub(String testMethodName) {
			this.testMethodName = testMethodName;
		}

		public Object handleMethodCall(Object stubbedObject, String stubbedMethodName,
				Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames,
				List<Object> listOfArgs) {

			if (stubbedMethodName == 'query') {
				if (testMethodName.contains('getTomTomApiKey_UnhandledError')) {
					throw new QueryException();
				}
				if (testMethodName.contains('getTomTomApiKey_KeyNotFound')) {
					return new List<Api_Key__c>();
				}
				if (testMethodName.contains('getTomTomApiKey_Positive')) {
					return new List<Api_Key__c>{
							new Api_Key__c(Key__c = 'TestApiKey')
					};
				}
				if (testMethodName.contains('getRecordCoordinates_Positive')) {
					Account singleAccount = TestDataFactory.getAccount();
					singleAccount.put(MapController.COORDINATES_FIELD_NAMES_BY_OBJECT_TYPE.get('Account').get('Latitude'), Decimal.valueOf(MapControllerTest.EXPECTED_LATITUDE));
					singleAccount.put(MapController.COORDINATES_FIELD_NAMES_BY_OBJECT_TYPE.get('Account').get('Longitude'), Decimal.valueOf(MapControllerTest.EXPECTED_LONGITUDE));
					return new List<Account>{
							singleAccount
					};
				}
				if (testMethodName.contains('getRecordCoordinates_HasNoAddress')) {
					Account singleAccount = TestDataFactory.getAccount();
					return new List<Account>{
							singleAccount
					};
				}
				if (testMethodName.contains('getRecordCoordinates_RecordDoesNotExist')) {
					return new List<Account>();
				}
				if (testMethodName.contains('getRecordCoordinates_UnhandledError')) {
					throw new QueryException();
				}
				if (testMethodName.contains('getUserCoordinates')) {
					User singleUser = TestDataFactory.getUser();
					singleUser.put(MapController.COORDINATES_FIELD_NAMES_BY_OBJECT_TYPE.get('User').get('Latitude'), Decimal.valueOf(MapControllerTest.EXPECTED_LATITUDE));
					singleUser.put(MapController.COORDINATES_FIELD_NAMES_BY_OBJECT_TYPE.get('User').get('Longitude'), Decimal.valueOf(MapControllerTest.EXPECTED_LONGITUDE));
					return new List<User>{
							singleUser
					};
				}
			}

			return null;
		}
	}
}