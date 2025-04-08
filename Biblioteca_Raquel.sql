CREATE DATABASE IF NOT EXISTS Biblioteca_Rachel;
USE Biblioteca_Rachel;

CREATE TABLE Livros_biblioteca (
    ISBN_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    TITULO VARCHAR(50) NOT NULL, 
    AUTOR VARCHAR(30) NOT NULL, 
    ANO YEAR NOT NULL
);

CREATE TABLE Membros (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(35) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Telefone CHAR(11)
);

CREATE TABLE Emprestimo (
    EMP_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    ISBN_ID INT NOT NULL, 
    ID_Pessoa INT NOT NULL, 
    Dt_Emp DATE NOT NULL, 
    Dt_Dev DATE NOT NULL, 
    Dt_Ent DATE NOT NULL,
    FOREIGN KEY (ISBN_ID) REFERENCES Livros_biblioteca(ISBN_ID),
    FOREIGN KEY (ID_Pessoa) REFERENCES Membros(ID)
);

SELECT Emprestimo.EMP_ID, Livros_biblioteca.TITULO, Membros.Nome, Emprestimo.Dt_Emp, Emprestimo.Dt_Dev
FROM Emprestimo
INNER JOIN Livros_biblioteca ON Emprestimo.ISBN_ID = Livros_biblioteca.ISBN_ID
INNER JOIN Membros ON Emprestimo.ID_Pessoa = Membros.ID;

SELECT Emprestimo.EMP_ID, Livros_biblioteca.TITULO, Emprestimo.Dt_Emp, Emprestimo.Dt_Dev
FROM Emprestimo
INNER JOIN Livros_biblioteca ON Emprestimo.ISBN_ID = Livros_biblioteca.ISBN_ID
WHERE Emprestimo.ID_Pessoa = ID_Pessoa;
