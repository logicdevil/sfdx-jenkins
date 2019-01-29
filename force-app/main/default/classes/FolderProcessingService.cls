public with sharing class FolderProcessingService {

//	Map<String, String> errorsByEntityIds;
//	Map<String, ResponseEntityTest> responsesByFoldersIds;
//	RecordType recordType;
//
//	public FolderProcessingService() {
//
//		this.errorsByEntityIds = new Map<String, String>();
//		this.response = new List<ResponseEntityTest>();
//		this.recordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Test_RT' LIMIT 1][0];
//	}
//
//	public String processRequestBody(String requestBody) {
//
//		try {
//
//			List<FolderEntityTest> folders = (List<FolderEntityTest>) JSON.deserialize(requestBody, List<FolderEntityTest>.class);
//			Map<String, FolderEntityTest> foldersByIds = new Map<String, FolderEntityTest>();
//			List<Id> casesIds = this.createCases(folders);
//
//			if(casesIds.size() != folders.size()) {
//				/*todo: do smth*/
//			}
//
//			for (Integer i = 0; i < folders.size(); i++) {
//
//				FolderEntityTest singleFolder = folders[i];
//				responsesByFoldersIds.put(singleFolder.folder_id, this.processFolder(singleFolder, casesIds[i]));
//
//				if(casesIds[i] != null) {
//					foldersByIds.put(singleFolder.folder_id, singleFolder);
//				}
//			}
//
//			List<FileEntityTest> emailFiles = new List<FileEntityTest>();
//
//			for (String folderId : foldersByIds.keySet()) {
//
//				FolderEntityTest singleFolder = foldersByIds.get(folderId);
//				FileEntityTest emailFile = null;
//
//				for(FileEntityTest fileEntityTest : singleFolder.files) {
//					if(fileEntityTest.type.equalsIgnoreCase('Email')) {
//						emailFile = fileEntityTest;
//						break;
//					}
//				}
//
//				if(emailFile == null) {
//					processMissingEmailTypeFileError(folderId);
//				} else {
//					emailFiles.add(emailFile);
//				}
//			}
//
//
//
//		} catch (JSONException jsonException) {
//			this.processParsingError();
//		}
//
//		return this.buildResponseJSON();
//	}
//
//	private List<Id> createCases(List<FolderEntityTest> folders) {
//
//		List<Case> cases = new List<Case>();
//		List<Id> casesIds = new List<Id>();
//
//		for(FolderEntityTest folder : folders) {
//			cases.add(this.createCase(folder));
//		}
//
//		List<Database.UpsertResult> results = DatabaseProxy.upsertRecords(cases);
//		for (Integer i = 0; i < results.size(); i++) {
//			if(results[i].success) {
//				casesIds.add(results[i].id);
//			} else {
//				casesIds.add(null);
//			}
//		}
//
//		return casesIds;
//	}
//
//	private Case createCase(FolderEntityTest folder) {
//
//		Case singleCase = new Case();
//		singleCase.External_Id__c = folder.folder_id;
//		singleCase.Status = 'New';
//		singleCase.RecordTypeId = recordType.Id;
//		return singleCase;
//	}
//
//	private ResponseEntityTest processFolder(FolderEntityTest folder, String caseId) {
//
//		Map<String, String> folderLevelErrorsByEntityIds = new Map<String, String>();
//		return new ResponseEntityTest(folder.folder_id, caseId);
//	}
//
//	private String buildResponseJSON() {
//
//		if(errorsByEntityIds.get('ParsingError') == null) {
//			return '{ "message":"' + errorsByEntityIds.get('ParsingError') + '"';
//		}
//
//		for(ResponseEntityTest singleResponse : response) {
//			singleResponse.prepareResponse();
//		}
//
//		return JSON.serialize(response);
//	}
//
//	private void processMissingEmailTypeFileError(String entityId) {
//		this.responsesByFoldersIds.get(entityId).addError(new ResponseEntityTest.ResponseFileEntityTest(entityId, Label.Missing_Email_Type_Error));
//	}
//
//	private void processParsingError() {
//		errorsByEntityIds.put('ParsingError', Label.Parsing_Error);
//	}
}