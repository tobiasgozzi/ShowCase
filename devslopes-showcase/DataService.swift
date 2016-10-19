//
//  DataService.swift
//  devslopes-showcase
//
//  Created by Tobias Gozzi on 11/10/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class DataService {
    static let ds = DataService()
 
    private var _REF_BASE = FIRDatabase.database().reference()
    private var _REF_USER = "users"
    private var _REF_POSTS = FIRDatabase.database().reference().child("posts")

    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    func createUser(userUID: String, provider: String) {
        REF_BASE.ref.child(_REF_USER).child(userUID).setValue(["provider": provider])
    }
}