package multi_language_interop

import interop_python.*
import interop_javascript.*

main(): Int64 {
    println()
    println("++++++++++Testing JS module wieh my_module.js ++++++++++")
    println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    var jsModule = JSRuntime.getModule("js_examples/my_module.js")
    jsTestExternWithModules1(jsModule)

    println()
    println("++++++++++Testing JS module with shapes.js ++++++++++")
    println("+++++++++++++++++++++++++++++++++++++++++++++++++++++")
    jsModule = JSRuntime.getModule("js_examples/shape.js")
    jsTestExternWithModules2(jsModule)


    println()
    println("++++++++++Testing Python module with my_module.py ++++++++++")
    println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    var pyModule = PythonRuntime.getModule("py_examples/my_module.py")
    pyTestExternWithModules1(pyModule)

    println()
    println("++++++++++Testing Python module with shapes.py ++++++++++")
    println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    pyModule = PythonRuntime.getModule("py_examples/shape.py")
    pyTestExternWithModules2(pyModule)
    return 0
}
