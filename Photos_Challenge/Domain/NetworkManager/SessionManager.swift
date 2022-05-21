//
//  SessionManager.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/21/22.
//

import Alamofire
import Foundation
extension Session {
    func request(_ request: RequestProtocol) -> DataRequest {
        return self.request(request.url,
                            method: request.method,
                            parameters: request.parameters,
                            encoding: request.method == .get ? URLEncoding.default : JSONEncoding.prettyPrinted,
                            headers: request.headers)
    }
}

struct APIClient: DataProviderProtocol {
    public func sentRequest<ResponseType>(request: RequestProtocol, mapResponseOnType: ResponseType.Type, successHandler: @escaping (ResponseType) -> Void, failureHandler: @escaping (Error) -> Void) where ResponseType : Decodable, ResponseType : Encodable {
        Session.default.request(request).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedObject = try jsonDecoder.decode(mapResponseOnType.self, from: response.data ?? Data())
                    successHandler(decodedObject)
                } catch {
                    // Error Decoding the response
                    failureHandler(error)
                }
            case .failure(let error):
                // Error executing the request
                failureHandler(error)
            }
        }
    }
    
}
