//
//  ImagecacheSetup.swift
//  GroceryApp
//
//  Created by Bharath on 21/06/24.
//

import Foundation
import  UIKit

class ImagecacheSetup{
    
    
    static  let shared = ImagecacheSetup()
    private let cache = NSCache<NSString,UIImage>()
    private init(){
        }
    
    func loadImage(url:String,completion:@escaping (UIImage?)-> Void){
        if let cachedImage = cache.object(forKey: url as NSString)
        {
            completion(cachedImage)
            print("imaghe in catch  catch path = \(cachedImage)")
            return
        }
        guard let imageUrl = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl){
            data,response,err in
            if let data = data, let image = UIImage(data: data){
                self.cache.setObject(image, forKey: url as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }else{
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
