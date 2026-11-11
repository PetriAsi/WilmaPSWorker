# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.4]

### Added
- Support for Wilma token based authentication (`__Host-Wilma2AT` / `__Host-Wilma2RT`). Detected on every login, falls back to the session cookie when no token cookies are present.
- Access token is refreshed before it expires, with a new login if refresh fails.

## [0.1] Unreleased

