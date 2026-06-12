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


    // ------------- GENERICS -------------


    println()
    println("++++++++++Testing Generic module with my_module.js ++++++++++")
    println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    jsModule = JSRuntime.getModule("js_examples/my_module.js")
    genericTestExternWithModules1(jsModule, { name: String => JSRuntime.globalAccess(name) })

    println()
    println("++++++++++Testing Generic module with my_module.py ++++++++++")
    println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    pyModule = PythonRuntime.getModule("py_examples/my_module.py")
    genericTestExternWithModules1(pyModule, { name: String => PythonRuntime.globalAccess(name) })

    println()
    println("++++++++++Testing Generic module with shapes.js ++++++++++")
    println("+++++++++++++++++++++++++++++++++++++++++++++++++++++")
    jsModule = JSRuntime.getModule("js_examples/shape.js")
    genericTestExternWithModules2(jsModule)

    println()
    println("++++++++++Testing Generic module with shapes.py ++++++++++")
    println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    pyModule = PythonRuntime.getModule("py_examples/shape.py")
    genericTestExternWithModules2(pyModule)
    return 0
}
