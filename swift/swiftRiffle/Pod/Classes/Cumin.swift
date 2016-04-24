
// 
// Cumin generic wrapper functions. Each overloaded function corresponds to a handler with a different number of 
// arguments and return types
//
// Generated by cuminGenerator.py
// 

import Foundation

// Converter operator. Attempts to convert the object on the right to the type given on the left
// Just here to make the cumin conversion functions just the smallest bit clearer
infix operator <- {
associativity right
precedence 155
}

func <- <T: Property> (t:T.Type, object: Any) -> T {
    // Deserialize is implemented as part of the Convertible protocol. All properties implement Convertible
    
    #if os(OSX)
        return T.unsafeDeserialize(object, t: T.self)!
    #else
        return T.deserialize(object) as! T
    #endif
}

// Used only in this file to shorten the length of the method signatures
public typealias PR = Property

public extension Domain {

	public func register(endpoint: String, options: Options = Options(), _ fn: () -> ()) -> Deferred {
		return _register(endpoint, [], options: options) { a in return serializeResults(fn()) }
	}

	public func register<A: PR>(endpoint: String, options: Options = Options(), _ fn: (A) -> ()) -> Deferred {
		return _register(endpoint, [A.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0])) }
	}

	public func register<A: PR, B: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B) -> ()) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1])) }
	}

	public func register<A: PR, B: PR, C: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C) -> ()) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D) -> ()) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E) -> ()) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, F: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E, F) -> ()) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation(), F.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4], F.self <- a[5])) }
	}

	public func register<R: PR>(endpoint: String, options: Options = Options(), _ fn: () -> (R)) -> Deferred {
		return _register(endpoint, [], options: options) { a in return serializeResults(fn()) }
	}

	public func register<A: PR, R: PR>(endpoint: String, options: Options = Options(), _ fn: (A) -> (R)) -> Deferred {
		return _register(endpoint, [A.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0])) }
	}

	public func register<A: PR, B: PR, R: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B) -> (R)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1])) }
	}

	public func register<A: PR, B: PR, C: PR, R: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C) -> (R)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, R: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D) -> (R)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, R: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E) -> (R)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, F: PR, R: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E, F) -> (R)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation(), F.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4], F.self <- a[5])) }
	}

	public func register<R: PR, S: PR>(endpoint: String, options: Options = Options(), _ fn: () -> (R, S)) -> Deferred {
		return _register(endpoint, [], options: options) { a in return serializeResults(fn()) }
	}

	public func register<A: PR, R: PR, S: PR>(endpoint: String, options: Options = Options(), _ fn: (A) -> (R, S)) -> Deferred {
		return _register(endpoint, [A.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0])) }
	}

	public func register<A: PR, B: PR, R: PR, S: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B) -> (R, S)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1])) }
	}

	public func register<A: PR, B: PR, C: PR, R: PR, S: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C) -> (R, S)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, R: PR, S: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D) -> (R, S)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, R: PR, S: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E) -> (R, S)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, F: PR, R: PR, S: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E, F) -> (R, S)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation(), F.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4], F.self <- a[5])) }
	}

	public func register<R: PR, S: PR, T: PR>(endpoint: String, options: Options = Options(), _ fn: () -> (R, S, T)) -> Deferred {
		return _register(endpoint, [], options: options) { a in return serializeResults(fn()) }
	}

	public func register<A: PR, R: PR, S: PR, T: PR>(endpoint: String, options: Options = Options(), _ fn: (A) -> (R, S, T)) -> Deferred {
		return _register(endpoint, [A.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0])) }
	}

	public func register<A: PR, B: PR, R: PR, S: PR, T: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B) -> (R, S, T)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1])) }
	}

	public func register<A: PR, B: PR, C: PR, R: PR, S: PR, T: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C) -> (R, S, T)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, R: PR, S: PR, T: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D) -> (R, S, T)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, R: PR, S: PR, T: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E) -> (R, S, T)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, F: PR, R: PR, S: PR, T: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E, F) -> (R, S, T)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation(), F.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4], F.self <- a[5])) }
	}

	public func register<R: PR, S: PR, T: PR, U: PR>(endpoint: String, options: Options = Options(), _ fn: () -> (R, S, T, U)) -> Deferred {
		return _register(endpoint, [], options: options) { a in return serializeResults(fn()) }
	}

	public func register<A: PR, R: PR, S: PR, T: PR, U: PR>(endpoint: String, options: Options = Options(), _ fn: (A) -> (R, S, T, U)) -> Deferred {
		return _register(endpoint, [A.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0])) }
	}

	public func register<A: PR, B: PR, R: PR, S: PR, T: PR, U: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B) -> (R, S, T, U)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1])) }
	}

	public func register<A: PR, B: PR, C: PR, R: PR, S: PR, T: PR, U: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C) -> (R, S, T, U)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, R: PR, S: PR, T: PR, U: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D) -> (R, S, T, U)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, R: PR, S: PR, T: PR, U: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E) -> (R, S, T, U)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, F: PR, R: PR, S: PR, T: PR, U: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E, F) -> (R, S, T, U)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation(), F.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4], F.self <- a[5])) }
	}

	public func register<R: PR, S: PR, T: PR, U: PR, V: PR>(endpoint: String, options: Options = Options(), _ fn: () -> (R, S, T, U, V)) -> Deferred {
		return _register(endpoint, [], options: options) { a in return serializeResults(fn()) }
	}

	public func register<A: PR, R: PR, S: PR, T: PR, U: PR, V: PR>(endpoint: String, options: Options = Options(), _ fn: (A) -> (R, S, T, U, V)) -> Deferred {
		return _register(endpoint, [A.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0])) }
	}

	public func register<A: PR, B: PR, R: PR, S: PR, T: PR, U: PR, V: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B) -> (R, S, T, U, V)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1])) }
	}

	public func register<A: PR, B: PR, C: PR, R: PR, S: PR, T: PR, U: PR, V: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C) -> (R, S, T, U, V)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, R: PR, S: PR, T: PR, U: PR, V: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D) -> (R, S, T, U, V)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, R: PR, S: PR, T: PR, U: PR, V: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E) -> (R, S, T, U, V)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4])) }
	}

	public func register<A: PR, B: PR, C: PR, D: PR, E: PR, F: PR, R: PR, S: PR, T: PR, U: PR, V: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E, F) -> (R, S, T, U, V)) -> Deferred {
		return _register(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation(), F.representation()], options: options) { a in return serializeResults(fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4], F.self <- a[5])) }
	}

	public func subscribe(endpoint: String, options: Options = Options(), _ fn: () -> ()) -> Deferred {
		return _subscribe(endpoint, [], options: options) { a in return fn() }
	}

	public func subscribe<A: PR>(endpoint: String, options: Options = Options(), _ fn: (A) -> ()) -> Deferred {
		return _subscribe(endpoint, [A.representation()], options: options) { a in return fn(A.self <- a[0]) }
	}

	public func subscribe<A: PR, B: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B) -> ()) -> Deferred {
		return _subscribe(endpoint, [A.representation(), B.representation()], options: options) { a in return fn(A.self <- a[0], B.self <- a[1]) }
	}

	public func subscribe<A: PR, B: PR, C: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C) -> ()) -> Deferred {
		return _subscribe(endpoint, [A.representation(), B.representation(), C.representation()], options: options) { a in return fn(A.self <- a[0], B.self <- a[1], C.self <- a[2]) }
	}

	public func subscribe<A: PR, B: PR, C: PR, D: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D) -> ()) -> Deferred {
		return _subscribe(endpoint, [A.representation(), B.representation(), C.representation(), D.representation()], options: options) { a in return fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3]) }
	}

	public func subscribe<A: PR, B: PR, C: PR, D: PR, E: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E) -> ()) -> Deferred {
		return _subscribe(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation()], options: options) { a in return fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4]) }
	}

	public func subscribe<A: PR, B: PR, C: PR, D: PR, E: PR, F: PR>(endpoint: String, options: Options = Options(), _ fn: (A, B, C, D, E, F) -> ()) -> Deferred {
		return _subscribe(endpoint, [A.representation(), B.representation(), C.representation(), D.representation(), E.representation(), F.representation()], options: options) { a in return fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4], F.self <- a[5]) }
	}

}


