import Riffle
        
class Student: Model {
    var name = "Student Name"
    var age = 20
    var studentID = 0
}

class TourRegBackend: Riffle.Domain, Riffle.Delegate {

    override func onJoin() {
        /////////////////////////////////////////////////////////////////////////////////////
        // Example Tour Reg/Call Lesson 1 - our first basic example
        register("myFirstCall") { (s: String) -> String in
            print(s) // Expects a String, like "Hello"
            return "Hello World"
        }
        // End Example Tour Reg/Call Lesson 1

        /////////////////////////////////////////////////////////////////////////////////////
        // Example Tour Reg/Call Lesson 2 Works - type enforcement good
        register("iWantStrings") { (s: String) -> String in
            print(s) // Expects a String, like "Hi"
            return "Thanks for saying " + s
        }
        // End Example Tour Reg/Call Lesson 2 Works
            
        // Example Tour Reg/Call Lesson 2 Fails - type enforcement bad
        register("iWantInts") { (i: Int) -> String in
            print(i) // Expects an Int, like 42
            return "Thanks for sending int \(i)"
        }
        // End Example Tour Reg/Call Lesson 2 Fails
        
        // Example Tour Reg/Call Lesson 2 Wait Check - type enforcement on wait
        register("iGiveInts") { (s: String) -> Int in
            print(s) // Expects a String, like "Hi"
            return 42
        }
        // End Example Tour Reg/Call Lesson 2 Wait Check
        
        /////////////////////////////////////////////////////////////////////////////////////
        // Example Tour Reg/Call Lesson 3 Works - collections of types
        register("iWantManyStrings") { (s: [String]) -> String in
            print(s) // Expects an [String], like ["This", "is", "cool"]
            return "Thanks for \(s.count) strings!"
        }
        // End Example Tour Reg/Call Lesson 3 Works
        
        // Example Tour Reg/Call Lesson 3 Fails - collections of types
        register("iWantManyInts") { (i: [Int]) -> String in
            print(i) // Expects an [Int], like [0, 1, 2]
            return "Thanks for \(i.count) ints!"
        }
        // End Example Tour Reg/Call Lesson 3 Fails
        
        /////////////////////////////////////////////////////////////////////////////////////
        // TODO - this doesn't work right now because the Student var members don't get passed
        //        down into the core.
        // xample Tour Reg/Call Lesson 4 Basic Student - intro to classes
        register("sendStudent") { (s: Student) in
            print("\(s.name), Age: \(s.age), ID: \(s.studentID)")
        }
        // nd Example Tour Reg/Call Lesson 4 Basic Student
    
        print("___SETUPCOMPLETE___")
    }
    
    override func onLeave() {
        print("Receiver left!")
    }
}
