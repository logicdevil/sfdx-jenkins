@IsTest
private class StackTraceParserTest {

	@TestSetup
	static void setup() {

	}

	@IsTest
	static void getMethodName_Test() {

		Test.startTest();
		String currentMethod = StackTraceParser.getMethod();
		Test.stopTest();

		System.assertEquals('getMethodName_Test', currentMethod);
	}

	@IsTest
	static void getClassName_Test() {

		Test.startTest();
		String currentClass = StackTraceParser.getClassName();
		Test.stopTest();

		System.assertEquals('StackTraceParserTest', currentClass);
	}
}