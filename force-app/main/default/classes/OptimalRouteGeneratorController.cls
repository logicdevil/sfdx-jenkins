public with sharing class OptimalRouteGeneratorController {

	@AuraEnabled
	public static Map<Id, SObject> getRecordsMap(String sObjectName) {

		QueryBuilder qBuilder = (QueryBuilder) ClassFactory.newInstance(QueryBuilder.class);
		DatabaseProxy dProxy = (DatabaseProxy) ClassFactory.newInstance(DatabaseProxy.class);
		List<SObject> records;
		String query = qBuilder
				.addFrom(sObjectName)
				.addField('Id')
				.addField('Name')
				.addField('Phone')
				.addField('Email')
				.setLimit(10)
				.toString();

		try {
			records = dProxy.query(query);
		} catch (Exception e) {
			throw new AuraHandledException(Label.Unhandled_Error + ' ' + Label.Contact_Administrator);
		}

		if (records == null || records.isEmpty()) {
			throw new AuraHandledException(Label.Unhandled_Error + ' ' + Label.Contact_Administrator);
		}

		return new Map<Id, SObject>(records);
	}
}