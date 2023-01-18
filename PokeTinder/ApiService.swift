//
//  ApiService.swift
//  GestureCardSwipe
//
//  Created by Fradiano Hasani on 10.01.23.
//

import Foundation

struct ApiService {
    
    static let baseUrl = "https://api.pokemontcg.io/v2/cards"
    
    static func fetchCards(completion: @escaping(ApiAntwort) -> Void) {
        
        let urlString = baseUrl
        let url = URL(string: urlString)
        guard url != nil else { return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
           
            if error == nil && data != nil {
              
                let decoder = JSONDecoder()
                
                do {
                    print("gefrierfach")
                    let apiAntwort = try decoder.decode(ApiAntwort.self, from: data!)
                    completion(apiAntwort)
                } catch {
                    print ("Error in JSON parsing.")
                }
            }
        }
        
        dataTask.resume()
    }
    
    static func fetchTenRndmCards(completion: @escaping(ApiAntwort) -> Void) {
        
        let rndmKey = (1...1562).randomElement()
        let urlString = "https://api.pokemontcg.io/v2/cards?pageSize=10&page=\(rndmKey!)"
        let url = URL(string: urlString)
        guard url != nil else { return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
           
            if error == nil && data != nil {
              
                let decoder = JSONDecoder()
                
                do {
                    let apiAntwort = try decoder.decode(ApiAntwort.self, from: data!)
                    completion(apiAntwort)
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
            }
        }
        
        dataTask.resume()
    }
}
