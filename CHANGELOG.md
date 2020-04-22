# 0.5.0 - 2020-04-21

* Add basic support for linked cards.

# 0.4.4 - 2020-04-16

* Add support for story attachments with various tools regarding cover ones
  and urls.

# 0.4.0 - 2020-04-08

* Http bumped to "~> 4.2" which yields possible broken API since Http no longer
  exists, and is replaced by HTTP.

* Client#dimensions no longer accept a dimension code. Use Client#dimension
  instead.

* Client#dimension (resp. Client#dimensions) now return instances of the
  Klaro::Client::Dimension (resp. Klaro::Client::Dimensions) classes, no
  longer of ruby Hash.

* Client#stories is removed. Please use Client#board_stories instead.

* Board stories are no longer fully loaded by default. You must request the
  individual story to get its full specification.

# 0.3.0 - 2020-01-06

* First really 'official' version
