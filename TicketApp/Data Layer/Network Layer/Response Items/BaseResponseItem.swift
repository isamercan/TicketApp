//
//  BaseResponseItem.swift
//  TicketApp
//
//  Created by İlker İsa Mercan on 30.10.2023.
//

import Foundation

/**
 A generic response model that contains the response data, success status, response code, and message.
 This struct is used as a base response structure to provide a common format for different response models.
 Use this struct to decode and parse the response received from a network API call that using shared structure.
 */

struct BaseResponse<T: Decodable> {
    let status: String?
    let data: T?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case data, status, message
    }
}

extension BaseResponse: Decodable  {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            data = try container.decode(T.self, forKey: .data)
        } catch {
            data = nil
        }
        
        status = try container.decodeIfPresent(String.self, forKey: .status)
        message = try container.decodeIfPresent(String.self, forKey: .message)
    }
}
