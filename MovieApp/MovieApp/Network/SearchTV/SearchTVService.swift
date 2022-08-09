//
//  SearchTV.swift
//  MovieApp
//
//  Created by ArdaSisli on 8.08.2022.
//

import Foundation
import Alamofire

protocol SearchTVServiceProtocol {
    func fetchAllData(
        path: (String),
        onSuccess: @escaping ([TV]) -> Void,
        onError: @escaping (String) -> Void
         )
}

class SearchTVService: SearchTVServiceProtocol {
    func fetchAllData(path: (String),
                      onSuccess: @escaping ([TV]) -> Void,
                      onError: @escaping (String) -> Void
         ) {
        AF.request(MovieNetworkConstant.SearchTVNetwork.searchTVURL(path: path), method: .get).responseDecodable(of: SearchTVResult.self) { searchTV in
            guard let data = searchTV.value else {
                return onError("Error")
            }
            guard let tvData = data.results else { return }
            let value = tvData
            onSuccess(value)
        }
    }
}
