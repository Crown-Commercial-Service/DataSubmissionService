# Change Log

## [release-80] - 2022-06-16

- RMI-505: Google Analytics 4 set up
- RMI-511: Google Tag Manager set up
- Bump jmespath from 1.4.0 to 1.6.1 
- [Snyk] Security upgrade aws-sdk-s3 from 1.94.1 to 1.94.1

## [release-79] - 2022-03-24

- RMI-504: Dependency updates, to fix security vulnerabilities. (Manual Update)

## [release-78] - 2022-02-03

- RMI-494: Fixed nav menu dropdown and filter expansion

## [release-77] - 2022-01-27

- RMI-378: Cookie banner
- RMI-379: Cookie setting and policy pages
- RMI-478: Update to HTST config

## [release-76] - 2021-11-25

- RMI-418: Guard against incorrectly issuing credit notes.
- RMI-377: Update to google analytics code.

## [release-75] - 2021-10-14

- RMI-352: Fixed aria text for screenreader in completed tasks page.

## [release-74] - 2021-09-16

- RMI-425: Update travis env variable
- Ruby update

## [release-73] - 2021-08-05

- RMI-314: Sort feature for completed tasks page
- RMI-315: Paginate completed tasks page
- RMI-36: Framework filter on completed tasks page
- Ruby update
- Snyk fix

## [release-72] - 2021-06-03

- RMI-345: set up conclave branch to deploy rmi-conclave integration work to preprod env
- RMI-343: Update Ruby version from 2.5.7 to 2.5.8 (minor update).
- RMI-348: Update survey url.

## [release-71] - 2021-04-01

- Fix: Update mime-magic dependancy gem.
- RMI-37: Added reported value to completed tasks page.

## [release-70] - 2021-03-18

- RMI-27: Removed Beta Banner. Add Feedback footer link.
- RMI-300: Add missing label for corresponding input field, as per accessibility report.
- RMI-299: Fix Aria reference/label.

## [release-69] - 2021-03-03

- RMI-313: gem update to resolve dependabot alert and resolving obsolete rubocop config.

## [release-68] - 2021-02-11

- RMI-294: Updated Help page
- RMI-295: Updated upload page
- RMI-301: Switched from zdt to rolling deploy
- RMI-31: Blank template link on submission upload page
- RMI-297: URN list page amendments

## [release-67] - 2021-01-07

- [Security] Bump Nokogiri from 1.10.10 to 1.11.0
- Added test to remediation measures for omniauth vulnerability
- Addressed build issue caused by libv8

## [release-66] - 2020-11-26

- Fix: prevent error when users download template stored in repo
- RMI-275: Add to travis.yml and deploy-app.sh to accomodate and add Preproduction to the Travis/Github infrastructure.

## [release-65] - 2020-11-11

- Bump rails from 5.2.4.3 to 5.2.4.4
- [Security] Bump actionview from 5.2.4.3 to 5.2.4.4
- Fix: templates now keep their original file extension.

## [release-64] - 2020-11-09

- Added SimpleCov and Code Climate to Travis build
- Change to pull request template

## [release-63] - 2020-10-08

- Update Travis credentials, from dxw to ccs (password & username).

## [release-62] - 2020-09-18

- Enable splunk monitoring

## [release-61] - 2020-03-12

- [Security] Bump puma from 3.12.2 to 3.12.4
- [Security] Bump rake from 12.3.2 to 13.0.1
- [Security] Bump omniauth from 1.8.1 to 1.9.1
- Accessibility improvements

## [release-60] - 2020-02-27

- Fix: Prevent users getting stuck on authentication page

## [release-59] - 2020-02-18

- Show OtherFields row count on summary page

## [release-58] - 2019-12-19

- [Security] Bump rack from 2.0.6 to 2.0.8

## [release-57] - 2019-09-27

- Add accessibility statement (support ticket 10178)
- Accessibility-related changes on upload page (support ticket 10178)

## [release-56] - 2019-09-20

- Change survey link (support ticket 10150)

## [release-55] - 2019-08-29

- Fix Google Analytics by expanding Content-Security-Policy whitelist

## [release-54] - 2019-08-29

- Improvements to documentation and Docker development environment
- Add some security-related HTTP response headers
- Lock Nokogiri to a safe version

## [release-53] - 2019-08-22

- Handle the new management_charge_calculation_failed submission status
- [Security] Bump nokogiri from 1.10.3 to 1.10.4
- Add the correction param to view errors button

## [release-52] - 2019-08-13

- Allow suppliers to download submissions from S3
- Remove 'Sign in' link in header
- Fix up the Docker-based development environment

## [release-51] - 2019-06-20

- Revert JWT for API authentication. Fixes infinite redirect.

## [release-50] - 2019-06-19

- Don't forget if submission is a replacement on ingest failed
- Address CVE-2015-9284
- Use JWT for API authentication

## [release-49] - 2019-06-10

 - Add additional page for a submission in the 'ingest_failed' state

## [release-48] - 2019-05-21

- Allow downloading of URN list from API

## [release-47] - 2019-05-14

- Allow downloading of framework templates from API

## [release-46] - 2019-04-29

