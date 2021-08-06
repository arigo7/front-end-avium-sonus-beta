//
//  Extensions.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/5/21.
//

import Foundation

// toString function implemented as an extension  of Date class
extension Date
{
    func toString( dateFormat format : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

