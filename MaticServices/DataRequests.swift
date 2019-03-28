//
//  DataRequests.swift
//  MaticServices
//
//  Created by Sam Kad on 3/27/19.
//  Copyright © 2019 Sam Kad. All rights reserved.
//

import UIKit
import Alamofire

    var mainURL :String {
        let url = "https://api.github.com/search/repositories?q=created:>2017-10-22&sort=stars&order=desc"
        let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return urlEncoded!
    }

class DataRequests: NSObject {

    
    class func fetchReposeForPage(pageNumber:Int,completion:@escaping (_ status:Bool,_ result:Any)->()){
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        Alamofire.request(mainURL, method:.get , parameters: [:], encoding: URLEncoding.default, headers: nil).responseDecodableObject(queue: nil, keyPath: "items", decoder: decoder) {  (response: DataResponse<[RepoModel]>) in
            
          
            print("Fetched")
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
    
            switch response.result{
                
            case .success(let value):
     
              completion(true,value)
                
             case .failure(let error):
                completion(false,error)
                break
                
            }
    
        }
        
       
        
    }
}
