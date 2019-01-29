public with sharing class FolderProcessor {

	private FolderWrapper folder;
	private FileWrapper emailFile;
	private ResponseEntityTest response;

	public FolderProcessor(FolderWrapper folder) {
		this.folder = folder;
	}
}