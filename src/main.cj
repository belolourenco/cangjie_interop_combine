package multi_language_interop

import interop_python.*
import interop_javascript.*

func foo(e: Extern<PythonRuntime>): Unit {
}

func bar(e: Extern<JSRuntime>): Unit {
}

main(): Int64 {
    println("hello multi-language interop")
    return 0
}
