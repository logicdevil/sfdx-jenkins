public with sharing class MapController {

	@TestVisible
	private static QueryBuilder queryBuilder = new QueryBuilder();
	@TestVisible
	private static DatabaseProxy databaseProxy = new DatabaseProxy();

	@AuraEnabled
	public static String getTomTomApiKey() {

		List<Api_Key__c> apiKeys;
		String query = queryBuilder
				.qbFrom('Api_Key__c')
				.qbFields(new List<String>{'Id', 'Key__c'})
				.toString();

		try {
			apiKeys = databaseProxy.query(query);
		} catch (Exception e) {
			throw new AuraHandledException(Label.Unhandled_Error + ' ' + Label.Contact_Administrator);
		}

		if (apiKeys == null || apiKeys.isEmpty() || String.isBlank(apiKeys[0].Key__c)) {
			throw new AuraHandledException(Label.Api_Key_Not_Found + ' ' + Label.Contact_Administrator);
		}

		return apiKeys[0].Key__c;
	}
}