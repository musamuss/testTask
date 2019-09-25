//
//  SessionAddModel.swift
//  testTask
//
//  Created by admin on 25/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation
struct SessionAddModel: Codable {
    let status: Int
    let data: SessionAdd
}

// MARK: - DataClass
struct SessionAdd: Codable {
    let id: String
}
