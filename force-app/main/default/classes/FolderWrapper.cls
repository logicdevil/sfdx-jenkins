public with sharing class FolderWrapper {

	public String folder_id;
	public List<FileWrapper> files;

	public String getFolderId() {
		return folder_id;
	}

	public List<FileWrapper> getFiles() {
		return files;
	}
}