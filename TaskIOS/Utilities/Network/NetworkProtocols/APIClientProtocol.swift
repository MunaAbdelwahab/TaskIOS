//
//  APIClientProtocol.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol APIClientProtocol {
    
    //MARK:- That's used for posts requests with image included and without encoded model
    func multiPart<T:Decodable>(url: String, method: HTTPMethod, parameters: Parameters?, headersType: HeadersType, imgKey: String, img:[Data], decoder: JSONDecoder) -> Observable<Result<T, AFError>>
    
    
    //MARK:- That's used for post requests with encoded model
    func performRequest<T:Decodable, X: Encodable>(url: String, method: HTTPMethod, parameters: X, headersType: HeadersType, decoder: JSONDecoder) -> Observable<Result<T, AFError>>
    
    //MARK:- That's used for get requests and post requests without encoded model
    func performRequest<T:Decodable>(url: String, method: HTTPMethod, parameters: [String:String]?, headersType: HeadersType, decoder: JSONDecoder) -> Observable<Result<T, AFError>>
}
