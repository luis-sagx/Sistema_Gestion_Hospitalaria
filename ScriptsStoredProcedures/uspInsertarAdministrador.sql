CREATE PROCEDURE uspInsertarAdministrador
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @Clave NVARCHAR(255),
    @Email NVARCHAR(255)
AS
BEGIN
    INSERT INTO Administradores (Nombre, Apellido, Clave, Email)
    VALUES (@Nombre, @Apellido, @Clave, @Email);
END;