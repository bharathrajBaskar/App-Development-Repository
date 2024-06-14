//
//  DbFile.swift
//  GroceryApp
//
//  Created by Bharath on 07/06/24.
//

import Foundation
import SQLite3
class DataBaseFile{
    
    var dbPath :String = "groceryDb.sqlite"
    var MainDataPointer:OpaquePointer?
    
    
    init(){
        MainDataPointer = openDatabase()
        createOrderTable()
        createOrderItemTable()
    }
    
    func openDatabase() -> OpaquePointer?{
        do{
            let documentUrl = try FileManager.default.url(for:.documentDirectory ,in: .userDomainMask,appropriateFor: nil,create: false)
            print("documentUrl",documentUrl)
            
            UserDefaults.standard.setValue(documentUrl.absoluteString, forKey: kForFileManagerPath)
            let fileUrl = documentUrl.appendingPathComponent(dbPath)
            var dbpointer : OpaquePointer? = nil
            if sqlite3_open(fileUrl.path, &dbpointer) == SQLITE_OK{
                print("Successfullt opened the database")
                return dbpointer
            }
            else{
                print("Unable to open the database ")
                return nil
            }
            
        }
        catch{
            print("OpenDatabase catch block")
            return nil
        }
        
    }
    func createOrderTable(){
        let createTableQuery = """
     CREATE TABLE IF NOT EXISTS orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date_of_order DATE,
            no_of_products INTEGER CHECK(no_of_products > 0),
            total_price REAL,
            payment_method TEXT
);

"""
        
        var localPointer:OpaquePointer?
        if sqlite3_prepare_v2(MainDataPointer, createTableQuery, -1, &localPointer, nil) == SQLITE_OK{
            if sqlite3_step(localPointer) == SQLITE_DONE
            {
                print("table created successfully")
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
                print("failed due to create table \(errorMessage)")
            }
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
            print("Failed to prepare create table statement: \(errorMessage)")
        }
        sqlite3_finalize(localPointer)
    }
    
    
    func createOrderItemTable() {
           let createTableQuery = """
           CREATE TABLE IF NOT EXISTS order_item (
               id INTEGER PRIMARY KEY AUTOINCREMENT,
               order_id INTEGER,
               product_id INTEGER,
               product_name TEXT,
               quantity INTEGER,
               imagePath TEXT,
               product_price REAL,
               total REAL,
               FOREIGN KEY (order_id) REFERENCES orders(id)
                
           );
           """
           var localPointer: OpaquePointer?
           if sqlite3_prepare_v2(MainDataPointer, createTableQuery, -1, &localPointer, nil) == SQLITE_OK {
               if sqlite3_step(localPointer) == SQLITE_DONE {
                   print("Table 'order_item' created successfully")
               } else {
                   let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
                   print("Failed to create 'order_item' table: \(errorMessage)")
               }
           } else {
               let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
               print("Failed to prepare create table statement: \(errorMessage)")
           }
           sqlite3_finalize(localPointer)
       }


 
    func insertOrder(date_of_order:String,no_of_products :Int,total_price:Double) -> Bool{
        let nextId = GetId()
        let payment_method = nextId % 2 == 0 ? "cash" :"upi"
        let insertQuery = """
    INSERT INTO orders (date_of_order,no_of_products,total_price,payment_method) values (?,?,?,?);
"""
        var localPointer:OpaquePointer?
   
        
       // let payment_method = id % 2 == 0 ? "cash" : "upi"
        if sqlite3_prepare_v2(MainDataPointer, insertQuery, -1, &localPointer, nil) == SQLITE_OK{
            sqlite3_bind_text(localPointer, 1, (date_of_order as NSString).utf8String, -1, nil)
            sqlite3_bind_int(localPointer, 2, Int32(no_of_products))
            sqlite3_bind_double(localPointer, 3, total_price)
            sqlite3_bind_text(localPointer, 4, (payment_method as NSString).utf8String, -1, nil)
            
            if sqlite3_step(localPointer) == SQLITE_DONE{
                print("Orders table datas inserted successfully")
                sqlite3_finalize(localPointer)
                return true
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
                print("Failed to  insert table : \(errorMessage)")
            }
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
            print("Failed to prepare create table statement: \(errorMessage)")
        }
        sqlite3_finalize(localPointer)
        return false
    }
    
    
    func GetId() -> Int32{
        let query = "SELECT MAX(id) from orders ;"
        var localPointer :OpaquePointer?
        var nextId:Int32 = 1
        if sqlite3_prepare_v2(MainDataPointer, query, -1, &localPointer, nil) == SQLITE_OK{
            if sqlite3_step(localPointer) == SQLITE_ROW{
                if let maxId = sqlite3_column_int(localPointer, 0) as Int32?{
                    nextId = maxId + 1
                }
            }
        }else{
            let errorMessage  = String(cString: sqlite3_errmsg(MainDataPointer)!)
            print("Failed to create the query :\(errorMessage)")
        }
        
        sqlite3_finalize(localPointer)
        return nextId

    }
    
//
//    func getIdOnly() -> Int32{
//        let query = "SELECT MAX(id) FROM orders ;"
//        var localPointer:OpaquePointer?
//        let maxId
//        if sqlite3_prepare_v2(MainDataPointer, query, -1, &localPointer, nil) == SQLITE_OK{
//            if sqlite3_step(localPointer) == SQLITE_ROW{
//                if  maxId = sqlite3_column_int(localPointer, 0) as Int32?{
//                    sqlite3_finalize(localPointer)
//                    return maxId
//                }
//            }
//            else{
//                let errorMessage  = String(cString: sqlite3_errmsg(MainDataPointer)!)
//                print("Failed to create the query :\(errorMessage)")
//            }
//        }
//        sqlite3_finalize(localPointer)
//            return nil
//    }
    
    func getIdOnly() -> Int32? {
        let query = "SELECT MAX(id) FROM orders;"
        var localPointer: OpaquePointer?
        var maxId: Int32? = nil

        if sqlite3_prepare_v2(MainDataPointer, query, -1, &localPointer, nil) == SQLITE_OK {
            if sqlite3_step(localPointer) == SQLITE_ROW {
                maxId = sqlite3_column_int(localPointer, 0)
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
                print("Failed to fetch max id: \(errorMessage)")
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
            print("Failed to prepare query: \(errorMessage)")
        }

      
        sqlite3_finalize(localPointer)
        return maxId
    }
    
    func insertOrderItems(order_id:Int32,product_id:Int,product_name:String,quantity:Int,imagePath:String,product_price:Double,total:Double){
        let insertQuery = """
    INSERT INTO order_item(order_id,product_id,product_name,quantity,imagePath,product_price,total) VALUES(?,?,?,?,?,?,?);
"""
        var localPointer:OpaquePointer?
        if sqlite3_prepare_v2(MainDataPointer, insertQuery, -1, &localPointer, nil) == SQLITE_OK{
            sqlite3_bind_int(localPointer, 1, order_id)
            sqlite3_bind_int(localPointer, 2, Int32(product_id))
            sqlite3_bind_text(localPointer, 3, (product_name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(localPointer, 4, Int32(quantity))
            sqlite3_bind_text(localPointer, 5, (imagePath as NSString).utf8String, -1, nil)
            sqlite3_bind_double(localPointer, 6, product_price)
            sqlite3_bind_double(localPointer, 7, total)
            if sqlite3_step(localPointer) == SQLITE_DONE{
                print("Inserted successFully")
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
                print("Failed to insert  : \(errorMessage)")

            }
            
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
            print("Failed to create the query  : \(errorMessage)")

        }
    }

}
