public with sharing class AccountService {

	private List<Account> newList;
	private List<Account> oldList;
	private Map<Id, Account> newMap;
	private Map<Id, Account> oldMap;

	public AccountService(List<Account> newList, List<Account> oldList, Map<Id, Account> newMap, Map<Id, Account> oldMap) {
		this.newList = newList;
		this.oldList = oldList;
		this.newMap = newMap;
		this.oldMap = oldMap;
	}

	public List<Account> fillGeolocation() {

		return null;
	}
}