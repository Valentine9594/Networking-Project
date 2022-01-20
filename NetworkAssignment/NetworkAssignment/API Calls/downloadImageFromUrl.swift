//
//  downloadImageFromUrl.swift
//  NetworkAssignment
//
//  Created by neosoft on 30/12/21.
//

import Foundation
import Alamofire
import AlamofireImage

class DownloadImageFromUrl{
    
    func downloadImage(_ urlString: String, completion : @escaping (UIImage) -> ()){
//        let urlStrTrim = urlString.replacingOccurrences(of: #"\"#, with: #""#)
        guard let url = URL(string: urlString) else{ return }

        AF.request(url).responseImage{
            response in
            
            guard response.error == nil else{
                print(response.error!)
                return
            }

            guard let img = response.value else{
                print("No Image")
                return
            }

            completion(img)
        
        }
    
  }

}
