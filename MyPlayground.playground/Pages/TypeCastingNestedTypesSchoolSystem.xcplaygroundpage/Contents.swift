import Foundation

struct School {
    enum SchoolRole {
        case student
        case teacher
        case administrator
    }
    
    class Person {
        let name: String
        var role: SchoolRole
        
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
    }
    
    var personArray: [Person] = []
    
    subscript(role: SchoolRole) -> [Person] {
        return personArray.filter { $0.role == role }
    }
    
    mutating func addPerson(_ person: Person) {
        personArray.append(person)
    }
}

func countStudents(school: School) -> Int {
    return school[.student].count
}

func countTeachers(school: School) -> Int {
    return school[.teacher].count
}

func countAdministrators(school: School) -> Int {
    return school[.administrator].count
}
