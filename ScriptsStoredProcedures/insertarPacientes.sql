USE [HospitalDB]
GO
/****** Object:  StoredProcedure [dbo].[uspInsertarPaciente]    Script Date: 24/2/2025 21:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspInsertarPaciente]
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @FechaNacimiento DATE,
    @Telefono NVARCHAR(15),
    @Email NVARCHAR(100),
    @Direccion NVARCHAR(255),
    @Identificacion NVARCHAR(20) -- Nuevo parámetro
AS
BEGIN
    INSERT INTO Pacientes (Nombre, Apellido, FechaNacimiento, Telefono, Email, Direccion, Identificacion)
    VALUES (@Nombre, @Apellido, @FechaNacimiento, @Telefono, @Email, @Direccion, @Identificacion);
END;