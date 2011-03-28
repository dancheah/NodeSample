#!/usr/bin/env coffee

# Working through underscore and underscore.string examples

# Doing imports
_ = require('underscore')

# Plugin underscore.string into underscore
_.mixin(require('underscore.string'))

# Playing around with each
_.each([1,2,3], (n) -> console.log(n))
_.each({ one: 1, two: 2, three: 3 }, (k, v) -> console.log("#{k} #{v}"))

# foldl == reduce
s = _.foldl(_.map([1,2,3], (n) -> n * 3), ((m, n) -> m + n), 0)
s = _.reduce(_.map([1,2,3], (n) -> n * 3), ((m, n) -> m + n), 0)

# foldr == reduceRight (not as useful as in Haskell)
s = _.foldr(_.map([1,2,3], (n) -> n * 3), ((m, n) -> m + n), 0)
s = _.reduceRight(_.map([1,2,3], (n) -> n * 3), ((m, n) -> m + n), 0)

# All the fold/reduce above have the same result.

# detect
_.detect([1,2,3,4,5,6], (n) -> n % 2 == 0)

# select
_.select([1,2,3,4,5,6], (n) -> n % 2 == 0)

# reject
_.reject([1,2,3,4,5,6], (n) -> n % 2 == 0)

# select resembles filter in Haskell. detect is like select
# but only returns the first element that matches the filter function.
# reject filters anything that doesn't match the filter function. 

# all == every
_.all([10, 9, 5], (n) -> n > 5)
# => false
_.all([10, 9, 5], (n) -> n > 4)
# => true
_.every([10, 9, 5], (n) -> n > 5)
# => false
_.every([10, 9, 5], (n) -> n > 4)
# => true

# any == some
_.any([10, 9, 5], (n) -> n > 4)
# => true
_.any([10, 9, 5], (n) -> n > 5)
# => true
_.some([10, 9, 5], (n) -> n > 4)
# => true
_.some([10, 9, 5], (n) -> n > 5)
# => true

# include == contains
_.include(["hello", "world"], "hello")
# => true
_.include(["hello", "world"], "helllo")
# => false
_.contains(["hello", "world"], "hello")
# => true
_.contains(["hello", "world"], "helllo")
# => false

# invoke == feels like a map with some additional marshalling
_.invoke(["hello", "world"], 'toUpperCase')
# => HELLO,WORLD
_.invoke(["hello", "world"], 'substr')
# => hello,world
_.invoke(["hello", "world"], 'substr', 0, 1)
# => h,w

stooges = [{name : 'moe', age : 40}, {name : 'larry', age : 50}, {name : 'curly', age : 60}];
_.pluck(stooges, 'name')
# => moe,larry,curly
_.pluck(stooges, 'age')
# => 40,50,60

_.max(stooges, (s) -> s.age).name
# => curly
_.min(stooges, (s) -> s.age).name
# => moe

_.each(_.sortBy(stooges, (s) -> s.age), (o) -> console.log(o))
