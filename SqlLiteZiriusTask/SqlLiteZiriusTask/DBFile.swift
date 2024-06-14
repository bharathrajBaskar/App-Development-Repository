import SQLite3
import Foundation


class Sqlite{
    var Dbpath :String = "usersDb.sqlite"
    var MainDbPointer:OpaquePointer?
    init(){
        MainDbPointer = openDatabase()
        createTable()
    }
    
    
//    func openDatabase() -> OpaquePointer?
//    {
//
//        var FileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(Dbpath)
//        let filUr = FileUrl.deletingLastPathComponent()
//        print("filUr",filUr)
//        UserDefaults.standard.setValue(filUr, forKey: kForFileManagerPath)
//        FileUrl.appendingPathComponent(Dbpath)
//        var localPointer :OpaquePointer? = nil
//        print(FileUrl)
//        if sqlite3_open(FileUrl.path,&localPointer) != SQLITE_OK{
//            print("Error in opening the data Base")
//            return nil
//        }
//        else{
//            print("All set to create ... ")
//            return localPointer
//        }
//    }
    func openDatabase() -> OpaquePointer? {
        do {

            let documentsUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            UserDefaults.standard.setValue(documentsUrl.absoluteString, forKey: kForFileManagerPath)
            let fileUrl = documentsUrl.appendingPathComponent(Dbpath)
            var dbPointer: OpaquePointer? = nil
            print("Database file URL: \(fileUrl)")
            
            if sqlite3_open(fileUrl.path, &dbPointer) == SQLITE_OK {
                print("Successfully opened connection to database at \(fileUrl.path)")
                return dbPointer
            } else {
                print("Unable to open database.")
                return nil
            }
        } catch {
            print("Error in file URL construction: \(error.localizedDescription)")
            return nil
        }
    }


    
    func createTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS newusers (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT,
                date_of_birth DATE,
                phone_no TEXT CHECK (LENGTH(phone_no) = 10),
                image TEXT,
                email TEXT UNIQUE
            );
        """

        var localPointer: OpaquePointer?
        if sqlite3_prepare_v2(MainDbPointer, createTableString, -1, &localPointer, nil) == SQLITE_OK {
            if sqlite3_step(localPointer) == SQLITE_DONE {
                print("Table created successfully")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(MainDbPointer)!)
                print("Failed to create table: \(errorMessage)")
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(MainDbPointer)!)
            print("Failed to prepare create table statement: \(errorMessage)")
        }

        sqlite3_finalize(localPointer)
    }


    func insertUser(name: String, date_of_birth: Date, phone_no: String, image: String, email: String) -> Bool {
        let insertStatement = """
            INSERT INTO newusers(name, date_of_birth, phone_no, image, email) VALUES (?, ?, ?, ?, ?);
        """
        var localPointer: OpaquePointer?

        if sqlite3_prepare_v2(MainDbPointer, insertStatement, -1, &localPointer, nil) == SQLITE_OK {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/M/yyyy"
            let dobString = dateFormatter.string(from: date_of_birth)

           // let dobString = DateFormatter.localizedString(from: date_of_birth, dateStyle: .medium, timeStyle: .none)
            // sqlite3_bind_text(localPointer, 2, (dobString as NSString).utf8String, -1, nil)
       
            sqlite3_bind_text(localPointer, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(localPointer, 2, (dobString as NSString).utf8String, -1, nil)
            sqlite3_bind_text(localPointer, 3, (phone_no as NSString).utf8String, -1, nil)
            sqlite3_bind_text(localPointer, 4, (image as NSString).utf8String, -1, nil)
            sqlite3_bind_text(localPointer, 5, (email as NSString).utf8String, -1, nil)

            if sqlite3_step(localPointer) == SQLITE_DONE {
                print("Inserted Successfully")
                sqlite3_finalize(localPointer)
                return true
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(MainDbPointer)!)
                print("Failed to insert user: \(errorMessage)")
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(MainDbPointer)!)
            print("Failed to prepare insert statement: \(errorMessage)")
        }

        sqlite3_finalize(localPointer)
        return false
    }

    func fetchUserAndStoreitinArrayOfDict() {
        let query = """
            SELECT id,name, date_of_birth, phone_no, image, email FROM newusers;
        """
        var localPointer: OpaquePointer?

        if sqlite3_prepare_v2(MainDbPointer, query, -1, &localPointer, nil) == SQLITE_OK {
            while sqlite3_step(localPointer) == SQLITE_ROW {
                var userDict = [String: String]()
                let id = String(cString: sqlite3_column_text(localPointer, 0))
                let name = String(cString: sqlite3_column_text(localPointer, 1))
                let dateOfBirth = String(cString: sqlite3_column_text(localPointer, 2))
                let phoneNo = String(cString: sqlite3_column_text(localPointer, 3))
                let image = String(cString: sqlite3_column_text(localPointer, 4))
                let email = String(cString: sqlite3_column_text(localPointer, 5))
                
                userDict["id"] = id
                userDict["name"] = name
                userDict["date_of_birth"] = dateOfBirth
                userDict["phone_no"] = phoneNo
                userDict["image"] = image
                userDict["email"] = email
                
         
                globalUserArrayOfDictionary.append(userDict)
                print(globalUserArrayOfDictionary)
                
            }
            
   
            sqlite3_finalize(localPointer)
        } else {
            print("Failed to prepare SELECT statement")
        }
    }
    
    func fetchUserAndReturnArray() -> [[String: String]] {
            let query = """
                SELECT id,name, date_of_birth, phone_no, image, email FROM newusers;
            """
            var localPointer: OpaquePointer?
            var userArray: [[String: String]] = []

            if sqlite3_prepare_v2(MainDbPointer, query, -1, &localPointer, nil) == SQLITE_OK {
                while sqlite3_step(localPointer) == SQLITE_ROW {
                    var userDict = [String: String]()
                    let id = String(cString: sqlite3_column_text(localPointer, 0))
                    let name = String(cString: sqlite3_column_text(localPointer, 1))
                    let dateOfBirth = String(cString: sqlite3_column_text(localPointer, 2))
                    let phoneNo = String(cString: sqlite3_column_text(localPointer, 3))
                    let image = String(cString: sqlite3_column_text(localPointer, 4))
                    let email = String(cString: sqlite3_column_text(localPointer, 5))
                    userDict["id"] = id
                    userDict["name"] = name
                    userDict["date_of_birth"] = dateOfBirth
                    userDict["phone_no"] = phoneNo
                    userDict["image"] = image
                    userDict["email"] = email
                    userArray.append(userDict)
                }
                sqlite3_finalize(localPointer)
            } else {
                print("Failed to prepare SELECT statement")
            }
            return userArray
        }
    
    

    func DeleteanItemDb(email :String) -> Bool{
        var localPointer:OpaquePointer?
        var deleteQuery = """
 DELETE FROM newusers where email = ?
 """
        if sqlite3_prepare(MainDbPointer, deleteQuery, -1, &localPointer, nil) == SQLITE_OK{
            sqlite3_bind_text(localPointer, 1, (email as NSString).utf8String, -1, nil)
            if sqlite3_step(localPointer) == SQLITE_DONE{
                sqlite3_finalize(localPointer)
                return true
            }
            else{
                let errorString = String(cString: sqlite3_errmsg(MainDbPointer))
                print("Failed to delete user: \(errorString)")
            }
        }
        else{
            let errorString = String(cString: sqlite3_errmsg(MainDbPointer))
            print("Failed to prepare statement : \(errorString)")
        }
        sqlite3_finalize(localPointer)
           return false
    }

    func updateUserDetails(email: String, newName: String, newPhoneNo: String, newImagePath: String) -> Bool {
        var localPointer: OpaquePointer?
        let updateQuery = """
        UPDATE newusers SET name = ?, phone_no = ?, image = ? WHERE email = ?
        """
        
        if sqlite3_prepare(MainDbPointer, updateQuery, -1, &localPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(localPointer, 1, (newName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(localPointer, 2, (newPhoneNo as NSString).utf8String, -1, nil)
            sqlite3_bind_text(localPointer, 3, (newImagePath as NSString).utf8String, -1, nil)
            sqlite3_bind_text(localPointer, 4, (email as NSString).utf8String, -1, nil)
            
            if sqlite3_step(localPointer) == SQLITE_DONE {
                sqlite3_finalize(localPointer)
                return true
            } else {
                let errorString = String(cString: sqlite3_errmsg(MainDbPointer))
                print("Failed to update user: \(errorString)")
            }
        } else {
            let errorString = String(cString: sqlite3_errmsg(MainDbPointer))
            print("Failed to prepare statement: \(errorString)")
        }
        
        sqlite3_finalize(localPointer)
        return false
    }

    
}
