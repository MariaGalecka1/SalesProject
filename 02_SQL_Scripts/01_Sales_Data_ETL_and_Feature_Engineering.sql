--Tworzenie tabeli Sales Data za pomocą union all wszystkich tabel
Create table public."Sales Data" as
select * from public."Sales Canada"
Union all
select * from public."Sales China"
Union all
select * from public."Sales India"
Union all
select * from public."Sales Nigeria"
Union all
select * from public."Sales UK"
Union all
select * from public."Sales US"

--Szukanie wartości z null
select *
from public."Sales Data"
where
	"Country" is null
	or "Price Per Unit" is null,
	or "Quantity Purchased" is null
	or "Cost Price" is null
	or "Discount Applied" is null;

--Ręczne dodanie wartości w pozycjach z null
update public."Sales Data"
set "Quantity Purchased" = 3
where "Transaction ID" = '00a30472-89a0-4688-9d33-67ea8ccf7aea';

update public."Sales Data"
set "Price Per Unit" = (
	select avg ("Price Per Unit"
	from public."Sales Data"
	where "Price Per Unit" is not null
	)
where "Transaction ID" = '001898f7-b696-4356-91dc-8f2b73d09c63';

--Dodanie kolumny Total Amount w tabeli Sales Data
Alter table public."Sales Data" add
column "Total Amount" Numeric(10,2);

--Dodanie wartości do stworzonej kolumny Total Amount
update public."Sales Data" 
set "Total Amount" = ("Price Per Unit" * "Quantity Purchased") - "Discount Applied";

--Dodanie kolumny Profit w tabeli Sales Data
Alter table public."Sales Data" add
column "Profit" Numeric(10,2);

--Dodanie wartości do stworzonej kolumny Profit
update public."Sales Data" 
set "Profit" = "Total Amount" - ("Cost Price" * "Quantity Purchased");