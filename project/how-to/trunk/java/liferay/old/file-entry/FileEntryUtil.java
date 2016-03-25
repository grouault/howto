package fr.universcience.estim.utils;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portal.kernel.util.MimeTypesUtil;
import com.liferay.portal.model.User;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.documentlibrary.model.DLFileEntry;
import com.liferay.portlet.documentlibrary.model.DLFolderConstants;
import com.liferay.portlet.documentlibrary.service.DLAppServiceUtil;
import com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil;

/**
 * Classe utilitaire pour la gestion des FileEntry.
 * @author Rouault1
 *
 */
public class FileEntryUtil {

    
    private static final Log LOGGER = LogFactory.getLog(FileEntryUtil.class);
    private static FileEntryUtil instance = null;
    
    /**
     * constructeur privé.
     * 
     */
    private FileEntryUtil() {
    }
    
    /**
     * accesseur à l'instance.
     * @return
     */
    public static FileEntryUtil getInstance() {
        if (instance == null) {
            synchronized (FileEntryUtil.class) {
                if (instance == null) {
                    instance = new FileEntryUtil();
                }
            }
        }
        return instance;
    }
    
    /**
     * Permet de sauver document en tant que FileEntry.
     * ==> RemoteService.
     * @param name
     * @param file
     * @param themeDisplay
     * @return
     * @throws PortalException
     * @throws SystemException
     * 
     * @author Rouault1
     */
    public FileEntry save(String name, File file,
            ThemeDisplay themeDisplay, ServiceContext serviceContext) throws PortalException, SystemException {
    
        FileEntry entryFile = null;
        
        // recupration du defaultRepo et defaultFolder
        final long defaultRepoId = DLFolderConstants.getDataRepositoryId(themeDisplay.getScopeGroupId(), 
          DLFolderConstants.DEFAULT_PARENT_FOLDER_ID);
        final long defaultFolderId = DLFolderConstants.DEFAULT_PARENT_FOLDER_ID;
        
        // mise a jour du service context.
        serviceContext.setSignedIn(true);
        serviceContext.setAddGroupPermissions(true);
        serviceContext.setAddGuestPermissions(true);
               
        // ajout de la nouvelle entree.
        final String fileName = file.getName();
        entryFile = DLAppServiceUtil.addFileEntry(defaultRepoId, defaultFolderId, fileName, 
                MimeTypesUtil.getContentType(file), fileName, "", "", file, serviceContext);
        final String infoMessage = "Mise a jour de la table DFileEntry [OK] - fileEntryId = " + entryFile.getFileEntryId() + " - fileName = " + fileName;
        LOGGER.info(infoMessage);
        
        return entryFile;
        
    }
     
    /**
     * Permet de creer un DLFileEntry
     * ==> LocalService.
     * @param name
     * @param file
     * @param themeDisplay
     * @param serviceContext
     * @return
     * @throws PortalException
     * @throws SystemException
     */
    public DLFileEntry saveDLFileEntry(String name, File file,
            ThemeDisplay themeDisplay, ServiceContext serviceContext) throws PortalException, SystemException {
    	
    	DLFileEntry dlEntryFile = null;
    	
        // recupration du defaultRepo et defaultFolder
        final long defaultRepoId = DLFolderConstants.getDataRepositoryId(themeDisplay.getScopeGroupId(), 
          DLFolderConstants.DEFAULT_PARENT_FOLDER_ID);
        final long defaultFolderId = DLFolderConstants.DEFAULT_PARENT_FOLDER_ID;
        
        // mise a jour du service context.
        serviceContext.setSignedIn(true);
        serviceContext.setAddGroupPermissions(true);
        serviceContext.setAddGuestPermissions(true);
    	
        // ajout de la nouvelle entree.
        final String fileName = file.getName();        
        dlEntryFile = DLFileEntryLocalServiceUtil.addFileEntry(
        		themeDisplay.getDefaultUserId(), 
        		themeDisplay.getScopeGroupId(), 
        		defaultRepoId, 
        		defaultFolderId, 
        		fileName, 
        		MimeTypesUtil.getContentType(file), 
        		fileName, // title. 
        		"description", 
        		"changelog", 
        		0, 
        		null, // fieldsMap 
        		file, 
        		null, 
        		file.length(), 
        		serviceContext);
        
        final String infoMessage = "Mise a jour de la table DFileEntry [OK] - DLFileEntryId = " + dlEntryFile.getFileEntryId() + " - DLFileName = " + fileName;
        LOGGER.info(infoMessage);
        
    	return dlEntryFile;
    }
    
    /**
     * Permet de supprimer un DLFileEntry
     * @param fileEntryId
     * @throws PortalException
     * @throws SystemException
     */
    public void deleteDLFileEntry(final long fileEntryId) throws PortalException, SystemException {
        DLFileEntryLocalServiceUtil.deleteFileEntry(fileEntryId);
        LOGGER.info("Mise a jour de la table DFileEntry [OK] - Suppresssion du file DLFileEntry : " + fileEntryId);
    }
    
    /**
     * Permet de supprimer un FileEntry.
     * @param fileEntryId
     * @throws PortalException
     * @throws SystemException
     */
    public void delete(final long fileEntryId) throws PortalException, SystemException {
        DLAppServiceUtil.deleteFileEntry(fileEntryId);
        LOGGER.info("Mise a jour de la table DFileEntry [OK] - Suppresssion du file entry : " + fileEntryId);
    }
    
}
