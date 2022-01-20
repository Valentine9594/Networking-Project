//
//  File.swift
//  NetworkAssignment
//
//  Created by neosoft on 27/12/21.
//

import Foundation

//let urlConfig = URLSessionConfiguration.default

class sessionCall: NSObject {
    
//    private let urlSession = URLSession(configuration: urlConfig)
    private let urlStr = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/products/getList?product_category_id=1")!

    func apiFetchData(completion : @escaping (ProductLoad) -> ()){
        
//        let task = urlSession.dataTask(with: urlStr){
        URLSession.shared.dataTask(with: urlStr){
            (data, response, error) in
            
            guard error == nil else{
                print("Error: \(String(describing: error))")
                return
            }
            
            guard let content = data else{
                print("No Data!")
                return
            }
            
//            guard let json = try! JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] else{
//                print("Cannot convert data!")
//                return
//            }
//            print(json)
            
            do{
                let jsonDecoder = JSONDecoder()
                let someData = try jsonDecoder.decode(ProductLoad.self, from: content)
                completion(someData)
            }
            catch let error{
                debugPrint(error)
            }
            
        }.resume()
        
    }
    
}

