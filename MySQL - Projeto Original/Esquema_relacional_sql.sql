-- criação do banco de dados para o cenário de e-commerce
-- drop database ecommerce; 
create database ecommerce;
use ecommerce;

-- criar tabelas cliente, produto e pedido

create table Client(
	idClient int auto_increment primary key,
    fName varchar(10),
    mInit char(3),
    lName varchar(20),
    cpf char(11) not null, 
    address varchar(255), -- Endreço deve ser composto, CEP é dado importante para frete
    constraint unique_cpf_client unique (CPF) -- regra de CPF unico
);
create table Product(
	idProduct int auto_increment primary key,
    pName varchar(100) not null,
    kidsContent bool default false,
    category enum('Eletrônico','Vestuário','Brinquedos','Alimentos','Móveis') not null,
    avaliation float default 0,
    size varchar(10) -- importante pra calculo de frete volume
);
create table Orders(
	idOrders int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default "Em processamento",
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    Constraint fk_orders_client foreign key (idOrderClient) references Client(idClient)
		on update cascade
        on delete set null
);

alter table Client auto_increment=1;
alter table Product auto_increment=1;
alter table Orders auto_increment=1;

-- criar tabela de tipo de pagamento, criar constraints e relacionamentos com orders e clients

-- create table payment(
	-- idClient int,
	-- idPayment int,
    -- typePayment enum('Cartão de Crédito','Dois ou  mais Cartões de Crédito','Espécie','PIX', 'Boleto') not null,
    -- orderDescription varchar(255),
    -- limitAvailable float,
    -- primary key(idClient, idPayment)
-- );

 -- Fornecedor e estoque
 
 create table productStorage(
	idProductStorage int auto_increment,
    storageLocation varchar(255),
    Quantidade int default 0,
    primary key(idProductStorage)
);
 create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(255) not null,
    cnpj varchar(15) not null,
    contact char (11) not null,
    constraint unique_supplier unique(cnpj)
);

alter table productStorage auto_increment=1;
alter table supplier auto_increment=1;

-- Terceiro Vendedor e Produtos por vendedor (terceiro)

create table seller(
	idSeller int auto_increment primary key,
    socialName varchar(255) not null,
    abstName varchar(255),
    cnpj varchar(15),
    cpf varchar(9),
    localtion varchar(255),
    contact char(11) not null,
    constraint unique_socialName_seller unique(socialName),
    constraint unique_cpf_seller unique(cpf),
    constraint unique_cnpj_seller unique(cnpj)
);
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);
create table productOrder(
	idPOproduct int,
    idPOrder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOrder),
    constraint fk_productorder_seller foreign key (idPOProduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOrder) references orders(idOrders)
    );
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    quantity int default 0,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage)
    );
create table productSupplier (
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_suplier_supplier foreign key (idPsSupplier) references supplier(idsupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
    );
alter table seller auto_increment=1;