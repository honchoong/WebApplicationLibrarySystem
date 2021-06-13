# WebApplicationLibrarySystem
COMP636 Library Web Application Project - Hon Choong (1116307)

The library system that was created is based on skills thought during the course. A mix of python, html, javascript, css and sql querying was used for this project and a few assumptions had to be made from the library.sql data.

On the home page that I have created, there are two buttons that allow different type of access the the library application based on permission type. The one in green is for Public access and the grey icon is for the staff access, which routes them to their respective links. All pages thereafter would have a "Back" button which routes them to the previous page.

The public access links directly to the "public" page, whereby they are immediately able to see the Title and the Author Name of each book that is in the library database. They are able to filter the page by using the "search" function on the top bar of the page. The filter bar acts as a "LIKE" function for MySql but through the use of javascript. This is client side filtering, whereby it compares the data that was added to the search bar and compare that to each line and iterate the function till all entries have been compared and finally showing all records that have the word or part of the word in the title. This function excludes filtering based on author name.

Once the user clicks on a title from the public page, it will navigate to the "public/book" page. This will show the selected book's title and its attribute based on Title, Branch Name, Due Date (if applicable) and availability. The Due Date would only be displayed when this particular book copy is unavailable.

From the home page, if the staff button was used, it would route them to the staff menu which displays 3 different routing buttons based on what the user would need to achieve. These buttons have amalgamated functions to simplify the need of repeated coding. The first button among the three is the "View & Checkout Books" where it is routed to "/staff/book", which the name suggests, allows for viewing all the books in the database and allowing the staff user to checkout the book if they are available.

This function has a if & else statement to allow different templates to be displayed, depending on the url argument (bookid) in the if & else statement. Once a selected book is clicked on the page, it would route them to the selected book's information, where the staff would then decide upon which of the book they would like to checkout based on the Branch Name and siimlar to the due date viewed by the public page, the unavailable book do not have a hyperlink to the book checkout page. The availability column is a calculated field that is fetched by MySQL through the use of "case when sum(case when returned = 0 then 1 else 0 end) < No_Of_Copies then 'Available' else 'Unavailable' end as Availability".

Once the staff has chosen the correct book with the correct associating library branch for checkout, then it would route them to the book's checkout page. The Book Title and Branch Name are disabled, therefore they can not be changed by the users. This is to limit human handling error during the checkout procedure. The user would have to input the "Card No" into the textbox to specify the borrower. When the details has been checked by the user, they can hit the submit button and that would execute a query to the database and update the information accordingly. This would subsequently route them back to the Library Staff Menu (/staff) as well.

The second button in the Staff Menu is the "View Borrower Details & Returns", whereby it is also an amalgamation of two functionalities(Viewing Borrower's Records & Returning a Book). The reasoning behind combining these two functionalities is because they both require the ability to fetch data back from the database, whereby the requested data are from a very similar query. On top of that, it would make sense that once the staff are able to look at the books, then they can potentially be able to return the books as well. 

This routes them to a page for the user to input either the Card No or Borrower's Name for running the two above functionality. The user would have to determine which one of the two they would like to search for in the database. Once they have selected their chosen search parameter, they would have to input the value to finish the search query. When the search query completes, it would display on the page the borrower's checkout history containing information such as the title of the book, library branch, checkout date, due date and if any of the books have been returned. If the book has not been returned, the hyperlinks on the title will be active and vice versa for when the book has been returned.

The hyperlink of the title would route the user to the book return page for that particular book and then the text field on the screen will be automatically populated with the Card No, Book Id and Branch Id. The user would be able to cross reference the information if it has been populated correctly and once they are ready to push the infromation through, they can hit the "Return Book!" button to execute the update function in the database. This would route them back to the Borrower's Details & Returns page as it is the most logical routing.

The last button on the staff menu is the "Overdue Books" and as the name suggests, it would show all books that are overdue (more than 28days). This runs a query that compares the due date & the date today by using the DATEDIFF() for the comparison tool on DATE(NOW()) against the database's DueDate and it is generated on a calculated field called "DaysOverdue". 

There were some limiting factors while creating the routes, such as lack of knowledge and the library data limiting the flexibility of coding. This is evident by the route linkage between the staff's view all book page(staff/book/bookid=?) to the staff's book checkout(staff/checkout). The library dataset did not consist of a unique identifier for each book, meaning when a book is only identified based on its name. I had to work around this limitation through fetching other information such as its branchid or branchname. This is not a good practice as although logically someone would not checkout the same book from the same branch or even different branches for that matter, it would be impossible to differentiate which one of the two of the book were to be returned. This is not much of an issue for a library but could have repercussions in another applications and it can be improved by allocating a bookid for each book.

When there are both GET and POST methods in a function, there is a validation process coded in and this will request a GET arguement string and compare that in the URL, if the string returned does not have any data or does not contain the right information, then it would reroute it back to the previous or same page depending on the scenario.