- Configure Service Connection Environment variables
- Upgrade ruby to 2.5.5
- Update bundler to 2.0.1
- List of RMI frameworks is dynamic
- [Security] Bump nokogiri from 1.10.1 to 1.10.3
- Add scripts to set up and deploy to GPaaS
- Add Travis

## [release-45] - 2019-04-09

- Allow users to replace return in errors with no business

## [release-44] - 2019-04-04

- Update RM3788 Excel template to 3/4/2019 version

## [release-43] - 2019-03-28

- Update URN list to 27/03/2019 version
- Add April frameworks and templates

## [release-42] - 2019-03-26

- Updated content for support page with correction returns

## [release-41] - 2019-03-25

- Show incomplete correction submissions
- Allow cancellation of incomplete correction submissions

## [release-40] - 2019-03-20

- Removal of JQuery/CoffeeScript dependencies

## [release-39] - 2019-03-18

- Service copy review implementation
- Display the submission file name and link to it in review view
- Page title displays default value
- Send correction param everywhere and prevent double-clicking buttons

## [release-38] - 2019-03-14

- Don't specify explicit platform for mini_racer gem
- [Security] Bump rails from 5.2.1.1 to 5.2.2.1

## [release-37] - 2019-03-13

- Update history page based on user research learnings
- Update replacement returns flow based on user research learnings

## [release-36] - 2019-03-12

- Supplier can correct a submission by uploading an MI return
- Set the class of the show task report no business
- Refactor/switch to `reportmi` frontend

## [release-35] - 2019-03-11

- Use active_submission instead of latest_submission

## [release-34] - 2019-03-05

- Users can download their submission files
- Users can replace their submissions with no business

## [release-33] - 2019-03-04

- Added RM6060 to framework list support page
- Updated RM6060 framework template file
- Updated URN list

## [release-32] - 2019-02-28

- Added RM6060 framework template file
- Added a task page to view an historic task (where replacements will start)

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

[release-80]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-79...release-80
[release-79]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-78...release-79
[release-78]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-77...release-78
[release-77]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-76...release-77
[release-76]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-75...release-76
[release-75]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-74...release-75
[release-74]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-73...release-74
[release-73]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-72...release-73
[release-72]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-71...release-72
[release-71]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-70...release-71
[release-70]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-69...release-70
[release-69]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-68...release-69
[release-68]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-67...release-68
[release-67]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-66...release-67
[release-66]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-65...release-66
[release-65]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-64...release-65
[release-64]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-63...release-64
[release-63]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-62...release-63
[release-62]: https://github.com/Crown-Commercial-Service/DataSubmissionService/compare/release-61...release-62
[release-61]: https://github.com/dxw/DataSubmissionService/compare/release-60...release-61
[release-60]: https://github.com/dxw/DataSubmissionService/compare/release-59...release-60
[release-59]: https://github.com/dxw/DataSubmissionService/compare/release-58...release-59
[release-58]: https://github.com/dxw/DataSubmissionService/compare/release-57...release-58
[release-57]: https://github.com/dxw/DataSubmissionService/compare/release-56...release-57
[release-56]: https://github.com/dxw/DataSubmissionService/compare/release-55...release-56
[release-55]: https://github.com/dxw/DataSubmissionService/compare/release-54...release-55
[release-54]: https://github.com/dxw/DataSubmissionService/compare/release-53...release-54
[release-53]: https://github.com/dxw/DataSubmissionService/compare/release-52...release-53
[release-52]: https://github.com/dxw/DataSubmissionService/compare/release-51...release-52
[release-51]: https://github.com/dxw/DataSubmissionService/compare/release-50...release-51
[release-50]: https://github.com/dxw/DataSubmissionService/compare/release-49...release-50
[release-49]: https://github.com/dxw/DataSubmissionService/compare/release-48...release-49
[release-48]: https://github.com/dxw/DataSubmissionService/compare/release-47...release-48
[release-47]: https://github.com/dxw/DataSubmissionService/compare/release-46...release-47
[release-46]: https://github.com/dxw/DataSubmissionService/compare/release-45...release-46
[release-45]: https://github.com/dxw/DataSubmissionService/compare/release-44...release-45
[release-44]: https://github.com/dxw/DataSubmissionService/compare/release-43...release-44
[release-43]: https://github.com/dxw/DataSubmissionService/compare/release-42...release-43
[release-42]: https://github.com/dxw/DataSubmissionService/compare/release-41...release-42
[release-41]: https://github.com/dxw/DataSubmissionService/compare/release-40...release-41
[release-40]: https://github.com/dxw/DataSubmissionService/compare/release-39...release-40
[release-39]: https://github.com/dxw/DataSubmissionService/compare/release-38...release-39
[release-38]: https://github.com/dxw/DataSubmissionService/compare/release-37...release-38
[release-37]: https://github.com/dxw/DataSubmissionService/compare/release-36...release-37
[release-36]: https://github.com/dxw/DataSubmissionService/compare/release-35...release-36
[release-35]: https://github.com/dxw/DataSubmissionService/compare/release-34...release-35
[release-34]: https://github.com/dxw/DataSubmissionService/compare/release-33...release-34
[release-33]: https://github.com/dxw/DataSubmissionService/compare/release-32...release-33
[release-32]: https://github.com/dxw/DataSubmissionService/compare/release-31...release-32
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
