# Release process

The following steps describe a process for deploying a release of the
application to production.

## 1. Create a release branch and make a pull request

  - Create a branch for the release called `release-X` (branched from the
    develop) where X is the release number
  - Update CHANGELOG.md to document the changes in the release
  - Create a pull request for the release, selecting master as the base target

## 2. Confirm the release candidate

  - Confirm the release with any relevant people (product owner, delivery
    manager, etc)
  - Think about any dependencies that also need considering: dependent parts
    of the service that also need updating; environment variables that need
    changing/adding; third-party services that need to be set up/updated

## 3. Review the pull request and merge to deploy

The pull request should be reviewed to confirm that the changes are good to
go out. Once reviewed, merge the pull request to trigger a deployment to
production.

## 4. Production smoke test

Once the code has been deployed to production, carry out a quick smoke test to
confirm that the changes have been successfully deployed.
