import Foundation

class Person {
    var name: String
    var age: Int
    
    var isAdult: Bool {
        self.age >= 18
    }
    
    static let minAgeForEnrollment = 16
    
    lazy var profileDescription: String = {
        return "\(self.name) is \(self.age) years old."
    }()
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    convenience init?(validationForAge name: String, age: Int) {
        if age < Person.minAgeForEnrollment {
            return nil
        } else {
            self.init(name: name, age: age)
        }
    }
}

class Student: Person {
    let studentID: String
    var major: String
    
    nonisolated(unsafe) static var studentCount: Int = 0
    
    weak var advisor: Professor?
    
    var formattedID: String {
        "ID: \(studentID.uppercased())"
    }
    
    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        
        Student.studentCount += 1
    }
    
    convenience init(name: String, age: Int, studentID: String) {
        let defaultMajor: String = "defaultMajor"
        
        self.init(name: name, age: age, studentID: studentID, major: defaultMajor)
    }
    
    deinit {
        Student.studentCount -= 1
    }
}

class Professor: Person {
    let faculty: String
    
    nonisolated(unsafe) static var professorCount: Int = 0
    
    var fullTitle: String {
        "Professor: \(name), \(faculty)"
    }
    
    init(faculty: String, name: String, age: Int) {
        self.faculty = faculty
        super.init(name: name, age: age)
        
        Professor.professorCount += 1
    }
    
    deinit {
        Professor.professorCount -= 1
    }
}

struct University {
    let name: String
    let location: String
    
    var description: String {
        "\(name) is located in \(location)"
    }
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}

