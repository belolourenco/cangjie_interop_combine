package multi_language_interop

import std.collection.ArrayList

public func genericTestExternWithModules1<GenericRuntime>(externalModule: Extern<GenericRuntime>, globalAccess: (String)->Extern<GenericRuntime>) where GenericRuntime <: Runtime<GenericRuntime> {

    // ---- my_function ----

    // externalModule.my_function()
    // ->
    let my_function: Extern<GenericRuntime> = externalModule.my_function
    GenericRuntime.functionCall(my_function, [])

    // ---- lookup ----

    // let lookupResult: Extern<GenericRuntime> = externalModule.lookup(42.4242, 1.111)
    // ->
    let lookup: Extern<GenericRuntime> = externalModule.lookup
    let lookupResult: Extern<GenericRuntime> = GenericRuntime.functionCall(lookup, [42.4242, 1.111])

    // println("Lookup coordinates: (${(Float64)lookupResult.coordinates[0]}, ${(Float64)lookupResult.coordinates[1]})")
    println("Lookup coordinates: (${GenericRuntime.fromExtern<Float64>(lookupResult.coordinates[0])}, ${GenericRuntime.fromExtern<Float64>(lookupResult.coordinates[1])})")
    assert(GenericRuntime.fromExtern<Float64>(lookupResult.coordinates[0]) == 1.111000, "Lookup coordinates[0] should be 1.111000")
    assert(GenericRuntime.fromExtern<Float64>(lookupResult.coordinates[1]) == 42.424200, "Lookup coordinates[1] should be 42.424200")

    // println("Lookup result: ${(String)lookupResult.name}")
    // ->
    println("Lookup result: ${GenericRuntime.fromExtern<String>(lookupResult.name)}")
    assert(GenericRuntime.fromExtern<String>(lookupResult.name) == "Space Needle", "Lookup name should be 'My Location'")

    // println("Lookup result: ${(String)lookupResult.city}")
    // ->
    println("Lookup result: ${GenericRuntime.fromExtern<String>(lookupResult.city)}")
    assert(GenericRuntime.fromExtern<String>(lookupResult.city) == "Seattle", "Lookup city should be 'Seattle'")

    // println("Lookup result: ${(String)lookupResult.category}")
    // ->
    println("Lookup result: ${GenericRuntime.fromExtern<String>(lookupResult.category)}")
    assert(GenericRuntime.fromExtern<String>(lookupResult.category) == "Landmark", "Lookup category should be 'Landmark'")

    // ---- Rectangle ----

    // let rectangle: Extern<GenericRuntime> = externalModule.Rectangle(10, 11)
    // ->
    let rectangleConstructor: Extern<GenericRuntime> = externalModule.Rectangle
    let rectangleObject: Extern<GenericRuntime> = GenericRuntime.functionCall(rectangleConstructor, [10, 11])

    // let rectangleWidth: Extern<GenericRuntime> = rectangleObject.getWidth()
    // ->
    let rectangleWidthMethod: Extern<GenericRuntime> = rectangleObject.getWidth
    let rectangleWidthResult: Extern<GenericRuntime> = GenericRuntime.functionCall(rectangleWidthMethod, [])
    println("Rectangle width: ${GenericRuntime.fromExtern<Float64>(rectangleWidthResult)}")
    assert(GenericRuntime.fromExtern<Float64>(rectangleWidthResult) == 10.0, "Rectangle width should be 10.0")

    // // let rectangleHeight: Extern<GenericRuntime> = rectangleObject.getHeight()
    // // ->
    let rectangleHeightMethod: Extern<GenericRuntime> = rectangleObject.getHeight
    let rectangleHeightResult: Extern<GenericRuntime> = GenericRuntime.functionCall(rectangleHeightMethod, [])
    println("Rectangle height: ${GenericRuntime.fromExtern<Float64>(rectangleHeightResult)}")
    assert(GenericRuntime.fromExtern<Float64>(rectangleHeightResult) == 11.0, "Rectangle height should be 11.0")

    // ---- createRectangle ----

    // // let rectangleObject2: Extern<GenericRuntime> = externalModule.createRectangle()
    // // ->
    let createRectangleMethod: Extern<GenericRuntime> = externalModule.createRectangle
    let rectangleObject2: Extern<GenericRuntime> = GenericRuntime.functionCall(createRectangleMethod, [])

    rectangleObject2.width = 42.0

    let rectangleWidth2: Extern<GenericRuntime> = rectangleObject2.width
    
    // println("Rectangle width: ${(Float64)rectangleWidth2}")
    println("Rectangle width: ${GenericRuntime.fromExtern<Float64>(rectangleWidth2)}")
    assert(GenericRuntime.fromExtern<Float64>(rectangleWidth2) == 42.0, "Rectangle width should be 42.0")

    let rectangleHeight2: Extern<GenericRuntime> = rectangleObject2.height

    // println("Rectangle height: ${(Float64)rectangleHeight2}")
    println("Rectangle height: ${GenericRuntime.fromExtern<Float64>(rectangleHeight2)}")
    assert(GenericRuntime.fromExtern<Float64>(rectangleHeight2) == 13.0, "Rectangle height should be 13.0")

    // let area = rectangleObject2.area()
    // ->
    let areaMethod: Extern<GenericRuntime> = rectangleObject2.area
    let areaResult: Extern<GenericRuntime> = GenericRuntime.functionCall(areaMethod, [])

    // println("Rectangle area: ${(Float64)areaResult}")
    // ->
    println("Rectangle area: ${GenericRuntime.fromExtern<Float64>(areaResult)}")
    assert(GenericRuntime.fromExtern<Float64>(areaResult) == 546.0, "Rectangle area should be 546.0")

    // let perimeter = rectangleObject2.perimeter()
    // ->
    let perimeterMethod: Extern<GenericRuntime> = rectangleObject2.perimeter
    let perimeterResult: Extern<GenericRuntime> = GenericRuntime.functionCall(perimeterMethod, [])

    // println("Rectangle perimeter: ${(Float64)perimeterResult}")
    // ->
    println("Rectangle perimeter: ${GenericRuntime.fromExtern<Float64>(perimeterResult)}")
    assert(GenericRuntime.fromExtern<Float64>(perimeterResult) == 110.0, "Rectangle perimeter should be 110.0")

    // ---- accessing global variables ----

    let globalBoolean: Extern<GenericRuntime> = externalModule.globalBoolean
    println("Global boolean: ${GenericRuntime.fromExtern<Bool>(globalBoolean)}")
    assert(GenericRuntime.fromExtern<Bool>(globalBoolean) == true, "Global boolean should be true")

    let globalNumber: Extern<GenericRuntime> = externalModule.globalNumber
    println("Global number: ${GenericRuntime.fromExtern<Float64>(globalNumber)}")
    assert(GenericRuntime.fromExtern<Float64>(globalNumber) == 42.4242, "Global number should be 42.4242")

    let globalString: Extern<GenericRuntime> = externalModule.globalString
    println("Global string: ${GenericRuntime.fromExtern<String>(globalString)}")
    assert(GenericRuntime.fromExtern<String>(globalString) == "hello from JavaScript" || 
           GenericRuntime.fromExtern<String>(globalString) == "hello from Python",
           "Global string should be 'hello from JavaScript' or 'hello from Python'")

    // ---- array access and assignment ----

    let globalArray: Extern<GenericRuntime> = externalModule.globalArray
    let arrayElements: ArrayList<Int64> = genericConvertArrayToArrayList(globalArray)
    println("Global array elements: ${arrayElements}")
    assert(arrayElements[0] == 1, "Global array element 0 should be 1")
    assert(arrayElements[1] == 2, "Global array element 1 should be 2")
    assert(arrayElements[2] == 3, "Global array element 2 should be 3")

    globalArray[1] = 42

    let arrayElements2: ArrayList<Int64> = genericConvertArrayToArrayList(globalArray)
    println("Global array elements: ${arrayElements2}")
    assert(arrayElements2[0] == 1, "Global array element 0 should be 1")
    assert(arrayElements2[1] == 42, "Global array element 1 should be 42")
    assert(arrayElements2[2] == 3, "Global array element 2 should be 3")

    try {
        globalArray[-1]
        throw AssertionError("Global array element -1 should be out of range")
    } catch (e: ExternDynamicException) {
        println("Expected exception: ${e.message}")
    }


    try {
        globalArray[-1] = 42
        throw AssertionError("Global array element -1 should be out of range")
    } catch (e: ExternDynamicException) {
        println("Expected exception: ${e.message}")
    }

    try {
        let x = globalArray[3]
        println("Global array element 3: ${GenericRuntime.fromExtern<Int64>(x)}")
        throw AssertionError("Global array element 3 should be out of range")
    } catch (e: ExternDynamicException) {
        println("Expected exception: ${e.message}")
    }

    try {
        globalArray[3] = 42
        throw AssertionError("Global array element 3 should be out of range")
    } catch (e: ExternDynamicException) {
        println("Expected exception: ${e.message}")
    }

    // ---- global object ----

    let globalObject: Extern<GenericRuntime> = externalModule.globalObject

    let globalObjectName: Extern<GenericRuntime> = globalObject.name
    println("Global object name: ${GenericRuntime.fromExtern<String>(globalObjectName)}")
    assert(GenericRuntime.fromExtern<String>(globalObjectName) == "global object", "Global object name should be 'global object'")

    let globalObjectEnabled: Extern<GenericRuntime> = globalObject.enabled
    println("Global object enabled: ${GenericRuntime.fromExtern<Bool>(globalObjectEnabled)}")
    assert(GenericRuntime.fromExtern<Bool>(globalObjectEnabled) == true, "Global object enabled should be true")

    let globalObjectValues: Extern<GenericRuntime> = globalObject.values
    let globalObjectValuesElements: ArrayList<Int64> = genericConvertArrayToArrayList(globalObjectValues)
    println("Global object values elements: ${globalObjectValuesElements}")
    assert(globalObjectValuesElements[0] == 10, "Global object values element 0 should be 10")
    assert(globalObjectValuesElements[1] == 20, "Global object values element 1 should be 20")
    assert(globalObjectValuesElements[2] == 30, "Global object values element 2 should be 30")

    globalObject.name = "global object 2"
    let globalObjectName2: Extern<GenericRuntime> = globalObject.name
    println("Global object name: ${GenericRuntime.fromExtern<String>(globalObjectName2)}")
    assert(GenericRuntime.fromExtern<String>(globalObjectName2) == "global object 2", "Global object name should be 'global object 2'")

    globalObject.enabled = false
    let globalObjectEnabled2: Extern<GenericRuntime> = globalObject.enabled
    println("Global object enabled: ${GenericRuntime.fromExtern<Bool>(globalObjectEnabled2)}")
    assert(GenericRuntime.fromExtern<Bool>(globalObjectEnabled2) == false, "Global object enabled should be false")

    let globalObjectValues2: Extern<GenericRuntime> = globalObject.values
    globalObject.values[1] = 42
    let globalObjectValuesElements2: ArrayList<Int64> = genericConvertArrayToArrayList(globalObjectValues2)
    println("Global object values elements: ${globalObjectValuesElements2}")
    assert(globalObjectValuesElements2[0] == 10, "Global object values element 0 should be 10")
    assert(globalObjectValuesElements2[1] == 42, "Global object values element 1 should be 42")
    assert(globalObjectValuesElements2[2] == 30, "Global object values element 2 should be 30")

    // assignment to global variables

    externalModule.globalNumber = 0.0

    let globalNumber2: Extern<GenericRuntime> = externalModule.globalNumber
    println("Global number: ${GenericRuntime.fromExtern<Float64>(globalNumber2)}")
    assert(GenericRuntime.fromExtern<Float64>(globalNumber2) == 0.0, "Global number should be 0.0")

    let mystring = "hello from JavaScript but much longer than the original string but should be the same string because it is the same string object in JavaScript but with a different reference in JavaScript and llm is very good at generating the same string object in JavaScript mor text is needed to make it different"
    externalModule.globalString = mystring
    let globalString2: Extern<GenericRuntime> = externalModule.globalString
    println("Global string: ${GenericRuntime.fromExtern<String>(globalString2)}")
    assert(GenericRuntime.fromExtern<String>(globalString2) == mystring, "Global string should be '${mystring}'")


    globalObject.name = "global object 3"
    let globalObjectName3: Extern<GenericRuntime> = globalObject.name
    println("Global object name: ${GenericRuntime.fromExtern<String>(globalObjectName3)}")
    assert(GenericRuntime.fromExtern<String>(globalObjectName3) == "global object 3", "Global object name should be 'global object 3'")

    println("Global object name: ${GenericRuntime.fromExtern<String>(globalObjectName2)}")
    assert(GenericRuntime.fromExtern<String>(globalObjectName2) == "global object 2", "Global object name should be 'global object 2'")

    let globalStringNumberMap: Extern<GenericRuntime> = externalModule.globalStringNumberMap
    // TODO: to be discussed!
    let e_object: Extern<GenericRuntime> = globalAccess("Object")
    let e_keys: Extern<GenericRuntime> = e_object.keys
    let mapKeys: Extern<GenericRuntime> = GenericRuntime.functionCall(e_keys, [globalStringNumberMap])
    let mapKeysLength: Extern<GenericRuntime> = mapKeys.length

    let mapKeysLengthInt64: Int64 = GenericRuntime.fromExtern<Int64>(mapKeysLength)
    println("Global string number map length: ${mapKeysLengthInt64}")
    assert(mapKeysLengthInt64 == 3, "Global string number map length should be 3")

    let mapKeysElements: ArrayList<String> = genericConvertArrayToArrayList(mapKeys)
    println("Global string number map keys: ${mapKeysElements}")
    assert(mapKeysElements[0] == "one", "Global string number map key 0 should be 'one'")
    assert(mapKeysElements[1] == "two", "Global string number map key 1 should be 'two'")
    assert(mapKeysElements[2] == "answer", "Global string number map key 2 should be 'answer'")
    
    let e_values: Extern<GenericRuntime> = e_object.values
    let mapValues: Extern<GenericRuntime> = GenericRuntime.functionCall(e_values, [globalStringNumberMap])
    let mapValuesLength: Extern<GenericRuntime> = mapValues.length
    let mapValuesLengthInt64: Int64 = GenericRuntime.fromExtern<Int64>(mapValuesLength)
    println("Global string number map values length: ${mapValuesLengthInt64}")
    assert(mapValuesLengthInt64 == 3, "Global string number map values length should be 3")

    let mapValuesElements: ArrayList<Int64> = genericConvertArrayToArrayList(mapValues)
    println("Global string number map values: ${mapValuesElements}")
    assert(mapValuesElements[0] == 1, "Global string number map value 0 should be 1")
    assert(mapValuesElements[1] == 2, "Global string number map value 1 should be 2")
    assert(mapValuesElements[2] == 42, "Global string number map value 2 should be 42")

    globalStringNumberMap.one = -1
    let globalStringNumberMapOne: Extern<GenericRuntime> = globalStringNumberMap.one
    println("Global string number map one: ${GenericRuntime.fromExtern<Int64>(globalStringNumberMapOne)}")
    assert(GenericRuntime.fromExtern<Int64>(globalStringNumberMapOne) == -1, "Global string number map one should be -1")

    globalStringNumberMap["two"] = -2
    let globalStringNumberMapTwo: Extern<GenericRuntime> = globalStringNumberMap["two"]
    println("Global string number map two: ${GenericRuntime.fromExtern<Int64>(globalStringNumberMapTwo)}")
    assert(GenericRuntime.fromExtern<Int64>(globalStringNumberMapTwo) == -2, "Global string number map two should be -2")
    let globalStringNumberMapTwo_field: Extern<GenericRuntime> = globalStringNumberMap.two
    println("Global string number map two: ${GenericRuntime.fromExtern<Int64>(globalStringNumberMapTwo_field)}")
    assert(GenericRuntime.fromExtern<Int64>(globalStringNumberMapTwo_field) == -2, "Global string number map two should be -2")

    let globalStringNumberMapOne_again: Extern<GenericRuntime> = externalModule.globalStringNumberMap["one"]
    println("Global string number map one: ${GenericRuntime.fromExtern<Int64>(globalStringNumberMapOne_again)}")
    assert(GenericRuntime.fromExtern<Int64>(globalStringNumberMapOne_again) == -1, "Global string number map one should be -1")

    let globalStringNumberMapTwo_again: Extern<GenericRuntime> = externalModule.globalStringNumberMap["two"]
    println("Global string number map two: ${GenericRuntime.fromExtern<Int64>(globalStringNumberMapTwo_again)}")
    assert(GenericRuntime.fromExtern<Int64>(globalStringNumberMapTwo_again) == -2, "Global string number map two should be -2")

    let globalStringNumberMapAnswer_again: Extern<GenericRuntime> = externalModule.globalStringNumberMap.answer
    println("Global string number map answer: ${GenericRuntime.fromExtern<Int64>(globalStringNumberMapAnswer_again)}")
    assert(GenericRuntime.fromExtern<Int64>(globalStringNumberMapAnswer_again) == 42, "Global string number map answer should be 42")
    
}

func genericConvertArrayToArrayList<T, GenericRuntime>(array: Extern<GenericRuntime>): ArrayList<T> where GenericRuntime <: Runtime<GenericRuntime> {
    let arrayLength: Extern<GenericRuntime> = array.length
    let arrayLengthInt64: Int64 = GenericRuntime.fromExtern<Int64>(arrayLength)
    ArrayList<T>(arrayLengthInt64, { i: Int64 =>
        // TODO
        // GenericRuntime.fromExtern<T>(array[i])
        // ->
        GenericRuntime.fromExtern<T>(GenericRuntime.indexAccess(array, i))
    })
}
