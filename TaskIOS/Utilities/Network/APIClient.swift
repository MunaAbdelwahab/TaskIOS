//
//  APIClient.swift
//  TaskIOS
//
//  Created by Muna Abdelwahab on 17/05/2023.
//

import Foundation
import Alamofire
import RxSwift

enum HeadersType{
    case authenticatedWithLanguage
    case language
    case none
}

class APIClient: APIClientProtocol {
    
    @discardableResult
    func multiPart<T:Decodable>(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, imgKey: String, img:[Data], decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, AFError>)->Void) -> DataRequest {

        return AF.upload(multipartFormData: { (multipartFormData) in
            for index in 0..<img.count{
                multipartFormData.append(img[index], withName: imgKey, fileName: "img\(index).jpg", mimeType: "image/jpg")
            }
            
            if let parameters = parameters {
                for (key, value) in parameters {
                    if key == "items"{
                        if let arr = value as? [[String:AnyObject]],
                           let dat = try? JSONSerialization.data(withJSONObject: arr, options: .prettyPrinted),
                           let str = String(data: dat, encoding: String.Encoding.utf8) {
                            multipartFormData.append((str).data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }else{
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                }
            }
        }, to: url, method: .post, headers: headers).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
            
            debugPrint(response)
            completion(response.result)
        }
    }
    
    //MARK:- RxSwift
    @discardableResult
    func multiPart<T:Decodable>(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, imgKey: String, img:[Data], decoder: JSONDecoder = JSONDecoder()) -> Observable<Result<T, AFError>>{

            return Observable<Result<T,AFError>>.create { observer in
                AF.upload(multipartFormData: { (multipartFormData) in
                    for index in 0..<img.count{
                        multipartFormData.append(img[index], withName: imgKey, fileName: "img\(index).jpg", mimeType: "image/jpg")
                    }
                    
                    if let parameters = parameters {
                        for (key, value) in parameters {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                        }
                    }
                }, to: url, method: .post, headers: headers).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                    
                    debugPrint(response)
                    observer.onNext(response.result)
                }
                return Disposables.create()
            }
        }
    
    @discardableResult
    func performRequest<T:Decodable, X: Encodable>(url: String, method: HTTPMethod, parameters: X, headers: HTTPHeaders?, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {

        return AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
            debugPrint(response)
            completion(response.result)
        }
    }
    
    @discardableResult
    func performRequest<T:Decodable>(url: String, parameters: [String:String]? = nil, method: HTTPMethod, headers: HTTPHeaders?, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {

        return AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
            debugPrint(response)
            completion(response.result)
        }
    }
    
    //MARK:- RxSwift
    @discardableResult
    func performRequest<T:Decodable, X: Encodable>(url: String, method: HTTPMethod, parameters: X, headers: HTTPHeaders?, decoder: JSONDecoder = JSONDecoder()) -> Observable<Result<T, AFError>> {
        
        return Observable<Result<T, AFError>>.create { observer in
            AF.request(url, method: method, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                debugPrint(response)
                //response.response?.statusCode
                observer.onNext(response.result)
            }
            return Disposables.create()
        }
    }
    
    @discardableResult
    func performRequest<T:Decodable>(url: String, method: HTTPMethod, parameters: [String:String]? = nil, headers: HTTPHeaders?, decoder: JSONDecoder = JSONDecoder()) -> Observable<Result<T, AFError>> {
        
        return Observable<Result<T, AFError>>.create { observer in
            AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                debugPrint(response)
                observer.onNext(response.result)
            }
            return Disposables.create()
        }
    }
    
    @discardableResult
    func multiPart<T:Decodable>(url: String, method: HTTPMethod, parameters: Parameters?, headersType: HeadersType, imgKey: String, img:[Data], decoder: JSONDecoder = JSONDecoder()) -> Observable<Result<T, AFError>>{
        
        let headers = getHeaders(headersType: headersType)
        return Observable<Result<T,AFError>>.create { observer in
            AF.upload(multipartFormData: { (multipartFormData) in
                for index in 0..<img.count{
                    multipartFormData.append(img[index], withName: imgKey, fileName: "img\(index).jpg", mimeType: "image/jpg")
                }
                
                if let parameters = parameters {
                    for (key, value) in parameters {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                }
            }, to: url, method: .post, headers: headers).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                
                debugPrint(response)
                observer.onNext(response.result)
            }
            return Disposables.create()
        }
    }
    
    @discardableResult
    func performRequest<T:Decodable, X: Encodable>(url: String, method: HTTPMethod, parameters: X, headersType: HeadersType, decoder: JSONDecoder = JSONDecoder()) -> Observable<Result<T, AFError>> {
        
        let headers = getHeaders(headersType: headersType)
        return Observable<Result<T, AFError>>.create { observer in
            AF.request(url, method: method, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                debugPrint(response)
                observer.onNext(response.result)
            }
            return Disposables.create()
        }
    }
    
    @discardableResult
    func performRequest<T:Decodable>(url: String, method: HTTPMethod, parameters: [String:String]? = nil, headersType: HeadersType, decoder: JSONDecoder = JSONDecoder()) -> Observable<Result<T, AFError>> {
        
        let headers = getHeaders(headersType: headersType)
        return Observable<Result<T, AFError>>.create { observer in
            AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                debugPrint(response)
                observer.onNext(response.result)
            }
            return Disposables.create()
        }
    }
    
    private func getHeaders(headersType: HeadersType) -> HTTPHeaders?{
        switch headersType{
        case .authenticatedWithLanguage:
            return nil
        case .language:
            return nil
        case .none:
            return nil
        }
    }
    
}

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
