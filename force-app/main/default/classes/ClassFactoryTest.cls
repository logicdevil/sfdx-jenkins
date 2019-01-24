@IsTest
private with sharing class ClassFactoryTest {

	static final String CLASS_CREATED = 'Class created';

	@IsTest
	static void setup(){

	}

	@IsTest
	static void newInstance_PrimitivesByClassName_Test() {

		System.assertEquals(false, (Boolean)ClassFactory.newInstance('Boolean'));
		System.assert(String.valueOf((Id)ClassFactory.newInstance('Id')).contains('001000000000000'));
		System.assertEquals('', (String)ClassFactory.newInstance('String'));
		System.assertEquals('Blob', ((Blob)ClassFactory.newInstance('Blob')).toString());
		System.assertEquals(Date.today(), (Date)ClassFactory.newInstance('Date'));
		System.assertEquals(Datetime.now(), (Datetime)ClassFactory.newInstance('Datetime'));
		System.assertEquals(Time.newInstance(0, 0, 0, 0), (Time)ClassFactory.newInstance('Time'));
		System.assertEquals(0, (Integer)ClassFactory.newInstance('Integer'));
		System.assertEquals(0, (Long)ClassFactory.newInstance('Long'));
		System.assertEquals(0.0, (Decimal)ClassFactory.newInstance('Decimal'));
		System.assertEquals(0.0, (Double)ClassFactory.newInstance('Double'));
	}

	@IsTest
	static void newInstance_NonPrimitivesByClassName_Test() {
		System.assertEquals(
				CLASS_CREATED,
				((ClassFactory.ClassForTestingClassFactory)ClassFactory.newInstance('ClassFactory.ClassForTestingClassFactory')).testingString
		);

	}

	@IsTest
	static void newInstance_PrimitivesByType_Test() {

		System.assertEquals(false, (Boolean)ClassFactory.newInstance(Boolean.class));
		System.assert(String.valueOf((Id)ClassFactory.newInstance(Id.class)).contains('001000000000000'));
		System.assertEquals('', (String)ClassFactory.newInstance(String.class));
		System.assertEquals('Blob', ((Blob)ClassFactory.newInstance(Blob.class)).toString());
		System.assertEquals(Date.today(), (Date)ClassFactory.newInstance(Date.class));
		System.assertEquals(Datetime.now(), (Datetime)ClassFactory.newInstance(Datetime.class));
		System.assertEquals(Time.newInstance(0, 0, 0, 0), (Time)ClassFactory.newInstance(Time.class));
		System.assertEquals(0, (Integer)ClassFactory.newInstance(Integer.class));
		System.assertEquals(0, (Long)ClassFactory.newInstance(Long.class));
		System.assertEquals(0.0, (Decimal)ClassFactory.newInstance(Decimal.class));
		System.assertEquals(0.0, (Double)ClassFactory.newInstance(Double.class));
	}

	@IsTest
	static void newInstance_NonPrimitivesByType_Test() {
		System.assertEquals(
				CLASS_CREATED,
				((ClassFactory.ClassForTestingClassFactory)ClassFactory.newInstance(ClassFactory.ClassForTestingClassFactory.class)).testingString
		);
	}

	@IsTest
	static void clearStubTypesByClassNamesMap_Test() {
		ClassFactory.stubTypesByClassNames.put('SomeClass', ClassFactory.class);
		ClassFactory.clearStubTypesByClassNamesMap();
		System.assert(ClassFactory.stubTypesByClassNames.isEmpty());
	}

	@IsTest
	static void putStubTypeByClassName_Test() {
		ClassFactory.putStubTypeByClassName('SomeClass', ClassFactory.class);
		System.assert(!ClassFactory.stubTypesByClassNames.isEmpty());
	}

	@IsTest
	static void newInstance_GetStubClass_Test() {
		ClassFactory.clearStubTypesByClassNamesMap();
		ClassFactory.putStubTypeByClassName('ClassFactory.ClassForTestingClassFactory', ClassFactory.class);
		System.assert(ClassFactory.newInstance('ClassFactory.ClassForTestingClassFactory') instanceof ClassFactory);
	}
}