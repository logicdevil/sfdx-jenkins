public with sharing class DatabaseProxy {

	public List<SObject> query(String query) {
		return Database.query(query);
	}

	public List<Database.UpsertResult> upsertRecords(List<SObject> records) {
		return Database.upsert(records);
	}
}