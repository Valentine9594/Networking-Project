//
//  ProductsViewModel.swift
//  NetworkAssignment
//
//  Created by neosoft on 28/12/21.
//

import Foundation

class ProductViewModel: NSObject{
    private var apiService: sessionCall!
    private(set) var productData: ProductLoad!{
        didSet{
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = sessionCall()
        funcToGetProductData()
    }
    
    func funcToGetProductData(){
        self.apiService.apiFetchData{(prodData) in
            self.productData = prodData
        }
    }
}
