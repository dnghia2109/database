# Kiểm tra hết học phần
1. **Lấy thông tin các bộ phim gồm: tiêu đề, mô tả, tên đạo diễn, tên biên kịch (bảng writers - trả về dạng array), độ dài, rating, của các bộ phim thuộc loại ‘Movie’.**
```sql
SELECT m.title AS Title , m.description AS Description , d.full_name AS Director ,
	   JSON_ARRAYAGG(w.full_name) AS Writers , m.`length` AS Lengths , m.rating AS Rating 
FROM movie m INNER JOIN movie_writers mw  
ON m.id = mw.id_movie  
INNER JOIN writers w ON w.id = mw.id_writer 
INNER JOIN director d ON d.id = m.id_director 
INNER JOIN title_type tt ON m.id_title_type = tt.id 
WHERE tt.name = 'Movie'
GROUP BY m.id
```
==>  Dữ liệu lấy được:
![cau01](/day08/cau01.JPG)  

---

2. **Liệt kê các hãng phim (Bảng manufacturer) và số lượng phim thuộc hãng đó**
```sql
SELECT m.name AS Manufacturer , COUNT(mov.id) AS 'Quantity movies'
FROM manufacturer m LEFT JOIN movie_manufacturer mm 
ON m.id = mm.id_manufacturer 
INNER JOIN movie mov ON mov.id = mm.id_movie  
GROUP BY m.id 
```
==>  Dữ liệu lấy được:
![cau02](/day08/cau02.JPG)

---

3. **Liệt kê các phim thuộc loại TV Series đã hoàn thành (current_episode = episode)**
```sql
SELECT m.title , m.episode , m.current_episode 
FROM movie m INNER JOIN title_type tt 
ON m.id_title_type = tt.id 
WHERE tt.name = 'TV Series' AND m.current_episode = m.episode 
```
==>  Dữ liệu lấy được:
![cau03](/day08/cau03.JPG)

---

4. **Liệt kê tên phim và trailer có trạng thái active của phim đó**
```sql
SELECT m.title AS 'Movie title' , mt.status AS 'Trailer status'
FROM movie m INNER JOIN movie_trailer mt 
ON m.id = mt.id_movie 
INNER JOIN trailer t ON t.id = mt.id_trailer 
WHERE mt.status = 'active' 
```
==>  Dữ liệu lấy được:
![cau04](/day08/cau04.JPG)
![cau04](/day08/cau04(2).JPG)

---

5. **Liệt kê tiêu đê, mô tả, poster, độ dài và điểm imdb của các phim thuộc loại Movie và sắp xếp theo điểm imdb giảm dần**
```sql
SELECT m.title AS 'Movie title' , m.description AS Description , m.poster AS Poster , m.`length` , m.imdb  
FROM movie m INNER JOIN title_type tt ON m.id_title_type = tt.id 
WHERE tt.name = 'Movie'
ORDER BY m.imdb DESC 
```
==>  Dữ liệu lấy được:
![cau05](/day08/cau05.JPG)

---

6. **Liệt kê tiêu đề, mô tả, poster, độ dài, thể loại (bảng genres - trả về dữ liệu dạng array), số tập và số tập đã công chiếu, của các phim thuộc loại TV mini Series, sắp xếp theo ngày công chiếu mới nhất**
```sql
SELECT m.title AS 'Movie title' , m.description AS Description , m.release_date , m.poster AS Poster , m.`length` , 
	   JSON_ARRAYAGG(g.name) AS Genres , m.episode , m.current_episode 
FROM movie m INNER JOIN movie_genres mg 
ON m.id = mg.id_movie 
INNER JOIN genres g ON g.id = mg.id_genres  
INNER JOIN title_type tt ON m.id_title_type = tt.id
WHERE tt.name = 'TV mini Series'
GROUP BY m.id
ORDER BY release_date DESC 
```
==>  Dữ liệu lấy được:
![cau06](/day08/cau06.JPG)
![cau06](/day08/cau06(2).JPG)

---

7. **Liệt kê tiêu đề, mô tả, đạo diễn, biên kịch (array), poster, độ dài, thể loại (bảng genres - trả về dữ liệu dạng array), tên diễn viên (array) của các phim thuộc loại Movie của 10 bộ phim có điểm imdb cao nhất**
```sql
SELECT m.title AS 'Movie title' , m.description AS Description , JSON_ARRAYAGG(w.full_name) AS Writers  , m.poster AS Poster , JSON_ARRAYAGG(g.name) AS Genres,
	   JSON_ARRAYAGG(a.full_name) AS Actors , m.imdb AS Imdb 
FROM movie m INNER JOIN movie_writers mw 
ON m.id = mw.id_movie 
INNER JOIN writers w ON w.id = mw.id_writer 
INNER JOIN movie_actor ma ON m.id = ma.id_movie 
INNER JOIN actor a ON a.id = ma.id_actor 
INNER JOIN movie_genres mg ON m.id = mg.id_movie
INNER JOIN genres g ON g.id = mg.id_genres 
INNER JOIN title_type tt ON m.id_title_type = tt.id
WHERE tt.name = 'Movie'
GROUP BY m.id 
ORDER BY m.imdb DESC 
LIMIT 10 
```
==>  Dữ liệu lấy được:
![cau07](/day08/cau07.JPG)