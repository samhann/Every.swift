//
//  ArrayExtension.swift
//  Every
//
//  Created by Pierre TACCHI on 06/01/16.
//  Copyright © 2016 Samhan. All rights reserved.
//

public extension Array where Element : Equatable {
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}
