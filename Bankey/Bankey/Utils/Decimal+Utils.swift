//
//  Decimal+Utils.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 06/10/22.
//

import Foundation


extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
