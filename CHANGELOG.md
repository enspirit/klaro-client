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
