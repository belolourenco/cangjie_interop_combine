package multi_language_interop

class AssertionError <: Exception {
    public AssertionError(message: String) {
        super(message)
    }
}

func assert(condition: Bool, message: String): Unit {
    if (!condition) {
        throw AssertionError(message)
    }

}