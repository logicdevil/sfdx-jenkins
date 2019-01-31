public with sharing class ResponseWrapper {

	public String folder_id;
	public String status;
	public String case_id;
	public List<InnerResponseWrapper> errors;

	public ResponseWrapper(String folder_id) {
		this.folder_id = folder_id;
		this.errors = new List<InnerResponseWrapper>();
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCaseId() {
		return this.case_id;
	}

	public void setCaseId(String case_id) {
		this.case_id = case_id;
	}

	public List<InnerResponseWrapper> getErrors() {
		return this.errors;
	}

	public void addError(String entityId, String errorMessage) {
		this.errors.add(new InnerResponseWrapper(entityId, errorMessage));
	}

//	public void prepareResponse() {
//		this.setStatus();
//	}
//
//	private void setStatus() {
//
//		if(case_id == null) {
//			status = 'failure';
//		} else if(errors.isEmpty()) {
//			status = 'success';
//		} else {
//			status = 'partial success';
//		}
//	}
//
	public class InnerResponseWrapper {

		public String entity_id;
		public String message;

		public InnerResponseWrapper(String entityId, String errorMessage) {
			this.entity_id = entityId;
			this.message = errorMessage;
		}
	}
}