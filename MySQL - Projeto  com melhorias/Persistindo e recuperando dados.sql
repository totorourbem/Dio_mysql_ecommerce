-- use eccomerce;
-- show tables;

 -- Client: id_client_CPF, first_name, middle_init, last_name, CEP, street_adress, street_name_adress, number_adress, complement_adress, district_adress, city_adress, UF
 
 insert into Client (id_client_CPF, first_name, middle_init, last_name, CEP, street_adress, street_name_adress, number_adress, complement_adress, district_adress, city_adress, UF)
	values("36734937676","Kimberly","L.","Mercado","14243892","Avenida","864-9194 Metus Rd.",2376,"Casa","Shanxi","Anápolis","PR"),
		  ("01883436785","Victor","S.","Nixon","06077412","Rodovia","587-6031 Neque. St.",3624,"Fundos","Cannes","Criciúma","PE"),
		  ("78757256352","Curran","P.","Lawrence","13640526","Rua","462-835 Lacus. Avenue",3924,"Fundos","Muzaffargarh","Itajaí","MG"),
		  ("24474284635","Ulla","M.","Stein","41533218","Avenida","3874 Mauris Rd.",4052,"Casa","Asan","São José dos Pinhais","SC"),
		  ("31186510485","Marcia","S.","Duran","63725837","Alameda","642-3873 Tempor Ave",4479,"Sede","Tromsø","Jaboatão dos Guararapes","RJ"),
		  ("41662785655","Dale","K.","Camacho","85787189","Avenida","146-6499 Massa. Avenue",6315,"Fundos","Stuttgart","Camaragibe","BA"),
		  ("44557758315","Barrett","D.","Mcintosh","41672046","Alameda","Ap #476-5530 Mus. Ave",4390,"Sede","Việt Trì","Santa Inês","PB"),
		  ("50756235070","Samson","E.","Mcclure","87947535","Avenida","Ap #151-6159 Pharetra. St.",9772,"Fundos","Piła","Cabo de Santo Agostinho","MA"),
		  ("23386203908","Constance","M.","Chandler","41248665","Travessa","4652 Suspendisse Rd.",2295,"Casa","Sicuani","Juazeiro do Norte","PE"),
		  ("04197786945","Cruz","D.","Calderon","42197679","Rodovia","P.O. Box 437, 6812 Rutrum. St.",5969,"Fundos","Nelson","Criciúma","PE");
          
-- Product: (id_prod_barcode, price prod_name, category enum('Hardware','Periféricos','Livros','Impressoras', 'Papelaria'), weight, volume)

insert into Product (id_prod_barcode, price, prod_name, category, weight, volume)
VALUES 
    ("7243632511084", 27.81, "Bluetooth Rolo de", "Periféricos", 4.767, 8.273),
    ("5204496410452", 53.07, "Monitor", "Livros", 3.846, 1.784),
    ("3953023082376", 56.88, "Placa-mãe CPU GPU", "Periféricos", 2.933, 7.675),
    ("8767413507454", 35.32, "Apontador Grampeador Clips", "Periféricos", 0.442, 1.464),
    ("2369050767114", 81.16, "Apagador de quadro branco", "Impressoras", 5.192, 7.477),
    ("2161064645361", 56.47, "mesa Porta-canetas Rolo", "Periféricos", 7.462, 6.532),
    ("4361101591396", 35.35, "Mousepad Headset", "Periféricos", 8.266, 6.925),
    ("6441504772628", 95.05, "Régua T", "Periféricos", 3.538, 2.881),
    ("4050606403856", 82.58, "HDMI Pen drive Mousepad", "Livros", 2.581, 3.611),
    ("7864091647842", 62.61, "notas Pasta de", "Hardware", 1.196, 1.266);
        
-- Orders (id_orders,id_order_client, order_type,id_subscription, order_status,order_description,send_type) atenção as referências de CPF de cliente

