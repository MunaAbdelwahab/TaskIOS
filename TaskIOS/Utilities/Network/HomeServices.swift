//
//  HomeServices.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import Foundation
import Alamofire
import RxSwift

class HomeServices{
    let apiClient = APIClient()
    
    func getHomeData() -> Observable<Result<HomeDataResponse,AFError>>{
        let url = API.Keys.Home.articleData
        return apiClient.performRequest(url: url, method: .get, parameters: nil, headers: nil)
    }
}
