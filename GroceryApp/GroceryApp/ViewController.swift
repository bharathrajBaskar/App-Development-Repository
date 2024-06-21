//
//  ViewController.swift
//  GroceryApp
//
//  Created by Bharath on 03/06/24.
//

import UIKit

import SkeletonView
class ViewController: UIViewController,UITextFieldDelegate{
    //MARK: this is Outlets
    
    @IBOutlet weak var ViewHiddenInitial: UIView!
    @IBOutlet weak var TextFieldSearch: UITextField!
    @IBOutlet weak var ViewShownInitial: UIView!
    @IBOutlet weak var CollectionViewmain: UICollectionView!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var TableViewHidden: UIView!
    @IBOutlet weak var LabelTitle: UILabel!
    
    
    //MARK: this is Local variables

    let spacing:CGFloat = 16.0
    var initialBool:Bool = true
    var sideBar:UIView!
    var TableView:UITableView!
    var isSideBarOpen:Bool = false
    var arrData:[String] = []
    var arr:[UIImage]! = []
    var LabelMenu:UILabel!
    var Menuimg :UIImageView!
    var ProfilePic:UIImageView!
    var NameLabel:UILabel!
    var profName = "MsDhoni"
    var swipeToRight:UIGestureRecognizer!
    var tabView:UIView!
    var buttonSideBar = UIButton()
    var arrayOfDictionaryApi:[[String:String]] = []
    var detailModel = [ProductModel]()
    var tempModel = [ProductModel]()
   
    
    //MARK: this is cache
    private let cache = NSCache<NSNumber,UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility )
    
    
    //MARK: this is Side menu
    var sideMenuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
    var sideMenuwidth:CGFloat = 260
    var paddingForRotation:CGFloat =  150
    var isExpanded:Bool = false
    var sideMenuShadowView:UIView!
    var draggingIsEnabled:Bool = false
    var panBaseLocation:CGFloat = 0.0
    
    var sideMenuTrailingConstraint: NSLayoutConstraint!
    var revealSideMenuOnTop: Bool = true
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        TextFieldSearch.delegate = self
        
        
        arrData = ["Home","Cart","Language","Logout"]
        arr = [UIImage(named: "Home")!,UIImage(named: "Cart")!,UIImage(named: "Tamil")!,UIImage(named: "Logout")!]
               
        sideBar = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        TableView = UITableView(frame:CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height) )
        self.view.addSubview(sideBar)
        
        TextFieldSearch.returnKeyType = .done
        CollectionViewmain.dataSource = self
        CollectionViewmain.delegate = self
        TableView.dataSource = self
        TableView.delegate = self
        TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        TableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
               
        self.sideBar.addSubview(TableView)
        self.sideBar.backgroundColor = UIColor.black.withAlphaComponent(0.5)
     
                buttonSideBar = UIButton(frame: CGRect(x: 250, y: 100, width: 50, height:  25))
                buttonSideBar.setTitle("Close", for: .normal)
      
        buttonSideBar.backgroundColor = .black
                buttonSideBar.isHidden = true
                buttonSideBar.addTarget(self, action: #selector(closeSideBar), for: .touchUpInside)
        self.sideBar.addSubview(buttonSideBar)
      // apiCall(link: "https://mocki.io/v1/46cc668c-9e1b-45c0-b1a6-a06e0471651b")
       
        
//
//        self.downloadImage(from: URL(string: "https://fastly.picsum.photos/id/851/200/300.jpg?hmac=AD_d7PsSrqI2zi-ubHY_-urUxCN77Gnev3k5o0P6nlE")!)
//        self.downloadImage(from: URL(string: "https://www.researchgate.net/publication/337976820/figure/fig7/AS:1086081361543213@1635953383440/Sample-tomato-images-a-c-Healthy-tomato-d-and-e-Tomato-malformed-fruit-f-Tomato.jpg")!)
        self.CollectionViewmain.isSkeletonable = true
        self.CollectionViewmain.skeletonCornerRadius = 10.0
        
        self.CollectionViewmain.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray.withAlphaComponent(0.6)), animation: nil, transition: .crossDissolve(0.25))
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.apiCall(link: "https://mocki.io/v1/d5ed8298-03ad-4536-a6fa-8a4d57578b2c")
            //self.CollectionViewmain.reloadData()
          
        })
     
        
        
        
        
        self.view.addSubview(sideMenuController.view)
        
        self.sideMenuController.didMove(toParent: self)
        
        self.sideMenuController.view.translatesAutoresizingMaskIntoConstraints = false
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuwidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        
        NSLayoutConstraint.activate([
            self.sideMenuController.view.widthAnchor.constraint(equalToConstant: self.sideMenuwidth),
            self.sideMenuController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black.withAlphaComponent(0.0)
//        self.sideMenuShadowView.alpha
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateToSideMenuAction), name: NSNotification.Name(kNotificationForSideMenuExpanded), object: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TextFieldSearch.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
  //    apiCall(link: "https://mocki.io/v1/4594154b-599b-4ce2-bce8-d7212c82604a")
       
       // self.CollectionViewmain.showAnimatedSkeleton(usingColor: .concrete, transition: .crossDissolve(0.25))
   
       
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let searchFieldText = TextFieldSearch.text as NSString? else{return true}
        let updatedText = searchFieldText.replacingCharacters(in: range, with: string)
        
        if updatedText.isEmpty {
            detailModel = tempModel
        }
        else{
            
            
            detailModel = tempModel.filter({
                $0.name?.lowercased().contains(updatedText.lowercased()) ?? false
            })
        }
        CollectionViewmain.reloadData()
        return true
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }


    
    func downloadImage(from url: URL,imageViewMain:UIImageView,int:NSNumber) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
           // cache.setObject(data, forKey: int)
            DispatchQueue.main.async() { [weak self] in
               imageViewMain.image = UIImage(data: data)
                self!.cache.setObject(imageViewMain.image!, forKey: int)
                imageViewMain.contentMode = .scaleAspectFit
            }
        }
    }
    

    
    func apiCall(link :String){
    let url = URL(string: link)!
    var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlReq){data,response,error in
            if let output = data{
                print("Output",output)
                do{
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode([ProductModel].self, from: output)
                    print("Response Model",responseModel)
                    self.detailModel = responseModel
                    self.tempModel = responseModel
                    arrayOfDatas = responseModel
                    DispatchQueue.main.async {
                        self.CollectionViewmain.stopSkeletonAnimation()
                        
                       self.CollectionViewmain.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                        self.CollectionViewmain.reloadData()
                        //self.CollectionViewmain.reloadData()
                    }
                    
                }
                catch (let err){
                    print("error",err)
                }
            }
        }.resume()
        
    }
    
    @objc func closeSideBar() {
          toggleSideBar()
      }
    
    
    func toggleSideBar() {
          if isSideBarOpen {
              UIView.animate(withDuration: 0.3) {
                  self.sideBar.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                  self.TableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                  self.buttonSideBar.isHidden = true
                  
              }
          } else {
              UIView.animate(withDuration: 0.3) {
                  self.buttonSideBar.isHidden = false
                  self.sideBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 80, height: self.view.bounds.height)
                  self.TableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 80, height: self.view.bounds.height)
                  //self.buttonSideBar.isHidden = true
              }
          }
          isSideBarOpen.toggle()
      }
  
    

    
    @IBAction func HamburgerMenuClicked(_ sender: Any) {
    //  toggleSideBar()
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TempTableViewController") as! TempTableViewController
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: false)
        
