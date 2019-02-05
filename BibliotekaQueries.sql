Select imie,nazwisko from autorzy
where imie ='Fiodor';

Select k.tytul, k.ISBN, k.dzial, a.imie, a.nazwisko
from ksiazki k join autorzy a
on k.id_autorzy = a.id_autorzy
where a.imie like '%a%';

Select k.tytul, k.ISBN, kat.nazwa, a.imie, a.nazwisko
from ksiazki k join autorzy a
on k.id_autorzy = a.id_autorzy 
join ksiazki_kategorie kk
on k.id_ksiazki = kk.ksiazki_id_ksiazki
join kategorie kat
on kk.kategorie_id_kategorie = kat.id_kategorie
order by k.tytul;

Select k.tytul
from ksiazki k join wypozyczenia wyp
on k.id_ksiazki = wyp.id_ksiazki
join czytelnicy cz
on wyp.id_czytelnicy = cz.id_czytelnicy
where cz.imie = "Elrzbieta" and cz.nazwisko = "Romaniuk" and wyp.data_oddania is null;

Select k.tytul, a.nazwisko
from autorzy a join ksiazki k
on a.id_autorzy= k.id_autorzy
where a.imie ="Ernest";

Select kat.nazwa, count(k.id_ksiazki) as 'number of books'
from ksiazki k join ksiazki_kategorie kk
on k.id_ksiazki = kk.ksiazki_id_ksiazki
join kategorie kat
on kk.kategorie_id_kategorie = kat.id_kategorie
group by kat.nazwa
order by count(k.id_ksiazki) desc;

Select distinct pr.imie, pr.nazwisko
from pracownicy pr join wypozyczenia wyp
on pr.id_pracownicy = wyp.id_pracownicy_wyp;

Select imie , nazwisko, data_urodzenia
from czytelnicy
where data_urodzenia > '1960-01-01';

Select imie, nazwisko,data_urodzenia, floor(DATEDIFF(CURRENT_DATE(), data_urodzenia)/365)as years
from czytelnicy;

Select avg(floor(DATEDIFF(CURRENT_DATE(), data_urodzenia)/365))
from czytelnicy;

Select imie, nazwisko, DATEDIFF(CURRENT_DATE(), data_urodzenia)/365
from czytelnicy 
where DATEDIFF(CURRENT_DATE(), data_urodzenia)/365 >
(select avg(DATEDIFF(CURRENT_DATE(), data_urodzenia)/365) from czytelnicy);

