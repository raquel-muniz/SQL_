CREATE DATABASE App_comercio_eletronico;
USE App_comercio_eletronico;

CREATE TABLE Clientes (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Nome VARCHAR(50) NOT NULL
);

CREATE TABLE Endereços (
	endereco_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Produtos (
	produto_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Categorias (
	categoria_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Fornecedores (
	fornecedor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Vendas (
	venda_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Itens_Vendas (
	itens_venda_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Pagamentos (
	pagamento_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Status_Pedido (
	pedido_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Carrinho (
	carrinho_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);