//        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController" ) as! SideMenuViewController
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc,animated: false)
        self.sideMenuState(expanded: self.isExpanded ? false : true)
     }
    
    
    @IBAction func SearchButtonClicked(_ sender: Any) {
        print("Initial Bool",initialBool)
        if initialBool
        {
            print("ViewShownInitial",ViewShownInitial.isHidden)
 // ViewShownInitial.isHidden = true
            print("ViewShownInitial",ViewShownInitial.isHidden)
            print("ViewHiddenInitial",ViewHiddenInitial.isHidden)
            TableViewHidden.isHidden = false
            TextFieldSearch.becomeFirstResponder()
            print("ViewHiddenInitial",ViewHiddenInitial.isHidden)

      }
                initialBool.toggle()
        
    }
    
    
    @IBAction func BackButton(_ sender: Any) {
        TextFieldSearch.text?.removeAll()
       detailModel = tempModel
        CollectionViewmain.reloadData()
        TextFieldSearch.resignFirstResponder()
            if !initialBool{
//                    MainView.isHidden = false
//                    TableViewHidden.isHidden = true
                TableViewHidden.isHidden = true
                
                }
           
                initialBool.toggle()
        
    }
    

}


extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            ProfilePic = UIImageView(frame: CGRect(x: 8, y: 8, width: cell1.bounds.height - 10.0 , height: cell1.bounds.height - 10.0 ))
            ProfilePic.contentMode = .scaleAspectFill
