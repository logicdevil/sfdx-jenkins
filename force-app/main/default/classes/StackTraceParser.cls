public with sharing class StackTraceParser {

	public static String getClassName(String stackTrace) {
		if (stackTrace.startsWith('Class.'))
			stackTrace = stackTrace.substringAfter('Class.');
		return stackTrace.substringBefore(':').substringBeforeLast('.');
	}
	public static String getMethod(String line)
	{
		return line.substringBefore(':').substringAfterLast('.');
	}
	public static String getClassName()
	{
		return getClassName(new DmlException().getStackTraceString().substringAfter('\n'));
	}
	public static String getMethod()
	{
		return getMethod(new DmlException().getStackTraceString().substringAfter('\n'));
	}
}