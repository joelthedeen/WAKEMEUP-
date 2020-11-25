//
//  ViewController.swift
//  
//
//  Created by Joel Thedéen on 2020-11-02.
//

import UIKit

class Stops : Codable{
    
    var StopLocation : [SLoc]
}
class SLoc : Codable{
    
    var lat : Double
    var lon : Double
    var name : String
}

extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
  }
    public func stringByAddingPercentEncodingForFormData(plusForSpace: Bool=false) -> String? {
      let unreserved = "*-._"
      let allowed = NSMutableCharacterSet.alphanumeric()
      allowed.addCharacters(in: unreserved)

      if plusForSpace {
        allowed.addCharacters(in: " ")
      }

      var encoded = addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
      if plusForSpace {
        encoded = encoded?.replacingOccurrences(of: " ", with: "+")
      }
      return encoded
    }
}

class Trafiklab {
    
    
    
    func loadFromServerURLSESSION(_ query: String, completionHandler: @escaping (_ result : Stops?) -> Void)
    {
        guard let queryENCODED = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completionHandler(nil)
            return
        }
        guard let url = URL(string: "https://api.resrobot.se/location.name.json?key=f18064aa-50c1-4486-860a-158a6e6c46c3&maxNo=10&input=\(queryENCODED)") else {
            completionHandler(nil)
            return
        }
        DispatchQueue.global(qos: .background).async {
            do {
                let contents = try String(contentsOf: url)
                self.gotTextFromServer(serverstring: contents, completionHandler: completionHandler)
            } catch {
                completionHandler(nil)
            }
        }
    }
    
    func gotTextFromServer(serverstring : String, completionHandler: @escaping (_ result : Stops?) -> Void)
    {
        
        var returnArr: [String] = []
        
        let jsondata = Data(serverstring.utf8)
        
        let decoder = JSONDecoder()

        do {
            let stops = try decoder.decode(Stops.self, from: jsondata)
            
            completionHandler(stops)
            
        } catch {
            print("Failed to decode JSON")
            completionHandler(nil)
        }
        
    }
}
