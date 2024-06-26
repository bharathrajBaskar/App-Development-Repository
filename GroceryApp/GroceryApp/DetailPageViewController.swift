//
//  DetailPageViewController.swift
//  GroceryApp
//
//  Created by Bharath on 06/06/24.
//

import UIKit
import SkeletonView

class DetailPageViewController: UIViewController {

    @IBOutlet weak var ButtonIncrement: UIButton!
    @IBOutlet weak var ButtonDecrement: UIButton!
    @IBOutlet weak var ButtonAddToCart: UIButton!
    @IBOutlet weak var LabelPrice: UILabel!
    @IBOutlet weak var LabelNameProduct: UILabel!
    @IBOutlet weak var ProductImagePageControl: UIPageControl!
    @IBOutlet weak var LabelQuantity: UILabel!
    @IBOutlet weak var LabelDescription: UILabel!
    @IBOutlet weak var CollectionViewProduct: UICollectionView!
    @IBOutlet weak var LabelproductName: UILabel!
 //   var ArrayImage = [ProductModel]()
    var wholeArr:ProductModel?
    var imageArr:[String] = []
    var currentpage:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        CollectionViewProduct?.delegate = self
        CollectionViewProduct?.dataSource = self
        CollectionViewProduct.isPagingEnabled = true
      // UserDefaults.standard.removeObject(forKey: "cartItem")
        print("ArrayImage ",wholeArr!.image!)
     
        if let layout = CollectionViewProduct.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
        
        self.LabelPrice.isSkeletonable = true
        self.LabelDescription.isSkeletonable = true
        self.LabelNameProduct.isSkeletonable = true
        self.CollectionViewProduct.isSkeletonable = true
        self.LabelQuantity.isSkeletonable = true
        self.ButtonDecrement.isSkeletonable = true
        self.ButtonIncrement.isSkeletonable = true
        self.ButtonAddToCart.isSkeletonable = true
        self.LabelPrice.showSkeleton()
        self.LabelDescription.showSkeleton()
        self.LabelNameProduct.showSkeleton()
        self.ButtonAddToCart.showSkeleton()
       // self.CollectionViewProduct.showSkeleton()
        self.CollectionViewProduct.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray.withAlphaComponent(0.6)), animation: nil, transition: .crossDissolve(0.25))
        self.LabelQuantity.showSkeleton()
        self.ButtonDecrement.showSkeleton()
        self.ButtonIncrement.showSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3,execute: {
            self.setDetails()
        })
        
        
        print("Whole Array",wholeArr)
        
    }
    
    @IBAction func ButtonBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    func setDetails(){
        self.LabelPrice.hideSkeleton()
        self.LabelDescription.hideSkeleton()
        self.LabelNameProduct.hideSkeleton()
        self.CollectionViewProduct.hideSkeleton()
        self.LabelQuantity.hideSkeleton()
        self.ButtonDecrement.hideSkeleton()
        self.ButtonIncrement.hideSkeleton()
        self.ButtonAddToCart.hideSkeleton()
        LabelproductName.text = wholeArr?.name
        LabelQuantity.text = String(01)
      //  LabelDescription.text = wholeArr?.description
        self.imageArr = (wholeArr?.image)! 
        self.LabelNameProduct.text = wholeArr?.name
        if let price = wholeArr?.price_per_kg{
            self.LabelPrice.text = "Price : ₹\(price)"
        }
        
        if let description = wholeArr?.description{
            self.LabelDescription.text = "Description : \(description)"
        }
        if imageArr.count == 1{
            ProductImagePageControl.isHidden = true
        }
        else{
            ProductImagePageControl.numberOfPages = imageArr.count
            ProductImagePageControl.currentPage = 0
        }
        self.CollectionViewProduct.reloadData()
       
    }
    

    @IBAction func ButtonDecrement(_ sender: Any) {
        if LabelQuantity.text != String(1) {
            var quantity = Int(LabelQuantity.text!)
            quantity! -= 1
            LabelQuantity.text? = String(quantity!)
        }
    }
    
    @IBAction func ButtonAdd(_ sender: Any) {
        var quantity = Int(LabelQuantity.text!)
        quantity! += 1
        LabelQuantity.text? = String(quantity!)
        
    }
    @IBAction func ButtonAddTOCart(_ sender: Any) {
        

        guard let product = wholeArr,let productId = product.id , let quantity = Int(LabelQuantity.text ?? "1") else{
            return
        }
        
        var cart = UserDefaults.standard.array(forKey: "addTocart") as? [[String:String]] ?? []
        if let index = cart.firstIndex(where: {
            $0["id"] == productId
        }){
            var existingProduct = cart[index]
            print("ExistingProduct",existingProduct)
            var existingQuantity = Int(existingProduct["quantity"] ?? "1")!
            let newQuantity = quantity + existingQuantity
            if newQuantity <= product.available_quantity! && newQuantity >= 1{
                existingProduct["quantity"] = String(newQuantity)
                cart[index] = existingProduct
                LabelQuantity.text = String(1)
                showAlert(message: "Product quantity updated successfully")
                
            }
            else{
                if let availablequantity = product.available_quantity{
                    showAlert(message: "Product available quantity is greater than the user's quantity \(availablequantity)")
                    return
                }
            }
            
        }
        // prodct not found in the userDefaults
        else{
            if quantity <= product.available_quantity!{
                let newItem: [String: String] = ["id": productId, "quantity": String(quantity), "image": product.image?.first ?? "","name": String(product.name!),"price_per_kg": String(product.price_per_kg!) ,"available_quantity" :String(product.available_quantity!)]
                
                              cart.append(newItem)
                              showAlert(message: "New Item added to the cart")
                LabelQuantity.text = String(1)
            }
            else{
                if let availablequantity = product.available_quantity{
                    showAlert(message: "Product's available quantity is \(availablequantity)")
                     return
                }
             
            }
        }
        UserDefaults.standard.set(cart, forKey: "addTocart")
        print("UserDefaults cart:", UserDefaults.standard.array(forKey: "addTocart"))
        
        
    }
    
    func showAlert(message:String){
        let alertController = UIAlertController(title: "Cart", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
        present(alertController,animated: true,completion: nil)
        
    }
 
   
    
    
}

extension DetailPageViewController:SkeletonCollectionViewDelegate,SkeletonCollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return "productCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("imageArr count" ,imageArr.count)
        return imageArr.count
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = CollectionViewProduct.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath)
        let imageView = cell.viewWithTag(200) as! UIImageView
     
//        let imageArr = wholeArr?.image
//        print("image array",imageArr!)
        let imageUrl = imageArr[indexPath.row]
        if let url = URL(string: imageUrl){
            downloadImage(from: url, imageviewMain: imageView)
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        ProductImagePageControl.currentPage = indexPath.row
    }
    func downloadImage(from url:URL,imageviewMain : UIImageView){
        print("Download started ")
        getData(from: url){data,response,error in
            guard let data = data,error == nil else{return}
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("DownloadFinished")
            DispatchQueue.main.async {
                [weak self] in
                imageviewMain.image = UIImage(data: data)
                imageviewMain.contentMode = .scaleAspectFit
            }
            
        }
        
        
    }
    func getData(from url :URL,completion:@escaping(Data?,URLResponse?,Error?)-> ()){
        URLSession.shared.dataTask(with: url,completionHandler: completion).resume()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    

    
}
