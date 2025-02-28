USE [HospitalDB]
GO
/****** Object:  StoredProcedure [dbo].[uspObtenerPacientes]    Script Date: 24/2/2025 21:11:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspObtenerPacientes]
AS
BEGIN
    SELECT Id, Nombre, Apellido, FechaNacimiento, Telefono, Email, Direccion, Identificacion
    FROM Pacientes;
END;