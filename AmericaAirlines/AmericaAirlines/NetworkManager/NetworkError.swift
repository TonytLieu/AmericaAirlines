//
//  NetworkError.swift
//  AmericaAirlines
//
//  Created by Tony Lieu on 11/30/23.
//

import Foundation

enum NetworkError:Error{
    case badUrl
    case badServerResponse
    case nodata
    case parsingError
    case unknown
}

extension NetworkError:LocalizedError{
    var errorDescription: String?{
        switch self{
            
        case .badUrl:
            return NSLocalizedString("API url is incorrect", comment: "urlError")
        case .nodata:
            return NSLocalizedString("API could not find data", comment: "data not Found" )
        case .badServerResponse:
            return NSLocalizedString("API server can't be reach", comment: "server not found")
        default:
            return NSLocalizedString("Unknown Error", comment: "404")
        }
    }
}
