from flask import Flask, render_template, request, redirect, url_for, jsonify
from datetime import date, timedelta
import connect, mysql.connector
connection = None
dbconn = None

app = Flask(__name__)
# get connection to server
def getCursor():
    global dbconn
    global connection
    if dbconn == None:
        connection = mysql.connector.connect(user=connect.dbuser, \
        password=connect.dbpass, host=connect.dbhost, \
        database=connect.dbname, autocommit=True)
        dbconn = connection.cursor()
        return dbconn
    else:
        return dbconn
# home route - select staff or public access
@app.route("/")
def home():
    return render_template("home.html")

# staff route
@app.route("/staff")
def staff():
    return render_template("staff.html")

# staff searching book route
@app.route("/staff/book", methods=['GET'])
def bookdetails():
    # return all available books
    if "bookid" not in dict.keys(request.args):
        cur = getCursor()
        cur.execute("SELECT BookId, Title, AuthorName FROM Book LEFT JOIN Author ON Book.Author = Author.AuthorId ORDER BY Title ASC;")
        select_result = cur.fetchall()
        column_names = [desc[0] for desc in cur.description]
        return render_template("staff_books.html", dbresult=select_result,dbcols=column_names)
    else: 
        book_id = request.args.get("bookid")
        #redirect back to staff/book if bookid has no value
        if book_id == '' :
            return redirect("/staff/book")
        #if condition met, returning information of the selected book 
        else:
            cur = getCursor()
            cur.execute("""SELECT Book.BookId, Book.Title, Book_Copies.BranchId, Library_Branch.BranchName, 
            case when max(Book_Loans.DueDate) is NULL Then 'N/A' else max(Book_Loans.DueDate) end as DueDate,
            case when sum(case when returned = 0 then 1 else 0 end) < No_Of_Copies then 'Available' else 'Unavailable' end as Availability
            FROM Book Left Join Book_Copies
            ON Book.BookId = Book_Copies.BookId
            LEFT JOIN Book_Loans
            ON Book_Loans.BookId = Book_Copies.BookId 
            AND Book_Loans.BranchId = Book_Copies.BranchId
            LEFT JOIN Library_Branch
            ON Library_Branch.BranchId = Book_Copies.BranchId
            WHERE Book.BookId = %s
            GROUP BY Book_Copies.BranchId;""",(str(book_id),))
            select_result = cur.fetchall()
            column_names = [desc[0] for desc in cur.description]
            return render_template("staff_book_item.html", dbresult=select_result,dbcols=column_names)
    cur.close()

@app.route("/staff/checkout", methods=['GET','POST'])
def checkout():
    #library staff keyed in details and it is uploaded into the database
    if request.method == "POST":
        print(request.form)
        book_id = request.form.get("book_id")
        branch_id = request.form.get("branch_id")
        card_no = request.form.get("card_no")
        today = date.today()
        duedate = date.today() + timedelta(days=28)
        cur = getCursor()
        cur.execute("INSERT INTO Book_Loans (BookId, BranchId, CardNo, DateOut, DueDate, returned) VALUES (%s,%s,%s,%s,%s,%s);",(book_id,branch_id,card_no,today,duedate, 0))
        return redirect("/staff")
    #validation - check if there are values for bookid or branchid, else it routes back to previous page 
    else:
        book_id = request.args.get("bookid")
        branch_id = request.args.get("branchid")
        if book_id == '' or branch_id == '':
            return redirect("/staff/book")
    #staff checking out books, card no has to be manually key in by staff for the borrower. 
    #Due date will be automatically generated and this variable, book title and branch name is hidden
        else:     
            cur = getCursor()
            cur.execute("SELECT Title, BookId FROM Book WHERE BookId = %s;",(str(book_id),))
            select_title = cur.fetchone()
            cur.execute("SELECT BranchName, BranchId FROM Library_Branch WHERE BranchId = %s;",(str(branch_id),))
            select_branch = cur.fetchone()
            print (select_title)
            return render_template("staff_checkout.html", select_title=select_title,select_branch=select_branch)
    cur.close()

@app.route("/staff/borrower", methods=['GET'])
def borrower():
    if {"searchby", "value"} > dict.keys(request.args):
        return render_template("staff_borrower.html")
    else:
        search_by = request.args.get("searchby")
        borrower = request.args.get("value")
        if search_by == '' or borrower == '':
            return render_template("staff_borrower.html")
        # fetch from database based on borrower's name or card number and display borrower's details
        # books that have not been returned (value 0) can be routed to return book page
        else:
            cur = getCursor()
            cur.execute(f"""SELECT 
            Borrower.Name, Borrower.CardNo, Book.BookId, Book.Title, Library_Branch.BranchId, Library_Branch.BranchName, 
            Book_Loans.DateOut, Book_Loans.DueDate, Book_Loans.returned,  
            case when Book_Loans.returned = 1 Then 'N/A' else Book_Loans.DueDate < DATE(NOW()) end as Overdue
            FROM Borrower 
            LEFT JOIN Book_Loans
            ON Book_Loans.CardNo = Borrower.CardNo
            LEFT JOIN Book
            ON Book_Loans.BookId = Book.BookId
            LEFT JOIN Library_Branch
            ON Book_Loans.BranchId = Library_Branch.BranchId
            WHERE Borrower.{search_by} = '{borrower}';""")
            select_result = cur.fetchall()
            column_names = [desc[0] for desc in cur.description]
            return render_template("staff_borrower.html", dbresult=select_result,dbcols=column_names)    

