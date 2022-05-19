# BTVN: day04_JOIN TABLE

* **Lấy ra thông tin tất cả các quyển sách thuộc thể loại comedy hoặc drama:**
```sql
SELECT b.id AS id_book ,b.title AS book, c.id AS id_cate, c.name AS category
FROM book b INNER JOIN book_category bc 
ON b.id = bc.id_book 
INNER JOIN category c 
ON c.id = bc.id_category 
WHERE (c.name = 'Comedy' OR c.name = 'Drama')
```
==>  Dữ liệu lấy được:

![cau01](/day04/cau1.JPG)
- - -
* **Lấy ra id_book, title, author, category của quyển sách được xuất bản từ năm 1800 đến 1900**
```sql
SELECT b.id AS id_book , b.title AS book , a.full_name AS author , c.name AS category   
FROM book b INNER JOIN book_category bc 
ON b.id = bc.id_book 
INNER JOIN category c ON c.id = bc.id_category 
INNER JOIN book_author ba ON b.id = ba.id_book 
INNER JOIN author a ON ba.id_author = a.id 
WHERE year_of_publication BETWEEN 1800 AND 1900
```

==>Dữ liệu lấy được:

![cau02](/day04/cau2.JPG)
- - -

* **Đếm số sách dựa theo nhà xuất bản (Hiển thị tên nhà xuất bản và số sách thuộc nhà xuất bản đó)**
```sql
SELECT p.name AS publisher , COUNT(b.id) AS quantity_book 
FROM book b RIGHT JOIN publisher p ON b.id_publisher = p.id 
GROUP BY p.id 
```

==>Dữ liệu lấy được:

![cau03](/day04/cau3.JPG)
- - -