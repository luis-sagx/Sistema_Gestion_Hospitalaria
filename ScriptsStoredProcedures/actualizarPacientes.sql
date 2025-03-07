USE [HospitalDB]
GO
/****** Object:  StoredProcedure [dbo].[uspActualizarPaciente]    Script Date: 24/2/2025 21:15:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspActualizarPaciente]
    @Id INT,
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @FechaNacimiento DATE,
    @Telefono NVARCHAR(15),
    @Email NVARCHAR(100),
    @Direccion NVARCHAR(255),
    @Identificacion NVARCHAR(20)
AS
BEGIN
    UPDATE Pacientes
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        FechaNacimiento = @FechaNacimiento,
        Telefono = @Telefono,
        Email = @Email,
        Direccion = @Direccion,
        Identificacion = @Identificacion
    WHERE Id = @Id;
END;