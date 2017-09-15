//
//  Future.swift
//  rolezinho
//
//  Created by Rodrigo Santos on 14/09/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation

class Future<Value>: NSObject {
    
    var result : Value? {
        didSet {
            notifyCallbacks(value: result)
        }
    }
    
    private lazy var callbacks = [(Value?) -> Void]()
    
    func observe(with callback: @escaping (Value?) -> Void) {
        callbacks.append(callback)
    }
    
    func notifyCallbacks(value: Value?) {
        callbacks.forEach { (callback) in
            callback(value)
        }
    }
    
}
