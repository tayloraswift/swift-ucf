//  snippet.PHYLUM
public
struct Example
{
    public
    let property:Int = 0

    public
    static let property:Int = 1
}
//  snippet.end

//  snippet.REQUIREMENTS
public
protocol ExampleProtocol
{
    func f()

    func g(_:Int32)
    func g(_:Int64)
    func g(_:Int64) -> Int64

    var x:Self { get }
}
extension ExampleProtocol
{
    public
    func f() {}
}
//  snippet.end

//  snippet.REQUIREMENTS_AND_PHYLA
public
protocol AnotherProtocol
{
    func g()
    static func g()
}
extension AnotherProtocol
{
    public
    func g() {}

    public
    static func g() {}
}
//  snippet.end


extension Example
{
    public
    func f(x:Int, y:Substring) {}

    public
    func f(x:Int, y:String) {}

    public
    func g(_:[Int]) {}

    public
    func g(_:[Int: String]) {}

    public
    func g(_:Int!) {}

    public
    func g(_:[Int].Type) {}

    public
    func g(_:[Int: String].Type) {}

    public
    func g(_:Int?.Type) {}

    public
    func g(_:Int...) {}

    public
    func h(_:Set<Int>) {}

    public
    func h(_:Dictionary<Int, Int>.Index) {}

    public
    func h(_:Optional<Int>) {}

    public
    func h<T>(_:T) where T:CustomStringConvertible {}

    public
    func h(_:some StringProtocol) {}

    public
    func h(_:any Error) {}

    public
    func k(_:some Sendable & CustomStringConvertible) {}

    public
    func k(_:any CustomStringConvertible & Sendable) {}

    public
    func l(_:()) {}

    public
    func l(_:Int) {}

    public
    func l(_:(Int, Int)) {}

    public
    func m(_:@Sendable @escaping (Int) -> Int) {}

    public
    func m(_:@Sendable @escaping (Int) -> ()) {}

    public
    func n<each T>(_:repeat [each T]) {}

    public
    func n<each T>(_:repeat [each T: Int]) {}

    public
    func n(_:borrowing some ~Copyable) {}

    public
    func o(_:Self) {}

    public
    func o(_:Void) {}

    public
    func o(_:UTF8.Type) {}
}

extension ExampleProtocol
{
    public
    func o(_:Self) {}

    public
    func o(_:Void) {}
}

extension Example
{
    public
    func r(_:Int) -> Void {}

    public
    func r(_:Int) -> Int { 0 }

    public
    func r(_:Int) -> (Int, String) { (0, "") }

    public
    func s(_:Int) -> (Int, String) { (0, "") }

    public
    func s(_:String) -> (Int, String) { (0, "") }
}

extension ExampleProtocol where Self == Int
{
    public
    var x:Int { 0 }
}
extension ExampleProtocol where Self == [Int]
{
    public
    var x:[Int] { [] }
}
extension ExampleProtocol
{
    public
    var x:(Int, Int) { (0, 0) }
}

extension Int:ExampleProtocol {}
extension [Int]:ExampleProtocol {}

extension ExampleProtocol
{
    public
    func g(_:Int32) {}
    public
    func g(_:Int64) {}
    public
    func g(_:Int64) -> Int64 { 0 }
}