@app.route("/staff/borrower/return", methods=['GET','POST']) 
def returns():
# update the details to the database for book returns
    if request.method == 'POST':
        BookId = request.form.get('BookId')
        CardNo = request.form.get('CardNo')
        BranchId = request.form.get('BranchId')
        cur = getCursor()
        cur.execute("UPDATE Book_Loans SET returned=1 where BookId=%s and BranchId=%s and CardNo=%s;",(str(BookId),str(BranchId),str(CardNo),))
        return redirect("/staff/borrower")
    else:
        bookid = request.args.get('BookId')
        branchid = request.args.get('BranchId')
        cardno = request.args.get('CardNo')
        # validation - if card number has no value, redirect back
        if cardno == '':
            return redirect("/")
        # fetch information from database for updating the returns and render a template for user to check 
        else:
            cur = getCursor()
            cur.execute("SELECT * FROM Book_Loans WHERE BookId=%s and BranchId=%s and CardNo=%s;",(str(bookid),str(branchid),str(cardno),))
            select_result = cur.fetchall()
            return render_template('staff_returnbooks.html', dbresult=select_result)

@app.route("/staff/overdue", methods=['GET'])
def overdue():
    # fetch from database all overdue books
    cur = getCursor()
    cur.execute("""SELECT Book_Loans.BookId, Book.Title, Library_Branch.BranchId, Library_Branch.BranchName, 
    Book_Loans.DateOut, Book_Loans.DueDate, DATEDIFF(DATE(NOW()) , DueDate) AS DaysOverdue, Borrower.CardNo,Borrower.Name AS BorrowerName
    FROM Book_Loans LEFT JOIN Book
    ON Book_Loans.BookId = Book.BookId
    LEFT JOIN Library_Branch
    ON Book_Loans.BranchId = Library_Branch.BranchId
    LEFT JOIN Borrower
    ON Book_Loans.CardNo = Borrower.CardNo
    WHERE Book_Loans.returned = 0 AND DueDate < DATE(NOW())
    ORDER BY DaysOverdue DESC;""")
    select_result = cur.fetchall()
    column_names = [desc[0] for desc in cur.description]
    return render_template("staff_overdue.html", dbresult=select_result,dbcols=column_names)

@app.route("/public", methods=['GET','POST'])
def public():
    # fetch from database and display all books
    cur = getCursor()
    cur.execute("SELECT BookId, Title, AuthorName FROM Book LEFT JOIN Author ON Book.Author = Author.AuthorId ORDER BY Title ASC;")
    select_result = cur.fetchall()
    column_names = [desc[0] for desc in cur.description]
    return render_template("public.html", dbresult=select_result,dbcols=column_names)
    cur.close()


@app.route("/public/book", methods=['GET','POST'])
def publicbook():
    # validation - if bookid does not exist, reroute link
    book_id = request.args.get("bookid")
    if book_id == '':
        return redirect("/public")
    # fetch book details from database and show book information with branchname, duedate and availability
    else: 
        cur = getCursor()
        cur.execute("""SELECT Book.BookId, Book.Title, Book_Copies.BranchId, Library_Branch.BranchName, 
        case when max(Book_Loans.DueDate) is NULL Then 'N/A' else max(Book_Loans.DueDate) end as DueDate, 
        case when sum(case when returned = 0 then 1 else 0 end) < No_Of_Copies then 'available' else 'unavailable' end as availability
        FROM Book Left Join Book_Copies
        ON Book.BookId = Book_Copies.BookId
        LEFT JOIN Book_Loans
        ON Book_Loans.BookId = Book_Copies.BookId 
        AND Book_Loans.BranchId = Book_Copies.BranchId
        LEFT JOIN Library_Branch
        ON Library_Branch.BranchId = Book_Copies.BranchId
        WHERE Book.BookId = %s
        GROUP BY Book_Copies.BranchId;""",(str(book_id),))
        select_result = cur.fetchall()
        column_names = [desc[0] for desc in cur.description]
        return render_template("publicbook.html", dbresult=select_result,dbcols=column_names)
    cur.close()
