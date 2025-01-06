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
}
