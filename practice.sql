select * from movies;

-- 1. urutkan film dari yang paling terbaru
select title, year from movies
order by year desc;

--2. ambil 3 rating terbaik
select title, rating from movies
order by rating desc
limit 3;

--3. ambil 5 film terbaru
select title, year from movies
order by year desc
limit 5;

--4. ambil genre unik
select distinct genre from movies;

-- ambil 2 film tertua
select title, year from movies
order by year 
limit 2;

-- 3 film sci-fi rating tertinggi
select title, genre, rating from movies
where genre = 'Sci-Fi'
order by rating desc
limit 3;

--tahun rilis unik
select distinct year from movies;

-- film non drama,urut rating tertinggi
select title, genre, rating from movies
where genre not like 'Drama'
order by rating desc;

select * from movies
order by year desc
limit 4 offset 4;
