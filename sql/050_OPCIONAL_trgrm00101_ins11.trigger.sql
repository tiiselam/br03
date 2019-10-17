--DROP TRIGGER trgRM00101_ins11 

create TRIGGER trgRM00101_ins11 ON RM00101 AFTER INSERT AS  
BEGIN 
--Propósito. Copia el id de impuesto al campo contacto. Util para Getty Brasil
--28/08/19 jcf Creación. Solicitado por S Nagano

		declare @CUSTNMBR char(15), @TXRGNNUM char(25)
		select @CUSTNMBR = CUSTNMBR, @TXRGNNUM = TXRGNNUM from inserted

		if (rtrim(@TXRGNNUM) <> '')
		begin
			update rm00101 set cntcprsn = @TXRGNNUM where custnmbr = @CUSTNMBR
		end
	
END 
GO 


--select *
--from RM00101
--where CUSTNMBR = 'TESTJC'
