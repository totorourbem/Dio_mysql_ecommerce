-- criação do banco de dados para o cenário de e-commerce

create database ecommerce;
use ecommerce;

-- área de trigger e funções (a implementar)
-- tabela de CEP, extraida de https://github.com/devmediadev/SQL-BANCO-CEP-Cidades-Logradouros, porém tem um retrabalho a ser feito ali, que também não vou ter tempo hábil, vou deixar pra implementar futturamente
-- Recomendações Gerais: Padronizar TODOS os nomes para snake_case (Chaves), maiuscula apenas para tabelas (camelCase)
-- apliquei CPF como identificador, visto que o mesmo é unico e obrigatório, retirando a obrigação de alter table
-- criar tabelas cliente, produto e pedido aqui, o onjetivo proincipal a implementar é o uso de tabelas de referência para CEP/endereços Eu ia validar Pf, mas o processo demandaria um tempo que não tenho no momento. 
-- Frete, a prenteção é fazer uma tabela referencial, utilizando CEP, Volume e peso para calculo de PAC (sem registrar o valor, que pode ser alterado
-- Remover a necessidade de usar alter table
-- adicionararmazenamento especifioc para reviews
-- adicionar armazenamento para serviço de assinaturas

create table Client(
	id_client_CPF char(11) not null primary key,  -- apliquei CPF como identificador, visto que o mesmo é unico e obrigatório, retirando a obrigação de alter table
    first_name varchar(10),
    middle_init char(3),
    last_name varchar(20),
    CEP char(8) not null, -- importante pra calculo de frete volume
    street_adress varchar(30)not null, -- desmembrada pois a implementação futura de CEP pede esses dados em separado, inclusive Logradouro 
    street_name_adress varchar(30)not null,  -- aqui vai o nome do logradouro 
    number_adress varchar(6)not null, 
    complement_adress varchar (255),
    district_adress varchar (100)not null,
    city_adress varchar (100) not null,
    UF char(2) not null,
    constraint unique_cpf_client unique (id_client_CPF) -- regra de CPF unico
);
create table Product(
	id_prod_barcode varchar(13) not null primary key, -- optei por cadastrar diretamente o codigo de barras (EAN) que é unico, retira a necessidade do alter table
    price numeric (6,2) not null, -- preferi usar numeric, apara fortmatar melhor os dados
    prod_name varchar(100) not null,
    category enum('Hardware','Periféricos','Livros','Impressoras', 'Papeçlaria') not null,
    -- avaliation int, fica pra implementar a media das avaliações do produto no futuro
    weight float not null, -- importante pra calculo de frete volume no futuro
    volume float not null -- importante pra calculo de frete volume no futuro
    
);
create table Reviews (
    id_review int auto_increment primary key,
    id_client char(11),
    id_product  varchar(13),
    rating int check (rating >= 1 AND rating <= 5), -- Restrição para avaliação entre 1 e 5
    comment text,
    review_date date,
    foreign key (id_client) references Client(id_client_CPF),
    foreign key (id_product) references Product(id_prod_barcode)
    );
     
create table Orders(
	id_orders int auto_increment primary key,
    id_order_client char(11),
    order_type enum('Avulso', 'Assinatura') not null default 'Avulso',
    id_subscription INT default 0,
    order_status enum('Cancelado','Confirmado','Em processamento') default "Em processamento",
    order_description varchar(255),
    send_type enum('PAC', 'Sedex', 'Transportadora', 'Retirada no local'),
    Constraint fk_orders_client foreign key (id_order_client) references Client(id_client_CPF)
		on update cascade
        on delete set null
);
create table Payment(
	id_payment int auto_increment primary key,
    id_client char(11),
	type_payment enum('Cartão de Crédito','Dois ou  mais Cartões de Crédito','Espécie','PIX', 'Boleto') not null,
    order_description varchar(255),
    limit_available numeric (6,2),
    Constraint fk_payment_orders_client foreign key (id_client) references Client(id_client_CPF)
);
create table Subscriptions (
    id_subscription int auto_increment primary key,
    id_client char(11),
    start_date date,
    end_date date,
    description_subscription varchar(255) not null,
    subscription_status ENUM('Ativa', 'Pausada', 'Cancelada') not null,
    subscription_amount decimal(6, 2) not null,
    foreign key (id_client) references Client(id_client_CPF)
);

alter table Orders auto_increment=1;
alter table Payment auto_increment=1;
alter table Reviews auto_increment=1;

 -- Fornecedor e estoque
 
 create table ProductStorage(
	id_product_storage int auto_increment,
    storage_location varchar(255),
    quantidade int default 0,
    primary key(id_product_storage)
);
 create table Supplier(
	id_supplier_CNPJ varchar(14) not null primary key, -- mesma lógica de cliente
    social_name varchar(255) not null,
    contact char (11) not null,
    constraint unique_supplier unique(id_supplier_CNPJ)
);

alter table ProductStorage auto_increment=1;

-- Terceiro Vendedor e Produtos por vendedor (terceiro)

create table Seller(
	id_seller int auto_increment primary key, -- aqui precisava conciliar a ideia de caracer unico e ser entre um CPF ou CNPJ
    social_name varchar(255) not null,
    abst_name varchar(255),
    CNPJ varchar(14),
    CPF varchar(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_socialName_seller unique(social_name),
    constraint unique_cpf_seller unique(CPF),
    constraint unique_cnpj_seller unique(CNPJ)
);
create table ProductSeller(
	id_prod_seller int,
    id_prod_Product  varchar(13),
    prod_quantity int default 1,
    primary key (id_prod_seller, id_prod_Product),
    constraint fk_product_seller foreign key (id_prod_seller) references Seller(id_seller),
    constraint fk_product_product foreign key (id_prod_Product) references product(id_prod_barcode)
);
create table ProductOrder(
	id_po_product  varchar(13),
    id_po_order int,
    po_quantity int default 1,
    po_status enum('Disponível','Sem estoque') default 'Disponível',
    primary key (id_po_product, id_po_order),
    constraint fk_product_order_seller foreign key (id_po_product) references Product(id_prod_barcode),
    constraint fk_product_order_product foreign key (id_po_order) references Orders(id_orders)
    );
create table StorageLocation(
	id_l_product  varchar(13),
    id_l_storage int,
    location varchar(255) not null,
    quantity int default 0,
    primary key (id_l_product, id_l_storage),
    constraint fk_storage_location_product foreign key (id_l_product) references Product(id_prod_barcode),
    constraint fk_storage_location_storage foreign key (id_l_storage) references ProductStorage(id_product_storage)
    );
create table productSupplier (
	id_ps_supplier char(14),
    id_ps_product  varchar(13),
    quantity int not null,
    primary key (id_ps_supplier, id_ps_product),
    constraint fk_product_suplier_supplier foreign key (id_ps_supplier) references supplier(id_supplier_CNPJ),
    constraint fk_product_supplier_product foreign key (id_ps_product) references product(id_prod_barcode)
    );
alter table seller auto_increment=1;