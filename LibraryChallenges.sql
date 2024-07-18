/******************* In the Library *********************/
use library;
select * from books order by title ;
/*******************************************************/
/* find the number of availalbe copies of the book (Dracula)      */
/*******************************************************/
select count(distinct b.bookid) as number_of_availalbe_copies from books as b inner join loans as l on l.bookid = b.bookid where b.title = "Dracula" and l.returneddate is not null;

/* check total copies of the book */
select title,count(*) as total_copies from books 
group by title
order by title;

/* current total loans of the book */
select b.title,count(l.loanid) as total_loans from loans as l inner join books as b on l.bookid = b.bookid 
group by b.title
order by title;

/* total available books of dracula */
select count(distinct b.bookid) as number_of_availalbe_copies from books as b inner join loans as l on l.bookid = b.bookid where b.title = "Dracula" and l.returneddate is not null;


/*******************************************************/
/* Add new books to the library                        */
/*******************************************************/
select max(bookid) from books;
insert into books (bookid,title,author,published,barcode) values (201,"book201","author201",2024,201201201),
(202,"book202","author202",2024,202202202),(203,"book203","author203",2024,203203203);


/*******************************************************/
/* Check out Books: books(4043822646, 2855934983) whose patron_email(jvaan@wisdompets.com), loandate=2020-08-25, duedate=2020-09-08, loanid=by_your_choice                            */
/*******************************************************/
select * from books as b inner join loans as l on b.bookid = l.bookid inner join patrons as p on l.patronid = p.patronid
where 
 b.Barcode in (4043822646,2855934983)
  and p.email ="jvaan@wisdompets.com"
  and l.LoanDate='2016-06-07'
 and l.DueDate='2016-06-21'
 ;


/********************************************************/
/* Check books for Due back                             */
/* generate a report of books due back on July 13, 2020 */
/* with patron contact information                      */
/********************************************************/
select * from loans as l inner join patrons as p on l.patronid = p.patronid
 where l.returneddate='2020-07-13';

/*******************************************************/
/* Return books to the library (which have barcode=6435968624) and return this book at this date(2020-07-05)                    */
/*******************************************************/
update loans set returneddate='2020-07-05' where returneddate is null and  bookid=(select bookid from books where  Barcode=6435968624);
   




/*******************************************************/
/* Encourage Patrons to check out books                */
/* generate a report of showing 10 patrons who have
checked out the fewest books.                          */
/*******************************************************/
 
 select P.PatronID,p.firstname,p.lastname,p.email, count(l.loanid) as no_of_loans from loans as l
 inner join patrons as p on l.patronid = p.patronid
 group by P.PatronID,p.firstname,p.lastname,p.email
 order by no_of_loans
 limit 10;
 




/*******************************************************/
/* Find books to feature for an event                  
 create a list of books from 1890s that are
 currently available                                    */
/*******************************************************/
select  b.Title, b.Author, b.Published from books as b inner join loans as l on b.BookID=l.BookID 

 where b.published >= 1890 and l.ReturnedDate is not  null
 group by b.title,b.Author,b.published
 order by b.title
;

 
/*******************************************************/
/* Book Statistics 
/* create a report to show how many books were 
published each year.                                    */
/*******************************************************/
SELECT Published, COUNT(DISTINCT(Title)) AS TotalNumberOfPublishedBooks
FROM Books
GROUP BY Published
ORDER BY TotalNumberOfPublishedBooks DESC;


/*************************************************************/
/* Book Statistics                                           */
/* create a report to show 5 most popular Books to check out */
/*************************************************************/


SELECT b.Title, b.Author, b.Published, COUNT(l.loanid) AS TotalTimesOfLoans
FROM Books as b
inner join Loans as l
ON b.BookID = l.BookID
GROUP BY b.Title, b.Author, b.Published
ORDER BY TotalTimesOfLoans DESC
LIMIT 5;

