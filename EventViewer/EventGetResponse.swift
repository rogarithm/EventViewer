//
//  EventGetResponse.swift
//  EventViewer
//
//  Created by sehoon gim on 12/4/24.
//

import Foundation

struct EventGetResponse: Codable {
    let startDateTime: String
    let endDateTime: String
    let description: String
}