//            NameLabel.text = self.profName
            self.ProfilePic.layer.cornerRadius = self.ProfilePic.frame.size.width / 2
            self.ProfilePic.clipsToBounds = true
            ProfilePic.image = UIImage(named: "Msd.jpg")
            cell1.addSubview(ProfilePic)
//            NameLabel.text = self.profName
//            cell1.addSubview(NameLabel)
            return cell1
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
            
            Menuimg = UIImageView(frame: CGRect(x: 8, y: 8, width: cell.bounds.height - 16.0, height: cell.bounds.height - 16.0))
            Menuimg.contentMode = .scaleAspectFit
            Menuimg.image = self.arr[indexPath.row - 1]
            cell.addSubview(Menuimg)
            LabelMenu = UILabel(frame: CGRect(x: self.Menuimg.bounds.width + 16.0 , y:8 , width: cell.bounds.width - (self.Menuimg.bounds.width + 24), height: cell.bounds.height - 16))
            LabelMenu.text = self.arrData[indexPath.row - 1]
            cell.addSubview(LabelMenu)
            
            return  cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            
            return 100.0
        }
        else{
            return 50.0
        }
    }

}

extension ViewController :SkeletonCollectionViewDelegate,SkeletonCollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return "CellMain"
    }
    
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailModel.count
    }
//
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewmain.dequeueReusableCell(withReuseIdentifier: "CellMain", for: indexPath)
//        if let imageView = cell.viewWithTag(100) as? UIImageView,
//           let productName = cell.viewWithTag(101) as? UILabel {
//            let product = detailModel[indexPath.item]
//            print("type of",type(of: product))
//            let imgurl = URL(string: product.image!.first!)
//            //cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 0.6
//               cell.layer.shadowColor = UIColor.black.cgColor
//            //   cell.layer.shadowOpacity = 0.5
//               cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//               cell.layer.shadowRadius = 4.0
//               cell.layer.masksToBounds = false
//
//            downloadImage(from: imgurl!, imageViewMain: imageView)
//            productName.text = product.name
//
//        }
//        return cell
        
        guard let imageView = cell.viewWithTag(100) as? UIImageView,let productName = cell.viewWithTag(101) as? UILabel else {
            return cell
        }
