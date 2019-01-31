public with sharing class FileWrapper {

	public String file_id;
	public String type;
	public Boolean is_subject;
	public Boolean is_body;
	public Boolean is_attachment;

	public String getType() {
		return this.type;
	}

	public String getFileId() {
		return this.file_id;
	}
}