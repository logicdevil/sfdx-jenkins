public with sharing class ClassFactory {

//	public static Map<String, Type> stubTypesBy

	public static Object newInstance(Type typeOfClass) {

		return typeOfClass.newInstance();
	}

	public static Object newInstance(String fullNameOfClass) {

		return Type.forName(fullNameOfClass).newInstance();
	}

	public static Object newInstance(Object instanceOfClass) {

		Object result = getPrimitive(instanceOfClass);

		if(result == null) {
			result = getNonPrimitive(instanceOfClass);
		}

		return result;
	}

	private static Object getNonPrimitive(Object instanceOfClass) {

		String className;

		try {
			instanceOfClass = (ClassFactory.InvalidClass) instanceOfClass;
		} catch (Exception e) {
			className = e.getMessage().substringBetween(' type ', ' to ');
		}

		return Type.forName(className).newInstance();
	}

	private static Object getPrimitive(Object instanceOfClass) {

		if(instanceOfClass instanceof Boolean)            return false;
		if(instanceOfClass instanceof Id)                 return Id.valueOf('001000000000000');
		if(instanceOfClass instanceof String)             return '';
		if(instanceOfClass instanceof Blob)               return 'Blob';
		if(instanceOfClass instanceof Date)               return Date.today();
		if(instanceOfClass instanceof Datetime)           return Datetime.now();
		if(instanceOfClass instanceof Time)               return Time.newInstance(0,0,0,0);
		if(instanceOfClass instanceof Integer)            return (Integer)0;
		if(instanceOfClass instanceof Long)               return (Long)0;
		if(instanceOfClass instanceof Decimal)            return (Decimal)0.0;
		if(instanceOfClass instanceof Double)             return (Double)0.0;
		return null;
	}

	private class InvalidClass {

	}
}