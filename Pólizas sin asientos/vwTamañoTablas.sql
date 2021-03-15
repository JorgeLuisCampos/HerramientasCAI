USE [cspCursoPolizas]
GO

/****** Object:  View [dbo].[zRTTAMAÑOTABLAS]    Script Date: 15/03/2021 05:21:23 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Tamaño de las Tablas por Base de datos
CREATE VIEW [dbo].[zRTTAMAÑOTABLAS] AS
SELECT 
    'Tot' AS Tot,
    t.NAME AS Tabla,
	SUBSTRING(t.NAME,1,3) AS TipoTab,
    s.Name AS SchemaName,
    p.rows Registros,
    SUM(a.total_pages) * 8 AS TotalEspKB, 
    CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalEspMB,
    SUM(a.used_pages) * 8 AS EspacioUsKB, 
    CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS EspacioUsMB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS EspacioNoUsKB,
    CAST(ROUND(((SUM(a.total_pages) - SUM(a.used_pages)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS EspacioNoUsMB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, s.Name, p.Rows

GO