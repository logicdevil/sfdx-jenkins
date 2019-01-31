public with sharing class DatabaseProxy {

	public List<SObject> query(String query) {
		return Database.query(query);
	}

	public List<Database.UpsertResult> upsertRecords_Case(List<Case> records, Schema.SObjectField fieldName, Boolean allOrNothing) {
		return Database.upsert(records, fieldName, allOrNothing);
	}

	public List<Database.UpsertResult> upsertRecords_Custom_File(List<Custom_File__c> records, Schema.SObjectField fieldName, Boolean allOrNothing) {
		return Database.upsert(records, fieldName, allOrNothing);
	}

	public List<Database.UpsertResult> upsertRecords(List<SObject> records) {
		return Database.upsert(records);
	}

	public List<Database.UpsertResult> upsertRecords(List<SObject> records, Boolean allOrNothing) {
		return Database.upsert(records, allOrNothing);
	}
}