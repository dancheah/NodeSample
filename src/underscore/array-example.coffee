# Working through the various array functions in underscore

# Importing underscore
_ = require('underscore')

# Really liking the use of chain and value now that
# I understand them better.
_c = (x) -> _(x).chain()

# Sample data
a = [1, 2, 3, 4, 5]

# tail, rest, last
_c(a).tail().value()
# => 2,3,4,5
_c(a).head().value()
# => 1
_c(a).last().value()
# => 5

a.push(false)
# => 6
a = _c(a).compact().value()
# => 1,2,3,4,5

# Stopping at flatten for now
