public with sharing class MapService {

	@future
	public static void fillGeolocationOnAccounts(Set<String> accountsIds) {

		String query =  new QueryBuilder('Account')
				.addField('BillingStreet')
				.addField('BillingCity')
				.addField('BillingCountry')
				.addField('BillingLongitude')
				.addField('BillingLatitude')
				.addField('BillingPostalCode')
				.addField('BillingState')
				.addConditions()
				.add(new QueryBuilder.InCondition('Id')
						.inCollection(accountsIds)
				)
				.endConditions()
				.toString();

		List<Account> accounts = new DatabaseProxy().query(query);

	}
}