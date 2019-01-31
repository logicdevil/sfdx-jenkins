public with sharing class FolderProcessingService {

	public static final String EMAIL_TYPE_FILE_NAME = 'Email';

	private RecordType recordType;
	private String responseText;

	public FolderProcessingService() {
		this.recordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Test_RT' LIMIT 1][0];
	}

	public String processRequestBody(String requestBody) {

		try {

			List<FolderWrapper> folderWrappers = (List<FolderWrapper>) JSON.deserialize(requestBody, List<FolderWrapper>.class);
			List<FolderProcessor> folderProcessors = this.getFolderProcessors(folderWrappers);
			List<FolderProcessor> processedFolders = new List<FolderProcessor>();

			folderProcessors = this.createCases(folderProcessors);
			folderProcessors = this.filterProcessedFolders(folderProcessors, processedFolders);
			if(folderProcessors.isEmpty()) {
				this.prepareResponse(processedFolders);
			}

			folderProcessors = this.extractEmailTypeFiles(folderProcessors);
			folderProcessors = this.filterProcessedFolders(folderProcessors, processedFolders);
			if(folderProcessors.isEmpty()) {
				this.prepareResponse(processedFolders);
			}

			folderProcessors = this.createEmailFiles(folderProcessors);
			folderProcessors = this.filterProcessedFolders(folderProcessors, processedFolders);
			if(folderProcessors.isEmpty()) {
				this.prepareResponse(processedFolders);
			}



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
		} catch (JSONException jsonException) {
			return this.processParsingError();
		}

		return null;// this.buildResponseJSON();
	}

	private List<FolderProcessor> createCases(List<FolderProcessor> folderProcessors) {

		List<Case> cases = new List<Case>();

		for(FolderProcessor folderProcessor : folderProcessors) {
			cases.add(this.createCase(folderProcessor));
		}

		DatabaseProxy databaseProxy = (DatabaseProxy) ClassFactory.newInstance(DatabaseProxy.class);
		List<Database.UpsertResult> results = databaseProxy.upsertRecords_Case(cases, Case.External_Id__c, false);

		for (Integer i = 0; i < results.size(); i++) {
			if(results[i].success) {
				folderProcessors[i].setCaseId(results[i].getId());
			} else {
				folderProcessors[i].setCaseError(results[i].getErrors());
			}
		}

		return folderProcessors;
	}

	private Case createCase(FolderProcessor folderProcessor) {

		Case singleCase = new Case();
		singleCase.External_Id__c = folderProcessor.getFolderId();
		singleCase.Status = 'New';
		singleCase.RecordTypeId = recordType.Id;
		return singleCase;
	}

	private List<FolderProcessor> getFolderProcessors(List<FolderWrapper> folders) {

		List<FolderProcessor> processors = new List<FolderProcessor>();
		for(FolderWrapper folder : folders) {
			processors.add(new FolderProcessor(folder));
		}
		return processors;
	}

	private List<FolderProcessor> filterProcessedFolders(List<FolderProcessor> folderProcessors, List<FolderProcessor> processedFolders) {

		List<FolderProcessor> notProcessedFolders = new List<FolderProcessor>();

		for(FolderProcessor processor : folderProcessors) {
			if(processor.isProcessed()) {
				processedFolders.add(processor);
			} else {
				notProcessedFolders.add(processor);
			}
		}
		return notProcessedFolders;
	}

	private List<FolderProcessor> extractEmailTypeFiles(List<FolderProcessor> folderProcessors) {

		for(FolderProcessor processor : folderProcessors) {
			processor.extractEmailTypeFile();
		}
		return folderProcessors;
	}

	private List<FolderProcessor> createEmailFiles(List<FolderProcessor> folderProcessors) {

		List<Custom_File__c> files = new List<Custom_File__c>();

		for(FolderProcessor processor : folderProcessors) {
			files.add(this.createFile(processor.getEmailFile()));
		}

		DatabaseProxy databaseProxy = (DatabaseProxy) ClassFactory.newInstance(DatabaseProxy.class);
		List<Database.UpsertResult> results = databaseProxy.upsertRecords_Custom_File(files, Custom_File__c.External_Id__c, false);

		for (Integer i = 0; i < results.size(); i++) {
			if(results[i].isSuccess()) {
				folderProcessors[i].setEmailTypeFileSFId(results[i].getId());
			} else {
				folderProcessors[i].setEmailTypeFileError(results[i].getErrors());
			}
		}

		return folderProcessors;
	}

	private Custom_File__c createFile(FileWrapper fileWrapper) {

		Custom_File__c file = new Custom_File__c();
		file.Type__c = fileWrapper.getType();
		file.External_Id__c = fileWrapper.getFileId();
		return file;
	}

	private void prepareResponse(List<FolderProcessor> folderProcessors) {

	}

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
	private String processParsingError() {
		return Label.Parsing_Error;
	}
}