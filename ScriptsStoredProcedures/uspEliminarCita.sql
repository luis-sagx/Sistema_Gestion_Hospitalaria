CREATE PROCEDURE uspEliminarCita
    @Id INT
AS
BEGIN
    DELETE FROM Citas WHERE Id = @Id;
END;