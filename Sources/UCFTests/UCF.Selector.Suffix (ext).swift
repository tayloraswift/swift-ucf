import UCF

extension UCF.Selector.Suffix:ExpressibleByArrayLiteral
{
    public
    init(arrayLiteral:UCF.Condition...)
    {
        self = .unidoc(.init(
            conditions: arrayLiteral.map { .init(label: $0, value: nil) },
            signature: nil))
    }
}
extension UCF.Selector.Suffix
{
    static func signature(_ signature:UCF.SignatureFilter) -> Self
    {
        .unidoc(.init(conditions: [], signature: signature))
    }
}
