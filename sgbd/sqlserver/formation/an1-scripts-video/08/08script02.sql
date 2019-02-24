EXEC sp_configure filestream_access_level, 2
RECONFIGURE
GO
ALTER DATABASE gescom
  ADD FILEGROUP FilestreamGroup CONTAINS FILESTREAM;
GO
ALTER DATABASE gescom
  ADD FILE(
    name='gescom_images',
    filename=N'c:\gescom\images'
    )TO FILEGROUP FilestreamGroup;
GO
CREATE TABLE catalogue(
id uniqueidentifier rowguidcol not null,
article nvarchar(16),
image_art varbinary(max) filestream,
CONSTRAINT pk_catalogue PRIMARY KEY(id)
);
GO
INSERT INTO catalogue(id, article, image_art) VALUES
  (newid(),'000397',cast('image article 000397' as varbinary(max))),
  (newid(),'000432',cast('image article 000432' as varbinary(max)));