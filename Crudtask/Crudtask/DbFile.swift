
import SQLite3
import Foundation


class sqlite{
    var db:OpaquePointer?
    var dbpath = "Bharath1.sqlite"
    
    init(){
        db = OpenDataBase()
    }

    
    
    func OpenDataBase() -> OpaquePointer?{
        var filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbpath)
        print("file path = ")
        print(filePath)
        var openDbOpaque : OpaquePointer? = nil
        if sqlite3_open(filePath.path, &openDbOpaque) != SQLITE_OK{
            print("err")
            return nil
        }
        else{
            return openDbOpaque
        }
        
    }
    
    func createTable(){

    }
    
}


/*

 class ViewController: UIViewController {

     var db: OpaquePointer?

     override func viewDidLoad() {
         super.viewDidLoad()

         let dbPath = getDatabasePath()
         if sqlite3_open(dbPath, &db) != SQLITE_OK {
             print("Unable to open database")
             return
         }

         print("Successfully opened connection to database at \(dbPath)")
         createTable()
         
         insertUser(name: "John Doe", email: "john@example.com")
         fetchUsers()
     }

     func getDatabasePath() -> String {
         let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
         let fileUrl = documentDirectory.appendingPathComponent("myDatabase").appendingPathExtension("sqlite3")
         return fileUrl.path
     }

     func createTable() {
         let createTableString = """
         CREATE TABLE IF NOT EXISTS Users(
         Id INTEGER PRIMARY KEY AUTOINCREMENT,
         Name CHAR(255),
         Email CHAR(255));
         """

         var createTableStatement: OpaquePointer?
         if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
             if sqlite3_step(createTableStatement) == SQLITE_DONE {
                 print("Table created successfully")
             } else {
                 print("Table could not be created")
             }
         } else {
             print("CREATE TABLE statement could not be prepared")
         }
         sqlite3_finalize(createTableStatement)
     }

     func insertUser(name: String, email: String) {
         let insertStatementString = "INSERT INTO Users (Name, Email) VALUES (?, ?);"
         var insertStatement: OpaquePointer?

         if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
             sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
             sqlite3_bind_text(insertStatement, 2, (email as NSString).utf8String, -1, nil)

             if sqlite3_step(insertStatement) == SQLITE_DONE {
                 print("Successfully inserted row")
             } else {
                 print("Could not insert row")
             }
         } else {
             print("INSERT statement could not be prepared")
         }
         sqlite3_finalize(insertStatement)
     }

     func fetchUsers() {
         let queryStatementString = "SELECT * FROM Users;"
         var queryStatement: OpaquePointer?

         if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
             while sqlite3_step(queryStatement) == SQLITE_ROW {
                 let id = sqlite3_column_int(queryStatement, 0)
                 let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                 let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))

                 print("Query Result:")
                 print("id: \(id), name: \(name), email: \(email)")
             }
         } else {
             print("SELECT statement could not be prepared")
         }
         sqlite3_finalize(queryStatement)
     }
 }

 */
