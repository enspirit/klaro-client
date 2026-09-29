## 0.10.0

* Opened the `http` dependency to 6.x (`>= 5.0, < 7.0`), so that downstream
  applications are free to upgrade. Both 5.3.x and 6.0.x are tested. The two
  places broken by http 6 have been fixed in a way that stays compatible with
  5.x: request options are now splatted as keyword arguments, and response
  headers are read through `response.headers[...]` rather than the removed
  `response[...]` shortcut.

* BREAKING: ruby 3.2 is now the minimal version supported (enforced through
  `required_ruby_version`). This follows from http 6 and commonmarker 2.x,
  which both require it.

* `path` and `ostruct` are now runtime dependencies. Both were already
  required by `lib/klaro/client.rb`, but `path` was only declared as a
  development dependency, and `ostruct` stops being a default gem in ruby 3.5.

* `rake` is now an explicit development dependency. It used to be pulled in
  transitively by `llhttp-ffi`, which http 6 no longer depends on.

* Opened the `dotenv` development dependency to 3.x.

## 0.9.3

* Fix board_stories_full raising an ArgumentError.

## 0.9.2 - 2025-08-07

* Add Client#with_workspace that sets the X-Klaro-ViewAs header

## 0.9.1

* Add support for override options in MdText#to_html

## 0.9.0

* Upgraded dependencies. Commonmark  2.0.

## 0.8.0

* Add support for Client#with_caching that caches GET requests
  to Klaro boards and stories. This is not intended to be used
  in production, as the cache is never invalidated.

## 0.7.0 - 2023-12-08

* BREAKING: removed support for ruby 2.7. Ruby 3.1 is the minimal
  version supported.

* Replaced Redcarpet by Commonmarker, which is closer to the Markdown
  engine we use in Klaro Cards itself, and supports code highlighting
  natively.

## 0.6.0 - 2023-06-23

* Upgraded dependencies, notably http (5.x)

## 0.5.6 - 2021-05-11

* Adds Jenkinsfile and Makefile to help support gem build and release.

## 0.5.5 - 2021-05-10

* Add support for a default workspace view-as header when authentifying

## 0.5.4 - 2021-05-08

* Align with Klaro's API recent change. Story#description becomes Story#title.

## 0.5.3 - 2021-05-07

* Reimport 0.5.1 issues, we messed up with the release process.

## 0.5.2 - 2021-05-07

* Fix Story#download_and_relocate_images: attachment.url was not properly set.

## 0.5.1 - 2021-03-29

* Update gem redcarpet to 3.5.1

* Add support for `with_project` on RequestHandler & Client

* The client base url may point to `/api/` explicitely

## 0.5.0 - 2020-04-21

* Add basic support for linked cards.

## 0.4.4 - 2020-04-16

* Add support for story attachments with various tools regarding cover ones
  and urls.

## 0.4.0 - 2020-04-08

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

## 0.3.0 - 2020-01-06

* First really 'official' version
