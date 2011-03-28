#!/usr/bin/env coffee

# Working through underscore and underscore.string examples
_ = require('underscore')
_s = require('underscore.string')

_.each([1,2,3], (n) -> console.log(n))
_.each({ one: 1, two: 2, three: 3 }, (k, v) -> console.log("#{k} #{v}"))

s = _.foldl(_.map([1,2,3], (n) -> n * 3), ((m, n) -> m + n), 0)
s = _.reduce(_.map([1,2,3], (n) -> n * 3), ((m, n) -> m + n), 0)
s = _.foldr(_.map([1,2,3], (n) -> n * 3), ((m, n) -> m + n), 0)
s = _.reduceRight(_.map([1,2,3], (n) -> n * 3), ((m, n) -> m + n), 0)
console.log("s #{s}")

