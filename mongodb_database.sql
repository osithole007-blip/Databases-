use Question2
db.createCollection('Author')
db.createCollection('BookAuthor')
db.createCollection('Book')
db.createCollection('BorrowedBooks')
db.createCollection('Member')

db.Author.insertMany([{authorID:1,
 FirstName: 'Jake',
 lastName: 'Kim'
 },
 {authorID:2,
 FirstName: 'Sam',
 lastName: 'Sung'
 },
 {authorID:3,
 FirstName: 'Jayden',
 lastName: 'Brown'
 }
 ]);
db.BookAuthor.insertMany([{authorID:1,
 ISBN:1922356789
 },
 {authorID:2,
 ISBN:2021456789
 },
 {authorID:3,
 ISBN:6666783231
 }
 ]);
db.Book.insertMany([{ISBN: 1922356789,
 Title: 'Dragon Ball',
 publicationYear: 1981
 },
 {ISBN: 2021456789,
 Title: 'Demon Slayer',
 publicationYear: 2018
 },
 {ISBN:6666783231,
 Title: 'Berserk',
 publicationYear: 2027
 }
 ]);
db.BorrowedBooks.insertMany([
 {
 memberID: 201,
 ISBN: 19,
 dateBorrowed: new Date("2026-01-01"),
 dueDate: new Date("2026-01-11"),
 returnDate: new Date("2026-01-12"),
 fineAmount: 300
 },
 {
 memberID: 202,
 ISBN: 20,
 dateBorrowed: new Date("2026-03-02"),
 dueDate: new Date("2026-03-11"),
 returnDate: new Date("2026-03-22"),
 fineAmount: 500
 },
 {
 memberID: 203,
 ISBN: 6666783231,
 dateBorrowed: new Date("2026-04-02"),
 dueDate: new Date("2026-04-11"),
 returnDate: new Date("2026-04-22"),
 fineAmount: 50
 }
]);

db.Member.insertMany([
{
memberID: 201,
firstName: "Tung",
lastName: "Sahur",
email: "tungtungsahur@gmail.com",
phoneNo: "0987654321"
},
{
memberID: 202,
firstName: "James",
lastName: "Bond",
email: "jamesbond007@gmail.com",
phoneNo: "0123456789"
},
{
memberID: 203,
firstName: "Jarryd",
lastName: "Jackson",
email: "jarryd.jackson@gmail.com",
phoneNo: "0123445643"
}
])

db.Book.find({publicationYear: {$gt: 2026}})

db.BorrowedBooks.aggregate([ {$group: {_id: null,totalamount: {$sum:
"$fineAmount"}}}])

db.Member.aggregate([
 {
 $lookup: {
 from: "BorrowedBooks",
 localField: "memberID",
 foreignField: "memberID",
 as: "borrow"
 }
 },
 {
 $unwind: {
 path: "$borrow",
 preserveNullAndEmptyArrays: true
 }
 },
 {
 $lookup: {
 from: "Book",
 localField: "borrow.ISBN",
 reignField: "ISBN",
 as: "book"
 }
 },
 {
 $unwind: {
 path: "$book",
 preserveNullAndEmptyArrays: true
 }
 },
 {
 $project: {
 _id: 0,
 MemberID: "$memberID",
 FirstName: 1,
 LastName: "$lastName",
 BookTitle: "$book.Title",
 DateBorrowed: "$borrow.dateBorrowed",
 DueDate: "$borrow.dueDate",
 ReturnDate: "$borrow.returnDate",
 FineAmount: "$borrow.fineAmount"
 }
 }
]);

