# Release process

As outlined in the [DXW development workflow guide], production deploys are
done by manually merging `develop` into `master`. To give us a slightly more
formal process around what gets deployed and when and also to give us
visibility into the things that have been deployed, we additionally follow
these steps when releasing to production:

## 1. Create a release branch and make a pull request

  - Create a branch from `develop` for the release called `release-X` where X is the release
    number
  - Update [CHANGELOG.md](CHANGELOG.md) to:
     - document the changes in this release in a bullet point form
     - add a link to the diff at the bottom of the file
  - Document the changes in the commit message as well
  - `git push <your-branch-name>`, e.g. `git push release-45`
  - Create a tag for the release in the format `release-X`
  - Create a pull request for the release with content from the `CHANGELOG.md`
  - Get that pull request reviewed and approved

## 2. Review and merge the release pull request

The pull request should be reviewed to confirm that the changes in the release
are safe to ship and that CHANGELOG.md accurately reflects the changes
included in the release.

## 3. Confirm the release candidate and perform any prerequisites

  - Confirm the release with any relevant people (product owner, delivery
    manager, etc)
  - Think about any dependencies that also need considering: dependent parts
    of the service that also need updating; environment variables that need
    changing/adding; third-party services that need to be set up/updated

## 4. Announce the release

Let the team know about the release. This is posted in Slack under `#ccs-data-submission`.
Typical form is:

`@here :badger: Release N of <API/Service> going to production :badger:`

Acknowledgement is usually made by [`:mushroom:`](https://www.youtube.com/watch?v=6joOVjEemh4)

## 5. Manually merge to master to release

Once the release pull request has been merged into the `develop` branch, the
production deploy can be performed by manually merging `develop` into `master`:

```bash
  git fetch
  git checkout master
  git pull
  git merge origin/develop
  # Edit the commit message to reference the release number
  # e.g. "Release 43" or "merge origin/develop for release 43"
  git push
```

## 6. Production smoke test

Once the code has been deployed to production, carry out a quick smoke test to
confirm that the changes have been successfully deployed.

## 7. Update Trello

Update Trello to reflect the newly deployed cards.

[DXW development workflow guide]:http://playbook.dxw.com/#/guides/development-workflow?id=deploying
