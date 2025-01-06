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
    func h<T>(_:T) where T:CustomStringConvertible

    public
    func h(_:some StringProtocol)

    public
    func h(_:any Error)
}
