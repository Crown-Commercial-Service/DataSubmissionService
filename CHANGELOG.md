# Change Log

## [release-31] - 2019-02-20

- Add analytics.txt for Google Analytics

## [release-30] - 2019-02-19

- Provide friendly message when authentication fails

## [release-29] - 2019-01-31

- Updated template for RM3772

## [release-28] - 2019-01-08

- Include year when displaying task period
- Include user aut id with API requests to enable scoping of tasks and submissions
- Updated rubygems to 3.0.0

## [release-27] - 2018-12-19

- RM1043.5 added to list of frameworks supported on RMI
- Corrected typo on frameworks page

## [release-26] - 2018-12-17

- Add skylight

## [release-25] - 2018-12-12

- Added DOS3 framework template file
- Removed "MISO" from the filename generated for template downloads

## [release-24] - 2018-12-06

- [Accessibility] Update badge colours for legibility
- [Accessibility] Make task list an actual HTML list
- [Accessibility] Add aria labels for tasks
- [Accessibility] Add HTML titles to pages
- [Accessibility] Adjust start page content for accessibility

## [release-23] - 2018-11-30

- [Accessibility] Add a label to the submission file upload form
- Update Customer URN file for November

## [release-22] - 2018-11-28

- Remove User model and table
- Show supplier names or not based on a new multiple_suppliers? property on the user
- Remove 'nil return' from the frontend supplier app
- [Security] Bump rails from 5.2.0 to 5.2.1.1

## [release-21] - 2018-11-26

- Add basic authentication to API
- Update the the confirmation page
- [Security] Bump rack from 2.0.5 to 2.0.6

## [release-20] - 2018-11-13

- Stop using the User model and user id

## [release-19] - 2018-11-08

- Send User's Auth ID in API requests

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

[release-31]: https://github.com/dxw/DataSubmissionService/compare/release-30...release-31
[release-30]: https://github.com/dxw/DataSubmissionService/compare/release-29...release-30
[release-29]: https://github.com/dxw/DataSubmissionService/compare/release-28...release-29
[release-28]: https://github.com/dxw/DataSubmissionService/compare/release-27...release-28
[release-27]: https://github.com/dxw/DataSubmissionService/compare/release-26...release-27
[release-26]: https://github.com/dxw/DataSubmissionService/compare/release-25...release-26
[release-25]: https://github.com/dxw/DataSubmissionService/compare/release-24...release-25
[release-24]: https://github.com/dxw/DataSubmissionService/compare/release-23...release-24
[release-23]: https://github.com/dxw/DataSubmissionService/compare/release-22...release-23
[release-22]: https://github.com/dxw/DataSubmissionService/compare/release-21...release-22
[release-21]: https://github.com/dxw/DataSubmissionService/compare/release-20...release-21
[release-20]: https://github.com/dxw/DataSubmissionService/compare/release-19...release-20
[release-19]: https://github.com/dxw/DataSubmissionService/compare/release-18...release-19
[release-18]: https://github.com/dxw/DataSubmissionService/compare/release-17...release-18
[release-17]: https://github.com/dxw/DataSubmissionService/compare/release-16...release-17
[release-16]: https://github.com/dxw/DataSubmissionService/compare/release-15...release-16
[release-15]: https://github.com/dxw/DataSubmissionService/compare/release-14...release-15
[release-14]: https://github.com/dxw/DataSubmissionService/compare/release-13...release-14
