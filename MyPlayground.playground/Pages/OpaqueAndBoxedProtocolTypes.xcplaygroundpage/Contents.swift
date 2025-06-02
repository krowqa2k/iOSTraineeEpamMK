import Foundation

protocol Shape {
    func area() -> Double
    func perimeter() -> Double
}

class Circle: Shape {
    let radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func area() -> Double {
        let pi = Double.pi
        let area = pi * (radius*radius)
        
        return area
    }
    
    func perimeter() -> Double {
        let pi = Double.pi
        let perimeter = 2 * pi * radius
        
        return perimeter
    }
}

class Rectangle: Shape {
    let width: Double
    let height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func area() -> Double {
        return width * height
    }
    
    func perimeter() -> Double {
        return 2*(width + height)
    }
}

func generateShape() -> some Shape {
    let circle = Circle(radius: 5)
    
    return circle
}

func calculateShapeDetails(_ shape: Shape) -> (area: Double, perimeter: Double) {
    return (shape.area(), shape.perimeter())
}

