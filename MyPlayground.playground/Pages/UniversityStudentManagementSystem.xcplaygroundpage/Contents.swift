import Foundation

class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    convenience init?(validationForAge name: String, age: Int) {
        if age < 16 {
            return nil
        } else {
            self.init(name: name, age: age)
        }
    }
}

class Student: Person {
    let studentID: String
    var major: String
    
    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        
        super.init(name: name, age: age)
    }
    
    convenience init(name: String, age: Int, studentID: String) {
        let defaultMajor: String = "defaultMajor"
        
        self.init(name: name, age: age, studentID: studentID, major: defaultMajor)
    }
}

class Professor: Person {
    let faculty: String
    
    init(faculty: String, name: String, age: Int) {
        self.faculty = faculty
        
        super.init(name: name, age: age)
    }
}

struct University {
    let name: String
    let location: String
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
