public with sharing class MapController {

	@TestVisible
	private static final Map<String, Map<String, String>> COORDINATES_FIELD_NAMES_BY_OBJECT_TYPE = new Map<String, Map<String, String>>{
			'Account' => new Map<String, String>{
					'Latitude' => 'BillingLatitude',
					'Longitude' => 'BillingLongitude'
			},
			'Contact' => new Map<String, String>{
					'Latitude' => 'MailingLatitude',
					'Longitude' => 'MailingLongitude'
			},
			'User' => new Map<String, String>{
					'Latitude' => 'Latitude',
					'Longitude' => 'Longitude'
			}
	};

	@AuraEnabled
	public static String getTomTomApiKey() {

		List<Api_Key__c> apiKeys;

		QueryBuilder queryBuilder = (QueryBuilder)ClassFactory.newInstance(QueryBuilder.class);
		DatabaseProxy databaseProxy = (DatabaseProxy)ClassFactory.newInstance(DatabaseProxy.class);

		String query = queryBuilder
				.addFrom('Api_Key__c')
				.addFields(new List<String>{'Id', 'Key__c'})
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

	@AuraEnabled
	public static String getRecordCoordinates(String recordId) {

		QueryBuilder queryBuilder = (QueryBuilder)ClassFactory.newInstance(QueryBuilder.class);
		DatabaseProxy databaseProxy = (DatabaseProxy) ClassFactory.newInstance(DatabaseProxy.class);
		String recordTypeName = Id.valueOf(recordId).getSobjectType().getDescribe().getName();
		String recordLatitudeFieldName = COORDINATES_FIELD_NAMES_BY_OBJECT_TYPE.get(recordTypeName).get('Latitude');
		String recordLongitudeFieldName = COORDINATES_FIELD_NAMES_BY_OBJECT_TYPE.get(recordTypeName).get('Longitude');
		List<SObject> records;

		String query = queryBuilder
				.addFrom(recordTypeName)
				.addFields(new Set<String>{recordLatitudeFieldName, recordLongitudeFieldName})
				.addConditions()
				.add(new QueryBuilder.CompareCondition('Id')
						.eq(recordId))
				.endConditions()
				.toString();

		try {
			records = databaseProxy.query(query);
		} catch (Exception e) {
			throw new AuraHandledException(Label.Unhandled_Error + ' ' + Label.Contact_Administrator);
		}

		if (records == null || records.isEmpty()) {
			throw new AuraHandledException(Label.Unhandled_Error + ' ' + Label.Contact_Administrator);
		}

		if (records[0].get(recordLatitudeFieldName) == null || records[0].get(recordLongitudeFieldName) == null) {
			throw new AuraHandledException(Label.Record_Has_No_Coordinates + ' (' + recordTypeName + ')');
		}

		return records[0].get(recordLatitudeFieldName) + ',' + records[0].get(recordLongitudeFieldName);
	}

	@AuraEnabled
	public static String getUserCoordinates() {

		return getRecordCoordinates(UserInfo.getUserId());
	}
}