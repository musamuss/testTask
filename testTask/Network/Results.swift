//
//  Results.swift
//  testTask
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation

struct Session: Codable {
    let status: Int
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let session: String
}


