use eccomerce;
show tables;

 -- Client: idClient, fName, mInit, lName, cpf, address
 
 insert into Client (fName, mInit, lName, cpf, address)
	values('Maria', 'M', 'Silva', 123456789, 'rua silva de prara, 29, Carangola - Cidades das Flores'),
		  ('Matheus', 'O', 'Pimentel', 987654321, 'rua Almeida, 289, Centro - Cidade das Flores'),
          ('Ricardo', 'F', 'Silva', 045678913, 'avenida almeida vinha, 1009, Centro - Cidade das Flores'),
          ('Júlia', 'S', 'França', 789123456, 'rua Laranjeiras, 8761, Centro - Cidade das Flores'),
          ('Roberta', 'G', 'Assis', 978456310, 'avenidda koller, 19, centro - Cidade das Flores'),
          ('Isabela', 'M', 'Cruz', 654789123, 'rua alamenda das flores, 28, centro - Cidade das Flores');
          
-- Product: pName, kidsContent, category ('Eletrônico','Vestuário','Brinquedos','Alimentos','Móveis'), avaliation, size

insert into product (pName, kidsContent, category, avaliation, size)
	values('Fone de Ouvido',false,'Eletrônico','4',null),
		  ('Barbie Elsa',true,'Brinquedos','3',null),
          ('Body Carters',true,'Vestuário','5',null),
          ('Microfone Vedo - Youtuber',false,'Eletrônico','4',null),
          ('Sofá Retrátil',false,'Móveis','3','3x57x80'),
          ('Farinha de arroz',false,'Alimentos','2',null),
          ('Fire Stick Amazon',false,'Eletrônico','3',null);
        
select * from client;
select * from orders;

-- Orders: idOrderClient, orderStatus ('Cancelado','Confirmado','Em processamento'), orderDescription,sendValue, paymentCash,

insert into Orders (idOrderClient, orderStatus, orderDescription,sendValue, paymentCash)
	values(1,'Em processamento','Compra via aplicativo',10, false),
	      (2,'Em processamento','Compra via aplicativo',50, false),
          (3,'Confirmado',null,null, true),
          (4,'Em processamento','Compra via web site',150, false);
          
select * from orders;
select * from product;

-- productOrder: idPOproduct,  idPOrder, poQuantity, poStatus ('Disponível','Sem estoque')

insert into productOrder (idPOproduct,  idPOrder, poQuantity, poStatus)
	values(1,1,2,'Disponível'),
		  (2,2,1,'Disponível'),
          (3,3,1,'Disponível');
          
-- storageLocation: location

insert into productStorage (storageLocation,Quantidade)
	values ('Rio de Janeiro',1000),
		   ('Rio de Janeiro',500),
           ('São Paulo',10),
           ('São Paulo',100),
           ('São Paulo',10);
           
--  storageLocation: idLproduct, idLstorage, location,

select * from productstorage;

insert into storageLocation (idLproduct, idLstorage, location)
	values (1,2,'RJ'),
		   (2,4,'GO');

-- supplier: idSupplier, socialName, cnpj, contact

insert into supplier (socialName, cnpj, contact)
	values('Almeida e Filhos', 123456789123456, 21985474),
		  ('Eletronicos Silva', 854519649143456, 21985484),
          ('Eletronicos Valma', 934567893934695, 21975474);
          
         
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity)
VALUES
    (1, 1, 500),
    (1, 2, 400),
    (2, 4, 633),
    (1, 3, 5),
    (2, 5, 10);
    
-- seller: idSeller, socialName, abstName, cnpj, cpf, localtion,

INSERT INTO seller (socialName, abstName, cnpj, cpf, localtion, contact) VALUES
    ('Tech eletronics', null, '123456789456321', null, 'Rio de Janeiro', '219946287'),
    ('Boutique Dourgas', null, null, '123456783', 'Rio de Janeiro', '2195678895'),
    ('Kids World', null, '456789123654485', null, 'São Paulo', '1198657484');
        
-- productSeller: idPseller, idPproduct, prodQuantity
INSERT INTO productSeller (idPseller, idPproduct, prodQuantity) VALUES
    (1,6,80),
    (2,7,10);
    
-- queries

select count(*) from client;
select * from client c, orders o where c.iDClient = idOrderClient;
select concat(fname, ' ', lName) as Client, idOrders as Request, orderStatus as Status from client c, orders o where c.idClient = idOrderClient;


    