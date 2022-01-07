//
//  Thought.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/6/22.
//

import Foundation
import UIKit

class Thought{
    
    private(set) var userN: String!
    private(set) var TxtThought: String!
    
    init(userN: String, TxtThought: String){
        self.userN = userN
        self.TxtThought = TxtThought
    }
}
