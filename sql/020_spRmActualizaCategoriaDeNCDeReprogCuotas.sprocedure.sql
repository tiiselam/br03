
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = 'dbo'
     AND SPECIFIC_NAME = 'spRmActualizaCategoriaDeNCCuotasProgramadas' 
)
   DROP PROCEDURE dbo.spRmActualizaCategoriaDeNCCuotasProgramadas;
GO

--Prop�sito. Actualiza la categor�a de una NC generada por la reprogramaci�n de cuotas para que pueda ser desaplicada si fuera necesario.
--24/7/19 jcf Creaci�n
--
CREATE PROCEDURE dbo.spRmActualizaCategoriaDeNCCuotasProgramadas
AS
--select top 100 CATEGORY, *
update r set CATEGORY = 99
from RVLSP014 r	--rvlrmTrxRelOPEN
inner join rm20101 rmopen
	on rmopen.DOCNUMBR = r.DOCNUMBR
	and rmopen.RMDTYPAL = r.RMDTYPAL
	and rmopen.CUSTNMBR = r.CUSTNMBR
where r.RMDTYPAL = 7
and rmopen.bchsourc = 'XRM_Sales'
and r.CATEGORY = 2	--nc

go

IF (@@Error = 0) PRINT 'Creaci�n exitosa de: spRmActualizaCategoriaDeNCCuotasProgramadas'
ELSE PRINT 'Error en la creaci�n de: spRmActualizaCategoriaDeNCCuotasProgramadas'
GO

----------------------------------------------------------------------------------------------

