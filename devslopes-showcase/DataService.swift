//
//  DataService.swift
//  devslopes-showcase
//
//  Created by Tobias Gozzi on 11/10/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataService {
    static let ds = DataService()
 
    private var _REF_BASE = FIRDatabase.database().reference()

    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
}