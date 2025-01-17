extension UCF
{
    @frozen public
    struct Disambiguator:Equatable, Hashable, Sendable
    {
        public
        let conditions:[ConditionFilter]
        public
        let signature:SignatureFilter?

        @inlinable public
        init(conditions:[ConditionFilter], signature:SignatureFilter?)
        {
            self.conditions = conditions
            self.signature = signature
        }
    }
}
extension UCF.Disambiguator
{
    init?(
        signature:borrowing UCF.SignaturePattern?,
        clauses:borrowing [(String, String?)],
        source:borrowing Substring)
    {
        var conditions:[UCF.ConditionFilter] = []
            conditions.reserveCapacity(clauses.count)

        for clause:(String, String?) in copy clauses
        {
            //  The parser already collapses whitespace.
            guard
            let condition:UCF.Condition = .init(clause.0)
            else
            {
                return nil
            }

            conditions.append(.init(label: condition, value: clause.1))
        }

        //  If we got this far, the conditions (if any) were all valid and we can go ahead
        //  and extract the signature.
        self.init(
            conditions: conditions,
            signature: signature.map { .init(parsed: $0, source: source) })
    }
}
