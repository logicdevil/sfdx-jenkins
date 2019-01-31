public with sharing class FolderProcessor {

	private FolderWrapper folder;
	private FileWrapper emailTypeFile;
	private ResponseWrapper response;
	private String caseId;
	private String emailTypeFileSFId;
	private Boolean isProcessed;

	public FolderProcessor(FolderWrapper folder) {
		this.isProcessed = false;
		this.folder = folder;
		this.response = new ResponseWrapper(folder.getFolderId());
	}

	public ResponseWrapper getResponseWrapper() {
		return this.response;
	}

	public String getFolderId() {
		return this.folder.getFolderId();
	}

	public List<FileWrapper> getFiles() {
		return this.folder.getFiles();
	}

	public FileWrapper getEmailFile() {
		return this.emailTypeFile;
	}

	public String getEmailTypeFileSFId() {
		return this.emailTypeFileSFId;
	}

	public void setEmailTypeFileSFId(String emailFileTypeSFId) {
		this.emailTypeFileSFId = emailFileTypeSFId;
	}

	public void setCaseId(String caseId) {
		this.caseId = caseId;
		this.response.setCaseId(caseId);
	}

	public void setCaseError(List<Database.Error> errors) {
		if (errors.isEmpty()) {
			this.handleCaseNotCreated('Unhandled error');
		} else {
			this.handleCaseNotCreated(String.valueOf(errors[0]));
		}
	}

	public void setProcessed() {
		this.isProcessed = true;
	}

	public Boolean isProcessed() {
		return this.isProcessed;
	}

	public void extractEmailTypeFile() {

		for (FileWrapper file : folder.getFiles()) {
			if (file.getType() == FolderProcessingService.EMAIL_TYPE_FILE_NAME) {
				emailTypeFile = file;
				return;
			}
		}

		this.handleEmailTypeFileMissing();
	}

	public void setEmailTypeFileError(List<Database.Error> errors) {
		if (errors.isEmpty()) {
			this.handleEntityNotCreated(emailTypeFile.getFileId(), 'Unhandled error');
		} else {
			this.handleEntityNotCreated(emailTypeFile.getFileId(), String.valueOf(errors[0]));
		}
	}

	private void handleCaseNotCreated(String errorMessage) {
		this.setFailureStatus();
		this.setProcessed();
		response.addError(folder.getFolderId(), Label.Case_Not_Created + ' Error message: ' + errorMessage);
	}

	private void handleEmailTypeFileMissing() {
		this.setPartialSuccessStatus();
		this.setProcessed();
		response.addError(folder.getFolderId(), Label.Email_Type_File_Missing);
	}

	private void handleEntityNotCreated(String entityId, String errorMessage) {
		this.setPartialSuccessStatus();
		this.setProcessed();
		response.addError(entityId, Label.File_Not_Created + ' Error message: ' + errorMessage);
	}

	private void setFailureStatus() {
		this.response.setStatus('failure');
	}

	private void setSuccessStatus() {
		this.response.setStatus('success');
	}

	private void setPartialSuccessStatus() {
		this.response.setStatus('partial success');
	}
}