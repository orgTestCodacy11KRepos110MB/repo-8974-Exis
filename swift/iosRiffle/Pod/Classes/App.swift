//
//  App.swift
//  Pods
//
//  Created by damouse on 3/7/16.
//
//

import Foundation
import Mantle

class App {
    var mantleDomain: MantleDomain
    
    var deferreds: [Double: Deferred] = [:]
    var handlers: [Double: [Any] -> ()] = [:]
    var registrations: [Double: [Any] -> Any?] = [:]
    
    
    init(domain: MantleDomain) {
        mantleDomain = domain
    }
    
    func receive() {
        while true {
            var (i, args) = decode(mantleDomain.receive())
            
            if let d = deferreds[i] {
                // remove the deferred (should this ever be optional?)
                deferreds[d.cb] = nil
                deferreds[d.eb] = nil
                
                if d.cb == i {
                    d.callback(args)
                }
                
                if d.eb == i {
                    d.errback(args)
                }
            } else if let fn = handlers[i] {
                fn(args)
            } else if let fn = registrations[i] {
                let resultId = args.removeAtIndex(0) as! Double
                
                // Optional serialization has some problems. This unwraps the result to avoid that particular issue
                if let ret = fn(args) {
                    // Function did not return anything
                    if let _ = ret as? Void {
                        mantleDomain.yield(resultId.go(), args: marshall([]))

                    // If function returned an array it could be a tuple
                    } else {
                        mantleDomain.yield(resultId.go(), args: marshall([ret]))
                    }
                } else {
                    let empty: [Any] = []
                    mantleDomain.yield(resultId.go(), args: marshall(empty))
                }
            }
        }
    }
}