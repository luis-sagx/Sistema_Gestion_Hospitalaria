ALTER TABLE [HospitalDB].[dbo].[Citas]
ADD BHabilitado BIT NOT NULL DEFAULT 1;

ALTER TABLE [HospitalDB].[dbo].[Tratamientos]
ADD BHabilitado BIT NOT NULL DEFAULT 1;


USE [HospitalDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspObtenerCitas]
AS
BEGIN
    SELECT 
        C.Id,
        P.Id AS PacienteId,
        P.Identificacion AS PacienteIdentificacion,
        M.Id AS MedicoId,
        M.Identificacion AS MedicoIdentificacion,
        C.FechaHora,
        C.Estado
    FROM Citas C
    INNER JOIN Pacientes P ON C.PacienteId = P.Id
    INNER JOIN Medicos M ON C.MedicoId = M.Id
    WHERE C.BHabilitado = 1; -- Solo registros habilitados
END;
GO
ALTER PROCEDURE [dbo].[uspObtenerTratamientos]
AS
BEGIN
    SELECT 
        t.Id AS Id,
        p.Id AS PacienteId,
        p.Identificacion AS IdentificacionPaciente,
        t.Descripcion,
        t.Fecha,
        t.Costo
    FROM Tratamientos t
    INNER JOIN Pacientes p ON t.PacienteId = p.Id
    WHERE t.BHabilitado = 1; -- Solo registros habilitados
END;
GO
ALTER PROCEDURE [dbo].[uspFiltrarCitas]
    @PacienteIdentificacion NVARCHAR(15) = NULL,
    @MedicoIdentificacion NVARCHAR(15) = NULL,
    @FechaInicio DATETIME = NULL,
    @FechaFin DATETIME = NULL,
    @Estado NVARCHAR(20) = NULL
AS
BEGIN
    SELECT 
        C.Id,
        P.Id AS PacienteId,
        P.Identificacion AS PacienteIdentificacion,
        P.Nombre AS PacienteNombre,
        P.Apellido AS PacienteApellido,
        M.Id AS MedicoId,
        M.Identificacion AS MedicoIdentificacion,
        M.Nombre AS MedicoNombre,
        M.Apellido AS MedicoApellido,
        C.FechaHora,
        C.Estado
    FROM Citas C
    INNER JOIN Pacientes P ON C.PacienteId = P.Id
    INNER JOIN Medicos M ON C.MedicoId = M.Id
    WHERE C.BHabilitado = 1 -- Solo registros habilitados
      AND (@PacienteIdentificacion IS NULL OR P.Identificacion = @PacienteIdentificacion)
      AND (@MedicoIdentificacion IS NULL OR M.Identificacion = @MedicoIdentificacion)
      AND (@FechaInicio IS NULL OR C.FechaHora >= @FechaInicio)
      AND (@FechaFin IS NULL OR C.FechaHora <= @FechaFin)
      AND (@Estado IS NULL OR C.Estado = @Estado);
END;
GO
ALTER PROCEDURE [dbo].[uspFiltrarTratamientos]
    @IdentificacionPaciente NVARCHAR(15) = '',
    @Descripcion NVARCHAR(255) = '',
    @Fecha DATE = NULL,
    @Costo DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    SET @sql = '
        SELECT 
            t.Id AS Id, 
            p.Id AS PacienteId,
            p.Identificacion AS IdentificacionPaciente,
            t.Descripcion,
            t.Fecha,
            t.Costo
        FROM Tratamientos t
        INNER JOIN Pacientes p ON t.PacienteId = p.Id
        WHERE t.BHabilitado = 1'; -- Solo registros habilitados

    IF @IdentificacionPaciente <> ''
        SET @sql = @sql + ' AND p.Identificacion LIKE ''%' + @IdentificacionPaciente + '%''';

    IF @Descripcion <> ''
        SET @sql = @sql + ' AND t.Descripcion LIKE ''%' + @Descripcion + '%''';

    IF @Fecha IS NOT NULL
        SET @sql = @sql + ' AND t.Fecha = ''' + CONVERT(NVARCHAR, @Fecha, 23) + '''';

    IF @Costo IS NOT NULL
        SET @sql = @sql + ' AND t.Costo = ' + CAST(@Costo AS NVARCHAR);

    EXEC sp_executesql @sql;
END;
GO
ALTER PROCEDURE [dbo].[uspEliminarCita]
    @Id INT
AS
BEGIN
    UPDATE Citas
    SET BHabilitado = 0 -- Cambia BHabilitado a 0 (inactivo)
    WHERE Id = @Id;
END;
GO
ALTER PROCEDURE [dbo].[uspEliminarTratamiento]
    @Id INT
AS
BEGIN
    UPDATE Tratamientos
    SET BHabilitado = 0 -- Cambia BHabilitado a 0 (inactivo)
    WHERE Id = @Id;
END;