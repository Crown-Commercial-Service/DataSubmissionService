# Change Log

## [release-18] - 2018-10-31

- Updated template for RM3786

## [release-17] - 2018-10-30

- Update Customer URN file for November
- Automatically update template xls filenames each  month
- Update RM3797.xls
- Don't hardcode API_ROOT in tests
- Bump loofah from 2.2.2 to 2.2.3

## [release-16]

- Fixed a character encoding bug affected console access
- Added support times to support page
- Separate page to list supported frameworks
- Updated home page to follow GOVUK start page pattern

## [release-15]

- Adjusted documentation for onboarding new users
- Reduce logging in production environments
- Updated dependency with security fixes
- Make signposting clearer when making a no-business submission

## [release-14]

- Fixed typo on submission confirmation page
- Updated URN file with a stripped down version

## [release-13] - 2018-10-01

- Fixed broken link for September URN file
- Updated home page with October frameworks

## [release-12] - 2018-09-27

- Updated Customer URN file for October
- Added Template files for October frameworks
- Display supplier name against tasks to support users with multiple suppliers

## [release-11] - 2018-09-26

- Made service alerts design clearer
- Added utility code for setting up new users

## [release-10] - 2018-09-25

- Added task and framework signposting
- Display validation errors using newer API endpoint, which is optimised for
    larger submissions.
- Show message to user explaining that at most ten validation errors are
    displayed, where appropriate.

## [release-9] - 2018-09-19

- Adjusted terraform config for zero-downtime deploys
- Updated analytics to use Google Tag Manager

## [release-8] - 2018-09-18

- Updated to allow purchase order number to be set with submissions
- Removed redundant code relating to early version of the service
- Improved submission summary page performance by using summary information
  instead of counting entries
- Updated frontend toolkit and made markup more consistent
- Fixed bug in main menu mobile view

## [release-7] - 2018-09-13

- Updated to use new GOV.UK Design System
- Updated design and content following end-to-end review

## [release-6] - 2018-08-23

- Tasks are ordered by due date
- Completed tasks are placed at the bottom of the task list
- Rename framework templates to August 2018
- Remove mentions of specific deadline dates from various pages

## [release-5] - 2018-08-22

- Sync file upload details with API

## [release-4] - 2018-08-13

- Custom 404 and 500 pages
- Static maintenance page for use during scheduled maintenance
- Adjusted in-review submission screens to make re-upload clearer
- Updated URN list file with latest version

## [release-3] - 2018-08-09

- Added exception monitoring and reporting
- Updated dependent libraries
- Added static code analysis to build process (brakeman)

## [release-2] - 2018-08-06

- Updated content on the URNs page
- Updated home page to show different content to signed in users
- Ensure sign-in session required on relevant pages

## [release-1] - 2018-08-01

Initial release

[release-18]: https://github.com/dxw/DataSubmissionService/compare/release-17...release-18
[release-17]: https://github.com/dxw/DataSubmissionService/compare/release-16...release-17
[release-16]: https://github.com/dxw/DataSubmissionService/compare/release-15...release-16
[release-15]: https://github.com/dxw/DataSubmissionService/compare/release-14...release-15
[release-14]: https://github.com/dxw/DataSubmissionService/compare/release-13...release-14
