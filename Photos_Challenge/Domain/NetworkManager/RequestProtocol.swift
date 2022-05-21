//
//  RequestProtocol.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/21/22.
//

import Alamofire
protocol RequestProtocol {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters { get }
}

extension RequestProtocol {
    public var headers: HTTPHeaders { return ["Content-Type" : "application/json"]}
    public var parameters: Parameters { return [:] }
}

class SimpleGetRequest: RequestProtocol {
    public var method: HTTPMethod
    public var url: String
    public var parameters: Parameters?
    
    public required init(url: String, parameters: Parameters?,method:HTTPMethod?) {
        self.url = url
        self.parameters = parameters
        self.method = method ?? .get
    }
}
