//
//  APICaller.swift
//  FinalProject
//
//  Created by Бекжан on 12.04.2023.
//

import Foundation
import Alamofire

struct APICaller {
    var heroes = [DSHeroesData]()
    
    static let shared = APICaller()
    
    
//    func fetchRequest(handler: @escaping( _ apiData:[DSHeroesData]) ->(Void)){
//        let url = "https://api.opendota.com/api/heroStats"
//
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response{ responce in
//            switch responce.result {
//            case .success(let data):
//                do {
//                    let jsonData = try JSONDecoder().decode([DSHeroesData].self, from: data!)
//                    handler(jsonData)
//                    print(jsonData)
//                } catch {
//
//                }
//            case.failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    func fetchingAPiImages(URL Url:String, completion: @escaping ([DSHeroesData]) ->Void){
        let url = URL(string: Url)
        let session = URLSession.shared
 
        let dataTask = session.dataTask(with: url!) { data, responce, error in
            do {
                
            let fetchingData = try JSONDecoder().decode([DSHeroesData].self, from: data!)
                completion(fetchingData)
            } catch {
                print("parsing error")
            }
        }
        dataTask.resume()
    }

}
