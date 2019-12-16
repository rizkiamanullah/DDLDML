create table pengguna (
    email varchar(50),
    nama varchar(50),
    saldo_dompetku number,
    poin number,
    no_hp varchar(50),
    password varchar(50)
);

alter table pengguna add constraint pengguna_pk primary key ( email );
alter table pengguna add id_keranjang varchar(50);

create table keranjang (
    id_keranjang varchar(50),
    harga_total number
);

alter table keranjang add constraint keranjang_pk primary key ( id_keranjang );
alter table keranjang add email varchar(50);

create table memiliki (
    id_keranjang varchar(50),
    email varchar(50),
    id_transaksi varchar(50)
);

create table transaksi (
    id_transaksi varchar(50),
    nama_metode_pembayaran varchar(50),
    is_premium varchar(50),
    tanggal date,
    status_transaksi varchar(50)
);

alter table transaksi add id_keranjang varchar(50);
alter table transaksi add constraint transaksi_pk primary key ( id_transaksi );

create table tampung (
    id_keranjang varchar(50),
    id_item varchar(50),
    kuantitas number,
    harga_tampung number
);

create table item (
    id_item varchar(50),
    nama_item varchar(50),
    harga_item number
);

alter table item add constraint item_pk primary key ( id_item );

create table metode_pembayaran (
    nama_metode_pembayaran varchar(50),
    pajak number
);

alter table metode_pembayaran add constraint metode_pk primary key ( nama_metode_pembayaran );

alter table memiliki add constraint penggunaafk foreign key ( email ) references pengguna ( email );
alter table memiliki add constraint keranjang_fk foreign key ( id_keranjang ) references keranjang ( id_keranjang );
alter table pengguna add constraint keranjangfk foreign key ( id_keranjang ) references keranjang ( id_keranjang );
alter table keranjang add constraint penggunafk foreign key ( email ) references pengguna ( email );
alter table tampung add constraint keranjankfk foreign key ( id_keranjang ) references keranjang ( id_keranjang );
alter table tampung add constraint item_fk foreign key ( id_item ) references item ( id_item );
alter table transaksi add constraint metode_fk foreign key ( nama_metode_pembayaran ) references metode_pembayaran ( nama_metode_pembayaran );
alter table transaksi add constraint keranjang__fk foreign key ( id_keranjang ) references keranjang ( id_keranjang );

create or replace trigger insertItem
	before insert on tampung
	for each row
	enable
	declare
    	harga number; harga_tot number;
	begin
    	select harga_item into harga from item where id_item=:new.id_item;
    	:new.harga_tampung := harga * :new.kuantitas;
    	select harga_total into harga_tot from keranjang where id_keranjang=:new.id_keranjang;
    	update keranjang set harga_total=harga_tot+(harga*:new.kuantitas) where id_keranjang=:new.id_keranjang;
	end;

create or replace trigger newUser1
	after insert on pengguna
	for each row
	enable
	begin
    	insert into keranjang values(concat('KR-',:new.email),0);
	end;   