// Deferred handler overloads
public extension HandlerDeferred {

	public func then<A: PR>(fn: (A) -> ()) -> Deferred {
		return _then([A.representation()]) { a in return fn(A.self <- a[0]) }
	}

	public func then<A: PR, B: PR>(fn: (A, B) -> ()) -> Deferred {
		return _then([A.representation(), B.representation()]) { a in return fn(A.self <- a[0], B.self <- a[1]) }
	}

	public func then<A: PR, B: PR, C: PR>(fn: (A, B, C) -> ()) -> Deferred {
		return _then([A.representation(), B.representation(), C.representation()]) { a in return fn(A.self <- a[0], B.self <- a[1], C.self <- a[2]) }
	}

	public func then<A: PR, B: PR, C: PR, D: PR>(fn: (A, B, C, D) -> ()) -> Deferred {
		return _then([A.representation(), B.representation(), C.representation(), D.representation()]) { a in return fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3]) }
	}

	public func then<A: PR, B: PR, C: PR, D: PR, E: PR>(fn: (A, B, C, D, E) -> ()) -> Deferred {
		return _then([A.representation(), B.representation(), C.representation(), D.representation(), E.representation()]) { a in
            let f: [Any] = a[0] as! [Any]
            print("Invoking handler with \(a)")
            return fn(A.self <- f[0], B.self <- f[1], C.self <- f[2], D.self <- f[3], E.self <- f[4])
            
        }
	}

	public func then<A: PR, B: PR, C: PR, D: PR, E: PR, F: PR>(fn: (A, B, C, D, E, F) -> ()) -> Deferred {
		return _then([A.representation(), B.representation(), C.representation(), D.representation(), E.representation(), F.representation()]) { a in return fn(A.self <- a[0], B.self <- a[1], C.self <- a[2], D.self <- a[3], E.self <- a[4], F.self <- a[5]) }
	}

}

