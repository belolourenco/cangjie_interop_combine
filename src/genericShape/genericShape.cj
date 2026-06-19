package multi_language_interop.genericShape

public class Point<GenericRuntime> where GenericRuntime <: Runtime<GenericRuntime> {
    public let blob: Extern<GenericRuntime>

    public init(module: Extern<GenericRuntime>, x: Float64, y: Float64) {
        println("Point constructor called with x: ${x}, y: ${y}")
        blob = module.Point(x, y)
    }

    // Shallow copy constructor!
    public init(extern: Extern<GenericRuntime>) {
        println("Point extern constructor called")
        blob = extern
    }

    // Deep copy constructor!
    public init(module: Extern<GenericRuntime>, other: Point<GenericRuntime>) {
        println("Point copy constructor called with x: ${other.x}, y: ${other.y}")
        blob = module.Point(other.x, other.y)
    }

    public mut prop x: Float64 {
        get() {
            // (Float64)blob.x
            let value: Extern<GenericRuntime> = blob.x
            GenericRuntime.fromExtern<Float64>(value)
        }
        set(value) {
            blob.x = value
        }
    }

    public mut prop y: Float64 {
        get() {
            // (Float64)blob.y
            // ->
            let value: Extern<GenericRuntime> = blob.y
            GenericRuntime.fromExtern<Float64>(value)
        }
        set(value) {
            blob.y = value
        }
    }

    public func distanceTo(other: Point<GenericRuntime>): Float64 {
        let result: Extern<GenericRuntime> = blob.distanceTo(other.blob)
        GenericRuntime.fromExtern<Float64>(result)
    }
}

public interface Shape<GenericRuntime> where GenericRuntime <: Runtime<GenericRuntime> {

    func getBlob(): Extern<GenericRuntime>

    func name(): String {
        let result: Extern<GenericRuntime> = getBlob().name()
        GenericRuntime.fromExtern<String>(result)
    }

    func area(): Float64 {
        let result: Extern<GenericRuntime> = getBlob().area()
        GenericRuntime.fromExtern<Float64>(result)
    }

    func perimeter(): Float64 {
        let result: Extern<GenericRuntime> = getBlob().perimeter()
        GenericRuntime.fromExtern<Float64>(result)
    }
}

public class Rectangle<GenericRuntime> <: Shape<GenericRuntime> where GenericRuntime <: Runtime<GenericRuntime> {
    public let blob: Extern<GenericRuntime>

    public init(module: Extern<GenericRuntime>, topLeft: Point<GenericRuntime>, bottomRight: Point<GenericRuntime>) {
        println("Rectangle constructor called with topLeft: ${topLeft.x}, ${topLeft.y} and bottomRight: ${bottomRight.x}, ${bottomRight.y}")
        blob = module.Rectangle(topLeft.blob, bottomRight.blob)
    }

    public init(extern: Extern<GenericRuntime>) {
        blob = extern
    }

    public func getBlob(): Extern<GenericRuntime> {
        blob
    }

    public mut prop topLeft: Point<GenericRuntime> {
        get() {
            // Point(blob.topLeft)
            // ->
            let value: Extern<GenericRuntime> = blob.topLeft
            Point<GenericRuntime>(value)
        }
        set(value) {
            blob.topLeft = value.blob
        }
    }

    public mut prop bottomRight: Point<GenericRuntime> {
        get() {
            Point<GenericRuntime>(blob.bottomRight)
        }
        set(value) {
            blob.bottomRight = value.blob
        }
    }

    public mut prop width: Float64 {
        get() {
            // (Float64)blob.width
            // ->
            let value: Extern<GenericRuntime> = blob.width
            GenericRuntime.fromExtern<Float64>(value)
        }
        set(value) {
            blob.width = value
        }
    }

    public mut prop height: Float64 {
        get() {
            // (Float64)blob.height
            // ->
            let value: Extern<GenericRuntime> = blob.height
            GenericRuntime.fromExtern<Float64>(value)
        }
        set(value) {
            blob.height = value
        }
    }
}

public class Circle<GenericRuntime> <: Shape<GenericRuntime> where GenericRuntime <: Runtime<GenericRuntime> {
    public let blob: Extern<GenericRuntime>

    public init(module: Extern<GenericRuntime>, center: Point<GenericRuntime>, radius: Float64) {
        blob = module.Circle(center.blob, radius)
    }

    public init(extern: Extern<GenericRuntime>) {
        blob = extern
    }

    public func getBlob(): Extern<GenericRuntime> {
        blob
    }

    public mut prop center: Point<GenericRuntime> {
        get() {
            Point<GenericRuntime>(blob.center)
        }
        set(value) {
            blob.center = value.blob
        }
    }

    public mut prop radius: Float64 {
        get() {
            // (Float64)blob.radius
            // ->
            let value: Extern<GenericRuntime> = blob.radius
            GenericRuntime.fromExtern<Float64>(value)
        }
        set(value) {
            blob.radius = value
        }
    }
}

public class Triangle<GenericRuntime> <: Shape<GenericRuntime> where GenericRuntime <: Runtime<GenericRuntime> {
    public let blob: Extern<GenericRuntime>

    public init(module: Extern<GenericRuntime>, a: Point<GenericRuntime>, b: Point<GenericRuntime>, c: Point<GenericRuntime>) {
        blob = module.Triangle(a.blob, b.blob, c.blob)
    }

    public init(extern: Extern<GenericRuntime>) {
        blob = extern
    }

    public func getBlob(): Extern<GenericRuntime> {
        blob
    }

    public mut prop a: Point<GenericRuntime> {
        get() {
            Point<GenericRuntime>(blob.a)
        }
        set(value) {
            blob.a = value.blob
        }
    }

    public mut prop b: Point<GenericRuntime> {
        get() {
            Point<GenericRuntime>(blob.b)
        }
        set(value) {
            blob.b = value.blob
        }
    }

    public mut prop c: Point<GenericRuntime> {
        get() {
            Point<GenericRuntime>(blob.c)
        }
        set(value) {
            blob.c = value.blob
        }
    }
}
