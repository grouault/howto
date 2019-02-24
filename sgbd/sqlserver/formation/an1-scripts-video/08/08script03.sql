DECLARE @p GEOMETRY;
SET @p='Polygon ((0 0, 1 4 , 1 1, 2 4, 3 1,0 0))'
SELECT @p
GO
DECLARE @triangle GEOMETRY;
DECLARE @segment GEOMETRY
SET @segment='LineString(10 10, 50 10)'
SET @triangle='Polygon((0 0, 5 7, 5 0, 0 0))'
SELECT @triangle.ShortestLineTo(@segment).STAsText();
GO
UPDATE CLIENTS
  SET gps=geography::STGeomFromText('POINT(48.87390323741282 2.295413017272944)',4807)
  WHERE numero=6;
