//
//  BaseClient.swift
//  template-ios
//
//  Created by Vladimir Espinola on 3/19/19.
//  Copyright © 2019 vel. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireActivityLogger

typealias failureCallback = (APIError) -> Void
typealias MultipartPair = (key: String, data: Data, mimeType: String)
typealias GenericDictionary = [String: Any]

enum Encoding {
    case `default`
    case json
    case query
    
    var alamofire: ParameterEncoding {
        switch self {
        case .default:
            return URLEncoding.default
        case .json:
            return JSONEncoding.default
        case .query:
            return URLEncoding.queryString
        }
    }
}

struct ResponseType {
    static let success = "success"
    static let error = "error"
}

class Client {
    
    class func request<T: Codable>(
        verb: HTTPMethod = .get,
        route: Routes,
        parameters: [String: Any] = [:],
        headers: [String: String] = [
            "Content-Type" : "application/json",
            "Accept" : "application/json"
        ],
        encoding: Encoding = .default,
        success: @escaping (T) -> Swift.Void,
        failure: ((APIError) -> Swift.Void)? = nil
        ) {
        
        guard NetworkReachabilityManager()?.isReachable == true else {
            failure?(APIError(type: .connection))
            return
        }
        
        BaseSessionManager.shared
            .request(route.endpoint,
                     method: verb,
                     parameters: parameters,
                     encoding: encoding.alamofire,
                     headers: headers)
            .log()
            .response(completionHandler: { response in
                guard response.error == nil else {
                    //We got a timeout
                    if response.error?._code == NSURLErrorTimedOut {
                        failure?(APIError(type: .timeout))
                    } else {
                        failure?(APIError(type: .generic))
                    }
                    return
                }
                
//                guard let data = response.data else {
//                    failure?(APIError())
//                    return
//                }
                
                //TODO
            })
    }
    
    class func upload(route: Routes,
                      headers: HTTPHeaders,
                      parameters: [MultipartPair],
                      onCompletion: ((GenericDictionary?) -> Void)? = nil,
                      onError: ((Error?) -> Void)? = nil) {
        
        BaseSessionManager.shared.upload(multipartFormData: { (multipartFormData) in
            for pair in parameters {
                if pair.mimeType == "image/jpeg" {
                    multipartFormData.append(pair.data, withName: pair.key, fileName: "filename\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    
                } else {
                    multipartFormData.append(pair.data, withName: pair.key)
                }
            }
            
        }, to: route.endpoint, method: .post, headers: headers, encodingCompletion: { result in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    print("Succesfully uploaded")
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        })
    }
}

class BaseSessionManager: SessionManager {
    static let shared: BaseSessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let manager = BaseSessionManager(configuration: configuration)
        return manager
    }()
}
