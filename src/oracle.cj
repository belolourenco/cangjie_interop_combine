package multi_language_interop

import std.math.*

func distance(x1: Float64, y1: Float64, x2: Float64, y2: Float64): Float64 {
    sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
}

func area_rectangle(x1: Float64, y1: Float64, x2: Float64, y2: Float64): Float64 {
    abs(x1 - x2) * abs(y1 - y2)
}

func perimeter_rectangle(x1: Float64, y1: Float64, x2: Float64, y2: Float64): Float64 {
    abs(x1 - x2) * 2.0 + abs(y1 - y2) * 2.0
}

func area_circle(radius: Float64): Float64 {
    Float64.getPI() * radius * radius
}

func perimeter_circle(radius: Float64): Float64 {
    2.0 * Float64.getPI() * radius
}

func area_triangle(x1: Float64, y1: Float64, x2: Float64, y2: Float64, x3: Float64, y3: Float64): Float64 {
    let s = (x1 * y2 - x1 * y3 + x2 * y3 - x2 * y1 + x3 * y1 - x3 * y2) / 2.0
    abs(s)
}

func perimeter_triangle(x1: Float64, y1: Float64, x2: Float64, y2: Float64, x3: Float64, y3: Float64): Float64 {
    let a = distance(x1, y1, x2, y2)
    let b = distance(x2, y2, x3, y3)
    let c = distance(x3, y3, x1, y1)
    a + b + c
}