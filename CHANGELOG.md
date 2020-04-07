# 0.4.0

* Http bumped to "~> 4.2" which yields possible broken API since Http no longer
  exists, and is replaced by HTTP.
* Client#dimensions no longer accept a dimension code. Use Client#dimension
  instead.
* Client#dimension (resp. Client#dimensions) now return instances of the
  Klaro::Client::Dimension (resp. Klaro::Client::Dimensions) classes, no
  longer of ruby Hash.

# 0.3.0 - 2020-01-06

* First really 'official' version
