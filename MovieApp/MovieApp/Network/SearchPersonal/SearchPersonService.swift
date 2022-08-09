//
//  SearchPersonalService.swift
//  MovieApp
//
//  Created by ArdaSisli on 8.08.2022.
//

import Foundation
import Alamofire

protocol SearchPersonServiceProtocol {
    func fetchAllData(
        path: (String),
        onSuccess: @escaping ([PersonResult]) -> Void,
        onError: @escaping (String) -> Void
         )
}

class SearchPersonService: SearchPersonServiceProtocol {
    func fetchAllData(path: (String),
                      onSuccess: @escaping ([PersonResult]) -> Void,
                      onError: @escaping (String) -> Void
         ) {
        AF.request(MovieNetworkConstant.SearchPersonNetwork.searchPersonURL(path: path), method: .get).responseDecodable(of: SearchPersonResult.self) { searchMovie in
            guard let data = searchMovie.value else {
                return onError("Error")
            }
            guard let personData = data.results else { return }
            let value = personData
            onSuccess(value)
        }
    }
}
