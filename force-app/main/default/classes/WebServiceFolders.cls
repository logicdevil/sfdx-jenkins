@RestResource(urlMapping='/folders')
global with sharing class WebServiceFolders {

	@HttpPut
	global static void doPut() {

		RestRequest request = RestContext.request;
		String requestBody = request.requestBody.toString();

		FolderProcessingService service = (FolderProcessingService) ClassFactory.newInstance(FolderProcessingService.class);
		String result = service.processRequestBody(requestBody);

		RestResponse response = RestContext.response;
		response.responseBody = Blob.valueOf(result);
//		/*todo: set status if the response to 503 if json parsing fails*/
	}
}