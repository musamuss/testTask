//
//  SessionModel.swift
//  testTask
//
//  Created by admin on 25/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation
struct SessionModel: Codable {
    let status: Int
    let data: [[sessionModel]]
}

// MARK: - Datum
struct sessionModel: Codable {
    let id, body, da, dm: String
}
