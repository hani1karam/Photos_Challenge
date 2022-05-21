//
//  DataProviderProtocol.swift
//  Photos_Challenge
//
//  Created by hany karam on 5/21/22.
//

protocol DataProviderProtocol {
    func sentRequest<ResponseType: Codable> (request: RequestProtocol, mapResponseOnType: ResponseType.Type, successHandler: @escaping (ResponseType) -> Void, failureHandler: @escaping (Error) -> Void)
}
