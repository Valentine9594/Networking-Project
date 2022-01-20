//
//  ProductTableViewController.swift
//  NetworkAssignment
//
//  Created by neosoft on 28/12/21.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductTableViewController: UITableViewController {
    
    private var prodViewModel: ProductViewModel!
    private var downloadImg = DownloadImageFromUrl()
//    private lazy var operationQueue = OperationQueue()
    private var productArr = [ProductData]()
    private var productImgCache = AutoPurgingImageCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let cellNib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "ProductCell")
        
        DispatchQueue.main.async {

            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.callForUIupdates()
        }
        
//        DispatchQueue.global(qos: .default).sync {
//            self.operationQueue.maxConcurrentOperationCount = 4
//            self.operationQueue.qualityOfService = .userInteractive
//            self.operationQueue.name = "Download Images"
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTableHead), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func callForUIupdates(){
        self.prodViewModel = ProductViewModel()
        self.prodViewModel.bindViewModelToController = {
            self.productArr = self.prodViewModel.productData.data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    
    @objc func setTableHead(){
        self.tableView.tableHeaderView = self.tableHeader()
    }

    func tableHeader() -> UIView{
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 70))
        let headerLbl = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height))
        headerLbl.text = "Products"
        headerLbl.backgroundColor = .red
        headerLbl.textColor = .white
        headerLbl.font = UIFont.boldSystemFont(ofSize: 32)
        headerLbl.textAlignment = .center
        headerView.addSubview(headerLbl)
        
        return headerView
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return self.prodViewModel.productData.data.count
        return self.productArr.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell

        // Configure the cell...
        let currentProdData = self.productArr[indexPath.row]
        
        let isVisible = tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false
        if isVisible{
            DispatchQueue.main.async {
                if let img = self.productImgCache.image(withIdentifier: "\(currentProdData.id)"){
                    cell.productImage.image = img
                    print("Image loaded from cache")
                }
                else{
                    self.downloadImg.downloadImage(currentProdData.productImg){
                        prodImg in
                        cell.productImage.image = prodImg
                        self.productImgCache.add(prodImg, withIdentifier: "\(currentProdData.id)")
                    }
                    print("image downloaded from internet: \(indexPath)")
                }
            }
        }
        
        cell.productName.text = currentProdData.name.capitalized
        cell.productProducer.text = currentProdData.producer.capitalized
        cell.productCost.text = "Rs. \(currentProdData.cost)"
        return cell
    }
    
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.operationQueue.isSuspended = true
//    }
//
//    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        self.operationQueue.isSuspended = false
//    }

}
