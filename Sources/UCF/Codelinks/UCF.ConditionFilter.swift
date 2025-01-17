extension UCF
{
    @frozen public
    struct ConditionFilter:Equatable, Hashable, Sendable
    {
        public
        let label:Condition
        public
        let value:String?

        @inlinable public
        init(label:Condition, value:String? = nil)
        {
            self.label = label
            self.value = value
        }
    }
}
