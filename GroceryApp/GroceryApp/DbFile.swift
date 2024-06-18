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
    
    func fetchOrders() ->[[String:Any]]{
        let selectQuery = """
        SELECT id,date_of_order,total_price,no_of_products from orders ;
"""
        var localPointer:OpaquePointer?
        var orders:[[String:Any]] = []
        if sqlite3_prepare_v2(MainDataPointer, selectQuery, -1, &localPointer, nil) == SQLITE_OK{
            while sqlite3_step(localPointer) == SQLITE_ROW{
                let id  = sqlite3_column_int(localPointer, 0)
                if let dateString = sqlite3_column_text(localPointer, 1){
                    let date = String(cString: dateString)
                    let totalPrice = sqlite3_column_double(localPointer, 2)
                    let noOfProducts = sqlite3_column_int(localPointer, 3)
                    let order : [String:Any] = [
                        "id":Int(id),"date_of_order":date,"total_price":totalPrice,"no_of_products":noOfProducts
                    
                    ]
                    orders.append(order)
                }
            }
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
                    print("Failed to prepare fetch orders statement: \(errorMessage)")
        }
        sqlite3_finalize(localPointer)
        return orders
    }
    
    
    func selectOrderItems(orderId:Int ) -> [[String:Any]]
    {

        let selectQuery = """
          SELECT order_id, product_name, quantity, imagePath, product_price, total FROM order_item WHERE order_id = ?;
          """
          var localPointer: OpaquePointer?
          var orderItems: [[String: Any]] = []

          if sqlite3_prepare_v2(MainDataPointer, selectQuery, -1, &localPointer, nil) == SQLITE_OK {
              sqlite3_bind_int(localPointer, 1, Int32(orderId))

              while sqlite3_step(localPointer) == SQLITE_ROW {
                  let orderId = sqlite3_column_int(localPointer, 0)
                  let productNameCStr = sqlite3_column_text(localPointer, 1)
                  let quantity = sqlite3_column_int(localPointer, 2)
                  let imagePathCStr = sqlite3_column_text(localPointer, 3)
                  let productPrice = sqlite3_column_double(localPointer, 4)
                  let totalPrice = sqlite3_column_double(localPointer, 5)
                  
                  if let productNameCStr = productNameCStr, let imagePathCStr = imagePathCStr {
                      let productName = String(cString: productNameCStr)
                      let imagePath = String(cString: imagePathCStr)

                      let orderItem: [String: Any] = [
                          "orderId": Int(orderId),
                          "productName": productName,
                          "quantity": Int(quantity),
                          "imagePath": imagePath,
                          "productPrice": productPrice,
                          "totalPrice": totalPrice
                      ]
                      orderItems.append(orderItem)
                  }
              }
          } else {
              let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
              print("Failed to prepare fetch orders statement: \(errorMessage)")
          }
          sqlite3_finalize(localPointer)
          return orderItems
    }
    func AggregateTotalFunc(orderId:Int)->Double{
        let query = "Select sum(total) from order_item where order_id = ? "
        var localPointer:OpaquePointer?
        var totalSum : Double = 0.0
        if sqlite3_prepare_v2(MainDataPointer, query, -1, &localPointer, nil) == SQLITE_OK
        {
           // sqlite3_column_int(localPointer, Int32(orderId))
            sqlite3_bind_int(localPointer, 1, Int32(orderId))
            if sqlite3_step(localPointer) == SQLITE_ROW {
                totalSum = sqlite3_column_double(localPointer, 0)
                
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
                            print("Failed to calculate sum: \(errorMessage)")
            }
            
        }
        else {
                let errorMessage = String(cString: sqlite3_errmsg(MainDataPointer)!)
                print("Failed to prepare query: \(errorMessage)")
            }
            
            sqlite3_finalize(localPointer)
            return totalSum
   
    }
    
}
