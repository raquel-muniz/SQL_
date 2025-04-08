CREATE DATABASE SistemaVendas;
USE SistemaVendas;

CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Data_Cadastro DATE
);

CREATE TABLE Enderecos (
    ID_Endereco INT PRIMARY KEY AUTO_INCREMENT,
    Cliente_ID INT,
    Cidade VARCHAR(100),
    FOREIGN KEY (Cliente_ID) REFERENCES Clientes(ID_Cliente)
);

CREATE TABLE Produtos (
    ID_Produto INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Estoque INT,
    Categoria_ID INT,
    Fornecedor_ID INT,
    Preco DECIMAL(10, 2),
    FOREIGN KEY (Categoria_ID) REFERENCES Categorias(ID_Categoria),
    FOREIGN KEY (Fornecedor_ID) REFERENCES Fornecedores(ID_Fornecedor)
);

CREATE TABLE Categorias (
    ID_Categoria INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100)
);

CREATE TABLE Fornecedores (
    ID_Fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100)
);

CREATE TABLE Vendas (
    ID_Venda INT PRIMARY KEY AUTO_INCREMENT,
    Cliente_ID INT,
    Data_Venda DATE,
    Status_Pedido_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (Status_Pedido_ID) REFERENCES Status_Pedido(ID_Status_Pedido)
);

CREATE TABLE Itens_Venda (
    ID_Item_Venda INT PRIMARY KEY AUTO_INCREMENT,
    Venda_ID INT,
    Produto_ID INT,
    Quantidade INT,
    Preco DECIMAL(10, 2),
    FOREIGN KEY (Venda_ID) REFERENCES Vendas(ID_Venda),
    FOREIGN KEY (Produto_ID) REFERENCES Produtos(ID_Produto)
);

CREATE TABLE Pagamentos (
    ID_Pagamento INT PRIMARY KEY AUTO_INCREMENT,
    Venda_ID INT,
    Valor DECIMAL(10, 2),
    Data_Pagamento DATE,
    FOREIGN KEY (Venda_ID) REFERENCES Vendas(ID_Venda)
);

CREATE TABLE Status_Pedido (
    ID_Status_Pedido INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(50)
);

CREATE TABLE Carrinho (
    ID_Carrinho INT PRIMARY KEY AUTO_INCREMENT,
    Cliente_ID INT,
    Produto_ID INT,
    Quantidade INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (Produto_ID) REFERENCES Produtos(ID_Produto)
);

INSERT INTO Clientes (Nome, Data_Cadastro) VALUES 
('João Silva', '2024-09-01'),
('Maria Oliveira', '2024-10-15'),
('Carlos Souza', '2024-10-20');

INSERT INTO Enderecos (Cliente_ID, Cidade) VALUES 
(1, 'São Paulo'),
(2, 'Rio de Janeiro'),
(3, 'Brasília');

INSERT INTO Categorias (Nome) VALUES 
('Eletrônicos'),
('Roupas'),
('Alimentos');

INSERT INTO Fornecedores (Nome) VALUES 
('Fornecedor A'),
('Fornecedor B'),
('Fornecedor C');

INSERT INTO Produtos (Nome, Estoque, Categoria_ID, Fornecedor_ID, Preco) VALUES 
('Smartphone', 100, 1, 1, 1500.00),
('Camiseta', 200, 2, 2, 50.00),
('Chocolate', 300, 3, 3, 5.00);

INSERT INTO Status_Pedido (Descricao) VALUES 
('Pendente'),
('Enviado'),
('Entregue');

INSERT INTO Vendas (Cliente_ID, Data_Venda, Status_Pedido_ID) VALUES 
(1, '2024-10-01', 3),
(2, '2024-10-20', 1),
(3, '2024-10-25', 2);

INSERT INTO Itens_Venda (Venda_ID, Produto_ID, Quantidade, Preco) VALUES 
(1, 1, 1, 1500.00),
(2, 2, 3, 50.00),
(3, 3, 10, 5.00);

