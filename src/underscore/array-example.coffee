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

b = [ [1,2,3], [4,5,6], [7, 8, 9] ]
_c(b).flatten().value()
# => 1,2,3,4,5,6,7,8,9

_c(a).without(1, 2).value()
# => 3,4,5

c = [1, 2, 2, 3, 3, 3]
_c(c).uniq().value()
# => 1,2,3
_c(c).unique().value()
# => 1,2,3

_c(a).intersect(c).value()
# => 1,2,3

# Stop at zip
