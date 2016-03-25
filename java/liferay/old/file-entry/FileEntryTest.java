package fr.universcience.estim.agenda.utils;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portal.kernel.repository.model.Folder;
import com.liferay.portal.kernel.util.MimeTypesUtil;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.documentlibrary.model.DLFolderConstants;
import com.liferay.portlet.documentlibrary.service.DLAppServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFolderLocalServiceUtil;
import com.liferay.portlet.documentlibrary.util.DLUtil;

public class ImageUtilsTest {

	private static final Log LOGGER = LogFactory.getLog(ImageUtilsTest.class);
	
	public static FileEntry saveFile (String name, File file,
			ThemeDisplay themeDisplay) throws PortalException, SystemException {
	
		FileEntry fe = DLAppServiceUtil.getFileEntry(41501);
		try {
			String fotoThumbUrl = DLUtil.getThumbnailSrc(fe, null,themeDisplay);
			LOGGER.debug("Photo : " + fotoThumbUrl);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		FileEntry entryFile = null;
		long defaultRepoId = DLFolderConstants.getDataRepositoryId(themeDisplay.getScopeGroupId(), 
		  DLFolderConstants.DEFAULT_PARENT_FOLDER_ID);
		ServiceContext serviceContext = new ServiceContext();
		serviceContext.setSignedIn(true);
		serviceContext.setAddGroupPermissions(true);
		serviceContext.setAddGuestPermissions(true);
		
		Folder folder = null;
		try {
			folder = (Folder)DLFolderLocalServiceUtil.getFolder(defaultRepoId);
		} catch (Exception e) { 
			LOGGER.error(e.getMessage());
		}
		long defaultFolderId = DLFolderConstants.DEFAULT_PARENT_FOLDER_ID;
		long folderId = (folder != null ? folder.getFolderId() : defaultFolderId);
		String fileName = file.getName();
		entryFile = DLAppServiceUtil.addFileEntry(defaultRepoId, folderId, fileName, MimeTypesUtil.getContentType(file), fileName, "", "", file, serviceContext);
		return entryFile;
		
	}
	
}
