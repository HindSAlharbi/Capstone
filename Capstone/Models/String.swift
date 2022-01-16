//
//  string.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/16/22.
//

import Foundation

// extension string to locatized from english to arabic
extension String {
       var locatized: String{
           return NSLocalizedString(self, comment: "")
       }
}