//        let product = detailModel[indexPath.item]
//        cell.layer.borderWidth = 0.6
//           cell.layer.shadowColor = UIColor.black.cgColor
//           cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//           cell.layer.shadowRadius = 4.0
//           cell.layer.masksToBounds = false
//        let itemNumber = NSNumber(value: indexPath.item)
//        let imageUrl = URL(string: (product.image?.first)!)
//        productName.text = product.name
//        if let catchImage = self.cache.object(forKey: itemNumber){
//            imageView.image = catchImage
//        }
//
//        return cell
        
        let product = detailModel[indexPath.item]
        productName.text = product.name
        if let imageUrl = product.image?.first{
            ImagecacheSetup.shared.loadImage(url: imageUrl){
                image in imageView.image = image
            }
        }
        
        return cell
        
        
    }
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        if detailModel.count > 0 {
//            let cell = CollectionViewmain.dequeueReusableCell(withReuseIdentifier: "CellMain", for: indexPath)
//            guard let imageView = cell.viewWithTag(100) as? UIImageView,let productName = cell.viewWithTag(101) as? UILabel else {
//                return
//            }
//
//            let itemNumber = NSNumber(value: indexPath.item)
//            print("item No",itemNumber)
//            let product = detailModel[indexPath.item]
//            let imageUrl = URL(string: (product.image?.first!)!)
//            if let catchImage = self.cache.object(forKey: itemNumber){
//
//                imageView.image = catchImage
//            }
//            else{
//                self.downloadImage(from: imageUrl!, imageViewMain: imageView, int: itemNumber)
//            }
//
//        }
//
//
//
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: self.view.frame.width / 2, height: .frame.height)
        return CGSize(width: (UIScreen.main.bounds.size.width/2) - 10, height: 180.0)

    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 7, bottom: 0, right:  7)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailPageViewController") as! DetailPageViewController

        let selectedProduct = detailModel[indexPath.item]
        print("Product : ", selectedProduct)
        vc.wholeArr = selectedProduct
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)

        
    }
}




extension ViewController : SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int) {
        print("\(row)")
        DispatchQueue.main.async {
            self.sideMenuState(expanded: false)
        }
    }
    
    func sideMenuState(expanded:Bool){
        if expanded {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuwidth) { _ in
                self.isExpanded = true
            }
            UIView.animate(withDuration: 0.5, animations: { self.sideMenuShadowView.alpha = 0.6 })
        }
        else{
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuwidth - self.paddingForRotation): 0) { _ in
                self.isExpanded = false
            }
            UIView.animate(withDuration: 0.5, animations: { self.sideMenuShadowView.alpha = 0.0 })
        }
    }
    
    func animateSideMenu(targetPosition:CGFloat,completion:@escaping(Bool)-> Void){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
                    if self.revealSideMenuOnTop {
                        self.sideMenuTrailingConstraint.constant = targetPosition
                        self.view.layoutIfNeeded()
                    }
                    else {
                        self.view.subviews[1].frame.origin.x = targetPosition
                    }
                }, completion: completion)
    }
    @objc func UpdateToSideMenuAction(notifi: Notification) {// for header table side menu
            let dict = notifi.userInfo
            self.sideMenuState(expanded: self.isExpanded ? false : true)
//            if dict!.count > 0 {
//                if dict!["option"] as! String == "expense" {
//                    DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
//                        let vc = ExpenseClaimViewController()
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    })
//                }
//                else if dict!["option"] as! String == "languageNO" {
//                    self.dismiss(animated: false)
//                }
//                else if dict!["option"] as! String == "languageEN" {
//                    self.dismiss(animated: false)
//                }
//                else if dict!["option"] as! String == "timeTracker" {
//                    let vc = TimeTrackerViewController()
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//                else if dict!["option"] as! String == "payslip" {
//                    self.view.makeToast("\(GlobalLanguageDictionary.object(forKey: "commingSoon") as AnyObject)")
//                    ZerpLabsGeneral.instance.alertActionCommon(view: self, title: "\(GlobalLanguageDictionary.object(forKey: "commingSoon") as AnyObject)", message: "")
//                }
//                else if dict!["option"] as! String == "bank" {
//                    self.view.makeToast("\(GlobalLanguageDictionary.object(forKey: "commingSoon") as AnyObject)")
//                    ZerpLabsGeneral.instance.alertActionCommon(view: self, title: "\(GlobalLanguageDictionary.object(forKey: "commingSoon") as AnyObject)", message: "")
//                }
//                else if dict!["option"] as! String == "reports" {
//                    let vc = ReportsListViewController()
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//                else if dict!["option"] as! String == "sale" {
//                    let vc = SaleBaseViewController()
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//            }
        }
}
