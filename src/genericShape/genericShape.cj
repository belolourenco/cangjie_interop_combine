package multi_language_interop.genericShape

public class Point<T> where T <: Runtime<T> {
    public let blob: Extern<T>

    public init(module: Extern<T>, x: Float64, y: Float64) {
        println("Point constructor called with x: ${x}, y: ${y}")
        // blob = module.Point(x, y)
        // ->
        let pointConstructor: Extern<T> = module.Point
        blob = T.functionCall(pointConstructor, [x, y])
    }

    // Shallow copy constructor!
    public init(extern: Extern<T>) {
        println("Point extern constructor called")
        blob = extern
    }

    // Deep copy constructor!
    public init(module: Extern<T>, other: Point<T>) {
        println("Point copy constructor called with x: ${other.x}, y: ${other.y}")
        // blob = module.Point(other.x, other.y)
        // ->
        let pointConstructor: Extern<T> = module.Point
        blob = T.functionCall(pointConstructor, [other.x, other.y])
    }

    public mut prop x: Float64 {
        get() {
            // (Float64)blob.x
            let value: Extern<T> = blob.x
            T.fromExtern<Float64>(value)
        }
        set(value) {
            blob.x = value
        }
    }

    public mut prop y: Float64 {
        get() {
            // (Float64)blob.y
            // ->
            let value: Extern<T> = blob.y
            T.fromExtern<Float64>(value)
        }
        set(value) {
            blob.y = value
        }
    }

    public func distanceTo(other: Point<T>): Float64 {
        // blob.distanceTo(other.blob)
        // ->
        let distanceToMethod: Extern<T> = blob.distanceTo
        let result: Extern<T> = T.functionCall(distanceToMethod, [other.blob])
        T.fromExtern<Float64>(result)
    }
}

public interface Shape<T> where T <: Runtime<T> {

    func getBlob(): Extern<T>

    func name(): String {
        // getBlob().name()
        // ->
        let nameMethod: Extern<T> = getBlob().name
        let result: Extern<T> = T.functionCall(nameMethod, [])
        T.fromExtern<String>(result)
    }

    func area(): Float64 {
        // getBlob().area()
        // ->
        let areaMethod: Extern<T> = getBlob().area
        let result: Extern<T> = T.functionCall(areaMethod, [])
        T.fromExtern<Float64>(result)
    }

    func perimeter(): Float64 {
        // getBlob().perimeter()
        // ->
        let perimeterMethod: Extern<T> = getBlob().perimeter
        let result: Extern<T> = T.functionCall(perimeterMethod, [])
        T.fromExtern<Float64>(result)
    }
}

public class Rectangle<T> <: Shape<T> where T <: Runtime<T> {
    public let blob: Extern<T>

    public init(module: Extern<T>, topLeft: Point<T>, bottomRight: Point<T>) {
        println("Rectangle constructor called with topLeft: ${topLeft.x}, ${topLeft.y} and bottomRight: ${bottomRight.x}, ${bottomRight.y}")
        // blob = module.Rectangle(topLeft.blob, bottomRight.blob)
        // ->
        let rectangleConstructor: Extern<T> = module.Rectangle
        blob = T.functionCall(rectangleConstructor, [topLeft.blob, bottomRight.blob])
    }

    public init(extern: Extern<T>) {
        blob = extern
    }

    public func getBlob(): Extern<T> {
        blob
    }

    public mut prop topLeft: Point<T> {
        get() {
            // Point(blob.topLeft)
            // ->
            let value: Extern<T> = blob.topLeft
            Point<T>(value)
        }
        set(value) {
            blob.topLeft = value.blob
        }
    }

    public mut prop bottomRight: Point<T> {
        get() {
            Point<T>(blob.bottomRight)
        }
        set(value) {
            blob.bottomRight = value.blob
        }
    }

    public mut prop width: Float64 {
        get() {
            // (Float64)blob.width
            // ->
            let value: Extern<T> = blob.width
            T.fromExtern<Float64>(value)
        }
        set(value) {
            blob.width = value
        }
    }

    public mut prop height: Float64 {
        get() {
            // (Float64)blob.height
            // ->
            let value: Extern<T> = blob.height
            T.fromExtern<Float64>(value)
        }
        set(value) {
            blob.height = value
        }
    }
}

public class Circle<T> <: Shape<T> where T <: Runtime<T> {
    public let blob: Extern<T>

    public init(module: Extern<T>, center: Point<T>, radius: Float64) {
        // blob = module.Circle(center.blob, radius)
        // ->
        let circleConstructor: Extern<T> = module.Circle
        blob = T.functionCall(circleConstructor, [center.blob, radius])
    }

    public init(extern: Extern<T>) {
        blob = extern
    }

    public func getBlob(): Extern<T> {
        blob
    }

    public mut prop center: Point<T> {
        get() {
            Point<T>(blob.center)
        }
        set(value) {
            blob.center = value.blob
        }
    }

    public mut prop radius: Float64 {
        get() {
            // (Float64)blob.radius
            // ->
            let value: Extern<T> = blob.radius
            T.fromExtern<Float64>(value)
        }
        set(value) {
            blob.radius = value
        }
    }
}

public class Triangle<T> <: Shape<T> where T <: Runtime<T> {
    public let blob: Extern<T>

    public init(module: Extern<T>, a: Point<T>, b: Point<T>, c: Point<T>) {
        // blob = module.Triangle(a.blob, b.blob, c.blob)
        // ->
        let triangleConstructor: Extern<T> = module.Triangle
        blob = T.functionCall(triangleConstructor, [a.blob, b.blob, c.blob])
    }

    public init(extern: Extern<T>) {
        blob = extern
    }

    public func getBlob(): Extern<T> {
        blob
    }

    public mut prop a: Point<T> {
        get() {
            Point<T>(blob.a)
        }
        set(value) {
            blob.a = value.blob
        }
    }

    public mut prop b: Point<T> {
        get() {
            Point<T>(blob.b)
        }
        set(value) {
            blob.b = value.blob
        }
    }

    public mut prop c: Point<T> {
        get() {
            Point<T>(blob.c)
        }
        set(value) {
            blob.c = value.blob
        }
    }
}
