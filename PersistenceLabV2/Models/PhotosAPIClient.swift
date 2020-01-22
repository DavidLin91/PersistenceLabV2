//
//  PhotosAPIClient.swift
//  PersistenceLabV2
//
//  Created by David Lin on 1/22/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation
import NetworkHelper

struct PhotosAPIClient {
    static func getPhotos(with search: String, completion: @escaping(Result<[Photos], AppError>) -> ()) {
        
        let urlString = "https://pixabay.com/api/?key=14969843-2cae0700ee723f2830a9ec598&q=\(search)"
        
        guard let photoURL = URL(string: urlString) else {
            // .badURL(urlString) returns a string error
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: photoURL)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let projects = try JSONDecoder().decode(AllPhotos.self, from: data)
                    completion(.success(projects.hits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        
        
        
        
    }
}
