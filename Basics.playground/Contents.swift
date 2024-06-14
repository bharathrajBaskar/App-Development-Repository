//var arr1:[Int] = [1,2,3,4,5,6]
//
//for (index,x) in arr1.enumerated(){
//    if x % 2 == 0{
//        print("\(x) is even with index \(index) ")
//    }       else{
//     print("\(x) is odd with index \(index) ")
//    }
//}
//
//var dict :[ Int:Int] = [1:0,2:20,3:30,4:40]
//print(dict)
//print("getting the value from the dict",dict[1])
//var var1 = dict[1]
//if var varr1 = dict[1]
//{
//    print("it is no \(varr1)")
//
//}
//else{
//    print("it is not an no   ")
//}
//
//for _ in 1...5{
//    print("hi")
//}
//
//
//var name : String{
//    return "      "
//}
//

import Foundation
////name = "vicky"
//
//
//print(name)
//
//
//class Circle {
//   var radius = 12.5
//
//   var area: String {
//      return "of rectangle for \(radius) "
//   }
//}
//
//class Rectangle: Circle {
//   var print = 7
//   override var area: String {
//      return super.area + " is now overridden as \(print)"
//   }
//}
//
//let rect = Rectangle()
//var circle = Circle()
//rect.radius = 25.0
//rect.print = 3
//print("Radius \(rect.area)" )
//
//class b1{
//    var sum :Int = 0
//    func sum1 (counter1 : Int) -> Int{
//        for counter in 1 ... counter1
//        {
//            sum += counter
//
//        }
//        return sum
//    }
//}
//
//var obj2 = b1()
//print(obj2.sum1(counter1: 10))
//var n = 5
//while  n > 0{
//    print("Bhratha")
//    n-=1
//}
//
//var arrayOfObjects : [[String : String]] = []
//
//var dict1:[String :String] = ["id" : "2001","name":"omni","model":"2012","color":"red","brand":"maruthi"]
//
//var dict2:[String :String] = ["id" : "2002","name":"swift","model":"2013","color":"blue","brand":"maruthi"]
//var dict3:[String :String] = ["id" : "2003","name":"corolla","model":"2014","color":"white","brand":"toyota"]
//arrayOfObjects.append(dict1)
//arrayOfObjects.append(dict2)
//arrayOfObjects.append(dict3)
//print(arrayOfObjects.count)

//
//

class cars{
    var arrayOfDictionary:[[String:String]] = []
    func creationOfArrayofDictionaries()
    {
       
        var dictionary1:[String:String] = ["Id":"1001",
                                           "Name":"Swift",
                                           "Model":"2012",
                                           "Color":"Red",
                                           "Brand":"Maruthi"]
        var dictionary2:[String:String] = ["Id":"1002",
                                           "Name":"Mustang",
                                           "Model":"2014",
                                           "Color":"Black",
                                           "Brand":"Ford"]
        var dictionary3:[String:String] =  ["Id":"1003",
                                            "Name":"Civic",
                                            "Model":"2015",
                                            "Color":"Pink",
                                            "Brand":"Honda"]
        var dictionary4:[String:String] = ["Id":"1004",
                                           "Name":"Corolla",
                                           "Model":"2016",
                                           "Color":"White",
                                           "Brand":"Toyota"]
        var dictionary5:[String:String] = ["Id":"1005",
                                           "Name":"A4",
                                           "Model":"2016",
                                           "Color":"Gray",
                                           "Brand":"Audi"]
        var dictionary6:[String:String] = ["Id":"1006",
                                           "Name":"Swift",
                                           "Model":"2012",
                                           "Color":"Gray",
                                           "Brand":"Maruthi"]
        
        arrayOfDictionary.append(dictionary1)
        arrayOfDictionary.append(dictionary2)
        arrayOfDictionary.append(dictionary3)
        arrayOfDictionary.append(dictionary4)
        arrayOfDictionary.append(dictionary5)
        arrayOfDictionary.append(dictionary6)
        
        print("array of dictionary created successfully..")
        print(arrayOfDictionary)
        
    }
    //count
    func countNoOfRecords()->Int{
        
        var countArray = arrayOfDictionary.count
        
        return countArray
    }
    //search  by id
    func searchById(carId : String)->[String:String]?
    {
        for dictionary in arrayOfDictionary {
            for (key,value) in dictionary{
                if key == "Id"
                {
                    if value == carId{
                        return ["Name": dictionary["Name"]!, "Brand": dictionary["Brand"]!, "Model": dictionary["Model"]!]

                    }
                }
            }
        }
        return nil
    }
    
