//
//  APIService.swift
//  CardLayOut
//
//  Created by HARSH TRIVEDI on 08/07/24.
//

import Foundation
class APIService {
    func fetchProfile(completion: @escaping (Profile?) -> Void) {
        guard let url = URL(string: "https://api.frenley.com/v2/profiles/testUser") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let profile = try decoder.decode(Profile.self, from: data)
                    DispatchQueue.main.async {
                        completion(profile)
                    }
                } catch {
                    print("Error decoding profile data: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
