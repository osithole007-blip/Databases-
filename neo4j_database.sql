CREATE(member:Member{memberID:1,firstName:'Nayeon',lastName:'Sithole',email:'
nayeonxolwethu@gmail.com',phoneNo:'0123456789'});
CREATE(member:Member{memberID:2,firstName:'Sana',lastName:
'Minatozakiu',email:'sana.minatozakiu@gmail.com',phoneNo:'0987654321'});

CREATE(author:Author{authorID:202,firstName:'Zenistu',lastName:'Jackson'});
CREATE(author:Author{authorID:201,firstName:'Tanjiro',lastName:'Kamado'});

CREATE (book:Book{ISBN:3213567843,title:'Computer
Networking',publicationYear:date('2007-01-01')});
CREATE (book:Book{ISBN:4423567843,title:'Engineering in
Mathematics',publicationYear:date('2001-02-01')});

CREATE (bookAuthor:BookAuthor{authorID: 201,ISBN: 3213567843});
CREATE (bookAuthor:BookAuthor{authorID: 202,ISBN: 4423567843});

CREATE (borrowed:BorrowedBooks{dateBorrowed:date('2026-02-
03'),dueDate:date('2026-03-01'),returnDate:date('2026-03-11'),fineAmount:60});
CREATE (borrowed:BorrowedBooks{dateBorrowed:date('2026-05-
05'),dueDate:date('2026-06-01'),returnDate:date('2026-06-12'),fineAmount:65});

MATCH(a:Author{authorID:202})
MATCH(b:Book{ISBN:4423567843})
CREATE(a)-[:WRITES]->(b);
MATCH(t:Author{authorID:201})
MATCH(f:Book{ISBN:3213567843})
CREATE(t)-[:WRITES]->(f);

MATCH(bb:BorrowedBooks{dateBorrowed:date('2026-05-05')})
MATCH(b:Book{ISBN:3213567843})
MATCH(m:Member{firstName:'Nayeon'})
CREATE(m)-[:BORROWED]->(bb)
CREATE(bb)-[:FOR_BOOK]->(b);
MATCH(bb2:BorrowedBooks{dateBorrowed:date('2026-02-03')})
MATCH(b2:Book{ISBN:4423567843})
MATCH(m2:Member{firstName:'Sana'})
CREATE(m2)-[:BORROWED]->(bb2)

MATCH (n)-[r]->(m)
RETURN n, r, m;

MATCH (m:Member)-[:BORROWED]->(bb:BorrowedBooks)-[:FOR_BOOK]->(b:Book)
RETURN m.memberID As MemberID, m.lastName AS LastName,m.firstName As
FirstName, b.title As BookTitle, bb.dateBorrowed As BorrowedDate, bb.dueDate As
DueDate, bb.returnDate As ReturnDate, bb.fineAmount As FineAmount ;

MATCH(a:Author)-[ :WRITES]->(b:Book)
WHERE a.authorID = 201
RETURN a.authorID,a.firstName,a.lastName, count(b.title) as
NumberOfBooksByAuthorID_201 

MATCH (m:Member)-[:BORROWED]->(bb:BorrowedBooks)
MATCH (bb:BorrowedBooks)-[ :FOR_BOOK]->(b:Book)
WHERE bb.returnDate = 'null'
RETURN m.memberID As MemberIdentity, b.title As BookHasNotBeenReturned,
b.ISBN As ISBN, bb.returnDate

