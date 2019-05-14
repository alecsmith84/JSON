//
//  DataManager.swift
//  Json intro
//
//  Created by Alec Smith on 5/13/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    let MyJSONurl = "https://api.myjson.com/bins/19k476"
    
    var dataArray = ["no data entered"]
    
    func getData(completion: @escaping (_ success: Bool) -> ()) {
        var success = true
        let actualURL = URL(string:MyJSONurl)
        
        let task = URLSession.shared.dataTask(with: actualURL!) { (data, response, error) in
            
            guard let _ = data, error == nil else {
                // error
                success = false
                return
            }
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!.value(forKey: "Cars")!)
                
                if let veggieArray = jsonObj!.value(forKey: "Cars") as? Array<String> {
                    self.dataArray = veggieArray
                }
            }
            
            completion(success)
            
        }
        task.resume()
    }
}