insert into pengguna values('rickash@gmail.com','Rick Ashley',0,0,'00898977','never gonna give you up');
insert into pengguna values('realrick@gmail.com','Rick Morty',0,0,'00989877','never gonna let you down');
insert into pengguna values('rickashley@gmail.com','Ricky Ashley',0,0,'00665577','never gonna run around and desert you');
insert into pengguna values('actualrick@gmail.com','Rick Martin',0,0,'00443277','never gonna make you cry');
insert into pengguna values('rickyrick@gmail.com','Rick Justin',0,0,'00123477','never gonna say goodbye');
insert into pengguna values('asasas@gmail.com','Rick Asas',0,0,'00112233','asassasa');
insert into pengguna values('qwqwqw@gmail.com','Rick Qwqw',0,0,'00223344','qwqwwqwq');
insert into pengguna values('zxzxzx@gmail.com','Rick Zxzx',0,0,'00113355','zxzxxzxz');
insert into pengguna values('dfdfdf@gmail.com','Rick Dfdf',0,0,'00224466','dfdffdfd');
insert into pengguna values('cvcvcv@gmail.com','Rick Cvcv',0,0,'00335544','cvcvvcvc');
insert into pengguna values('evolto@gmail.com','KR Evolt',0,0,'0044553322','blackhole');
insert into pengguna values('cronus@gmail.com','KR Cronus',0,0,'0022442233','gamedeus');
insert into pengguna values('extremer@gmail.com','KR Extremer',0,0,'00225566','darkghost');
insert into pengguna values('chaser@gmail.com','KR Chaser',0,0,'00221177','tunechaser');
insert into pengguna values('baron@gmail.com','KR Baron',0,0,'00223399','lordbaron');
insert into pengguna values('gundam00@gmail.com','Setsuna F. Seiei',0,0,'00000000','exia');
insert into pengguna values('gundamwing@gmail.com','Heero Yuy',0,0,'00111111','wing');
insert into pengguna values('gundambone@gmail.com','Tobia Arronax',0,0,'00123456','crossbone');
insert into pengguna values('gundamg@gmail.com','Domon Kasshu',0,0,'00663344','godgundam');
insert into pengguna values('gundamz@gmail.com','Kamille Bidan',0,0,'00556677','zgundam');

insert into item values('STM01','Steam Wallet 10k',11000);
insert into item values('STM02','Steam Wallet 20k',22000);
insert into item values('STM03','Steam Wallet 35k',37000);
insert into item values('STM04','Steam Wallet 50k',52000);
insert into item values('STM05','Steam Wallet 65k',67000);
insert into item values('STM06','Steam Wallet 80k',82000);
insert into item values('STM07','Steam Wallet 100k',102000);
insert into item values('STM08','Steam Wallet 130k',132000);
insert into item values('STM09','Steam Wallet 165k',167000);
insert into item values('STM10','Steam Wallet 200k',202000);

insert into item values('GRN01','Voucher Garena 20 shell',6700);
insert into item values('GRN02','Voucher Garena 30 shell',8000);
insert into item values('GRN03','Voucher Garena 33 shell',8700);
insert into item values('GRN04','Voucher Garena 60 shell',15200);
insert into item values('GRN05','Voucher Garena 66 shell',14800);
insert into item values('GRN06','Voucher Garena 100 shell',38000);
insert into item values('GRN07','Voucher Garena 150 shell',46200);
insert into item values('GRN08','Voucher Garena 165 shell',44600);
insert into item values('GRN09','Voucher Garena 175 shell',59100);
insert into item values('GRN10','Voucher Garena 330 shell',82000);

insert into item values('PSN01','Voucher PSN 50k',61000);
insert into item values('PSN02','Voucher PSN 100k',107000);
insert into item values('PSN03','Voucher PSN 150k',163700);
insert into item values('PSN04','Voucher PSN 200k',222000);
insert into item values('PSN05','Voucher PSN 225k',243300);
insert into item values('PSN06','Voucher PSN 300k',311000);
insert into item values('PSN07','Voucher PSN 325k',342000);
insert into item values('PSN08','Voucher PSN 400k',433000);
insert into item values('PSN09','Voucher PSN 500k',530000);
insert into item values('PSN10','Voucher PSN 600k',622000);

insert into item values('GP01','Voucher Google Play 20k',18000);
insert into item values('GP02','Voucher Google Play 50k',47000);
insert into item values('GP03','Voucher Google Play 75k',73700);
insert into item values('GP04','Voucher Google Play 100k',98000);
insert into item values('GP05','Voucher Google Play 150k',148300);
insert into item values('GP06','Voucher Google Play 200k',189000);
insert into item values('GP07','Voucher Google Play 300k',292000);
insert into item values('GP08','Voucher Google Play 350k',341000);
insert into item values('GP09','Voucher Google Play 500k',489000);
insert into item values('GP10','Voucher Google Play 1JT',989000);

insert into metode_pembayaran values('Internet Banking',10);
insert into metode_pembayaran values('Saldo Dompetku',0);
insert into metode_pembayaran values('Pulsa',30);
insert into metode_pembayaran values('E-Wallet (Dana, Go-Pay, OVO, dll)',15);