INSERT INTO Pagamentos (Venda_ID, Valor, Data_Pagamento) VALUES 
(1, 1500.00, '2024-10-01'),
(2, 150.00, '2024-10-20'),
(3, 50.00, '2024-10-25');

INSERT INTO Carrinho (Cliente_ID, Produto_ID, Quantidade) VALUES 
(1, 2, 2),
(2, 3, 5),
(3, 1, 1);

SELECT COUNT(*) AS TotalClientes FROM Clientes; 
 
SELECT * FROM Produtos WHERE Estoque > 50; 

SELECT Cliente_ID, COUNT(*) AS TotalVendas FROM Vendas GROUP BY Cliente_ID; 
 
SELECT * FROM Clientes  
WHERE Data_Cadastro >= CURDATE() - INTERVAL 30 DAY; 
 
SELECT Clientes.Nome, Enderecos.Cidade FROM Clientes JOIN Enderecos ON Clientes.ID_Cliente = Enderecos.Cliente_ID; 
  
SELECT Vendas.ID_Venda, Produtos.Nome, Itens_Venda.Quantidade FROM Itens_Venda JOIN Produtos ON Itens_Venda.Produto_ID = Produtos.ID_Produto JOIN Vendas ON Itens_Venda.Venda_ID = Vendas.ID_Venda; 
  
SELECT Categorias.Nome, COUNT(Produtos.ID_Produto) AS TotalProdutos FROM Produtos JOIN Categorias ON Produtos.Categoria_ID = Categorias.ID_Categoria GROUP BY Categorias.Nome; 
  
SELECT Fornecedores.Nome, COUNT(Itens_Venda.ID_Item_Venda) AS TotalVendidos FROM Itens_Venda JOIN Produtos ON Itens_Venda.Produto_ID = Produtos.ID_Produto JOIN Fornecedores ON Produtos.Fornecedor_ID = Fornecedores.ID_Fornecedor GROUP BY Fornecedores.Nome; 
  
SELECT Data_Venda, SUM(Itens_Venda.Preco * Itens_Venda.Quantidade) AS TotalVendas FROM Vendas JOIN Itens_Venda ON Vendas.ID_Venda = Itens_Venda.Venda_ID GROUP BY Data_Venda; 
  
SELECT Clientes.Nome FROM Clientes JOIN Vendas ON Clientes.ID_Cliente = Vendas.Cliente_ID JOIN Status_Pedido ON Vendas.Status_Pedido_ID = Status_Pedido.ID_Status_Pedido WHERE Status_Pedido.Descricao = 'Pendente'; 
  
SELECT Clientes.Nome, Produtos.Nome AS Produto, Carrinho.Quantidade  FROM Carrinho JOIN Clientes ON Carrinho.Cliente_ID = Clientes.ID_Cliente JOIN Produtos ON Carrinho.Produto_ID = Produtos.ID_Produto; 
  
SELECT Categorias.Nome, AVG(Produtos.Preco) AS PrecoMedio FROM Produtos JOIN Categorias ON Produtos.Categoria_ID = Categorias.ID_Categoria GROUP BY Categorias.Nome; 
  
SELECT SUM(Itens_Venda.Quantidade) AS TotalProdutosVendidos FROM Itens_Venda; 
  
SELECT Clientes.Nome, COUNT(Vendas.ID_Venda) AS TotalCompras FROM Clientes JOIN Vendas ON Clientes.ID_Cliente = Vendas.Cliente_ID GROUP BY Clientes.Nome HAVING TotalCompras > 3; 
  
SELECT Status_Pedido.Descricao, COUNT(Vendas.ID_Venda) AS TotalVendas FROM Vendas JOIN Status_Pedido ON Vendas.Status_Pedido_ID = Status_Pedido.ID_Status_Pedido GROUP BY Status_Pedido.Descricao; 
 