INSERT INTO Orders (id_orders,id_order_client, order_type,id_subscription, order_status,order_description,send_type)
VALUES
  ("1","36734937676","Assinatura","7","Em processamento","vitae velit egestas lacinia. Sed congue,","Transportadora"),
  ("2","01883436785","Assinatura","1","Cancelado","neque. Morbi quis","Retirada no local"),
  ("3","78757256352","Avulso","8","Em processamento","diam vel arcu. Curabitur ut odio vel est tempor","Sedex"),
  ("4","24474284635","Avulso","4","Em processamento","nisl. Nulla eu neque","Retirada no local"),
  ("5","31186510485","Avulso","6","Confirmado","amet orci.","Retirada no local"),
  ("6","44557758315","Assinatura","2","Confirmado","sed orci lobortis augue scelerisque","PAC"),
  ("7","50756235070","Assinatura","4","Confirmado","tempor lorem, eget mollis lectus","Transportadora"),
  ("8","50756235070","Assinatura","1","Cancelado","elit. Aliquam auctor, velit eget","PAC");

-- Criação de reviews aleatórios - (atenção as referências de cliente e produto)

insert into Reviews (id_review, id_client, id_product, rating , comment, review_date)
values
  ("1","36734937676","7243632511084",5,"magna nec quam. Curabitur vel lectus. Cum sociis","2024-01-14"),
  ("2","31186510485","5204496410452",5,"magna. Nam ligula elit, pretium et, rutrum non,","2024-07-10"),
  ("3","36734937676","7243632511084",4,"senectus et netus et malesuada","2021-02-16"),
  ("4","50756235070","8767413507454",2,"augue, eu tempor","2020-02-17"),
  ("5","31186510485","5204496410452",4,"ultricies","2022-02-14"),
  ("6","50756235070","7243632511084",2,"magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum","2023-05-12"),
  ("7","50756235070","3953023082376",2,"interdum. Curabitur dictum. Phasellus in","2025-09-16"),
  ("8","36734937676","5204496410452",3,"risus. Donec egestas. Aliquam nec enim. Nunc ut","2023-01-10"),
  ("9","31186510485","7864091647842",3,"nunc sit amet metus. Aliquam","2026-08-16");

-- Product order, atenção a barcode de produtos

insert into productOrder (id_po_product,  id_po_order, po_quantity, po_status)
	values
  ("7864091647842","1","6","Disponível"),
  ("4050606403856","2","8","Sem estoque"),
  ("6441504772628","3","7","Disponível"),
  ("2369050767114","4","6","Sem estoque"),
  ("7243632511084","5","1","Disponível");
        
-- productStorage: storage_location,quantidade

insert into productStorage (storage_location,quantidade)
	values ('Rio de Janeiro',1000),
		   ('Rio de Janeiro',500),
           ('São Paulo',10),
           ('São Paulo',100),
           ('São Paulo',10);
           
--  storageLocation: id_l_product, id_l_storage, location, quantity,

insert into storageLocation (id_l_product, id_l_storage, location, quantity)
	values ("7864091647842",2,'RJ', 1500),
		   ("4050606403856",4,'GO', 120);

-- supplier: social_name, id_supplier_CNPJ, contact

insert into supplier (social_name, id_supplier_CNPJ, contact)
	values('Almeida e Filhos', 12345789123456, 21985474),
		  ('Eletronicos Silva', 85459649143456, 21985484),
          ('Eletronicos Valma', 93456893934695, 21975474);

--  productSupplier (id_ps_supplier, id_ps_product, quantity)     
         
INSERT INTO productSupplier (id_ps_supplier, id_ps_product, quantity) 
VALUES
    (12345789123456, "7243632511084", 500),
    (12345789123456, "5204496410452", 400),
    (85459649143456, "3953023082376", 633),
    (93456893934695, "7864091647842", 5),
    (85459649143456, "7243632511084", 10);
    
-- seller: (social_name, abst_name, CNPJ, CPF, location, contact)

INSERT INTO seller (social_name, abst_name, CNPJ, CPF, location, contact) VALUES
    ('Tech eletronics', null, '12345678456321', null, 'Rio de Janeiro', '219946287'),
    ('Boutique Dourgas', null, null, '123456783', 'Rio de Janeiro', '2195678895'),
    ('Kids World', null, '45678912364485', null, 'São Paulo', '1198657484');
      
-- productSeller: (id_prod_seller, id_prod_Product, prod_quantity) atenção que aqui é pelo id

INSERT INTO productSeller (id_prod_seller, id_prod_Product, prod_quantity) VALUES
    (1, "7243632511084",80),
    (2, "7243632511084",10);