    func searchByName(_ name :String )->[String:String]?{
        for dictionaryloopName in arrayOfDictionary {
            for (key,value) in dictionaryloopName{
                if key == "Name"{
                    if value == name{
                        return ["Id":dictionaryloopName["Id"]!,
                                "Brand":dictionaryloopName["Brand"]!,
                                "Model":dictionaryloopName["Model"]!,
                                "Color":dictionaryloopName["Color"]!]
                    }
                }
            }
        }
        return nil
    }
    func searchBymodel(modelName model:String)->[[String:String]]{
        var modelNames:[[String:String]] = []
        for dictionary in arrayOfDictionary {
            for (keys,values) in dictionary{
                if keys == "Model"
                {
                    if values == model{
                        var dict1 = ["Id":dictionary["Id"]!,
                                     "Name":dictionary["Name"]!,
                                     "Brand":dictionary["Brand"]!,
                                     "Color":dictionary["Color"]!,
                        ]
                        modelNames.append(dict1)
                    }
                 
                }
            }
        }
        return modelNames
    }
    func searchByColor(_ color:String)->[[String:String]]?
    {
        var colorArray : [[String:String]] = []
        for dictionary in arrayOfDictionary {
            for (keys,values) in dictionary{
                if keys == "Color"{
                    if values == color{
                        var dic1:[String:String] = ["Id":dictionary["Id"]!,
                                    "Name":dictionary["Name"]!,
                                    "Model":dictionary["Model"]!,
                                    "Brand":dictionary["Brand"]!]
                        colorArray.append(dic1)
                    }
                }
            }
        }
        
    
        return colorArray.isEmpty ? nil : colorArray
        
    }
    
    func serachNameAndReturnArray(name : String )-> [ [String :String]]?{
        var nameArray: [[String:String]] = []
        for dictionary in arrayOfDictionary {
            for (keys,values) in dictionary{
                if keys == "Name"
                {
                    if values == name{
                        var nameDict :[String:String] = ["Id":dictionary["Id"]!,
                                                         "Name":dictionary["Name"]!,
                                                         "Model":dictionary["Model"]!,
                                                         "Color":dictionary["Color"]!,
                                                         "Brand":dictionary["Brand"]!]
                        nameArray.append(nameDict)
                    }
                }
            }
        }
        return nameArray
    }

    
}


var object1 = cars()

object1.creationOfArrayofDictionaries()
//print("no of records in an array :",object1.countNoOfRecords())
//var searchByid = object1.searchById(carId: "1004")
//
//if var newArrayId =  searchByid{
//    print("the element is found \(newArrayId)")
//
//}
//else{
//    print("the element is not found")
//}
//
//var searchByName = object1.searchByName("Swift")
//if var name = searchByName{
//    print("the element is found with the name \(name)")
//}
//else{
//    print("the element is not found !!")
//}
//
var searchbyModel = object1.searchBymodel(modelName: "2016")

if searchbyModel.count > 0  {
    print("the element is found with the name \(searchbyModel)")
}
else{
    print("the element is not found")
}
//
//
//var color = object1.searchByColor("Red")
//
//if var colorArray = color{
//    print("color array ",colorArray)
//}
//else{
//    print("it is empty check with the different color")
//}
//
//
//print(" To fetch using name ")
//
//var searchByNamearray = object1.serachNameAndReturnArray(name: "Swift")
//
//if var nameArray = searchByNamearray{
//    print("Name Array \(nameArray)")
//}
//else{
//    print("Name not found ... ")
//}



