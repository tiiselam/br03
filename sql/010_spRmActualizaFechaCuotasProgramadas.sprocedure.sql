IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = 'dbo'
     AND SPECIFIC_NAME = 'spRmActualizaFechaCuotasProgramadas' 
)
   DROP PROCEDURE dbo.spRmActualizaFechaCuotasProgramadas;
GO

--Propósito. Actualiza la fecha de las cuotas del pago programado y la descripción del Id de pago programado
--24/7/19 jcf Creación
--
CREATE PROCEDURE dbo.spRmActualizaFechaCuotasProgramadas
AS
--select top 100 first_inv_doc_date, spl.docdate, spl.*
update spl set docdate = sph.first_inv_doc_date
from rm20400 sph			--schedule payment header
inner join rm20401 spl		--schedule payment line
	on spl.schedule_number = sph.schedule_number
where spl.Status = 3
and datediff(day, spl.docdate, sph.first_inv_doc_date) != 0
--and sph.SCHEDULE_NUMBER = 'B51799'


--Propósito. Actualiza la descripción del Id de pago programado
--select top 100 first_inv_doc_date, spl.docdate, sph.*
update sph set schedule_desc = convert(varchar(10), sph.first_inv_doc_date, 103)
from rm20400 sph			--schedule payment header
inner join rm20401 spl		--schedule payment line
	on spl.schedule_number = sph.schedule_number
where spl.Status = 3
and datediff(day, spl.docdate, sph.first_inv_doc_date) = 0
and sph.schedule_desc != convert(varchar(10), sph.first_inv_doc_date, 103)
--and sph.SCHEDULE_NUMBER = 'B51799'

go

IF (@@Error = 0) PRINT 'Creación exitosa de: spRmActualizaFechaCuotasProgramadas'
ELSE PRINT 'Error en la creación de: spRmActualizaFechaCuotasProgramadas'
GO
----------------------------------------------------------------------------------
