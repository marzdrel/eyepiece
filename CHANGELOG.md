# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [0.2.0] - 2026-04-09

### Changed
- Replace `ArgumentError` with custom `TooManyRecordsError`

### Fixed
- Replace `IO.popen` with `Dir.glob` in gemspec and add ActiveRecord require

## [0.1.0] - 2026-04-09

### Added
- `QuickSearch` parameterized module for fast ILIKE searching on ActiveRecord models
- `QuickBriefScope` parameterized module for brief scope selection
