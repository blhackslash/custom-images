# custom-images

Custom Docker images for my self-hosted services, all built by one workflow
and published to `ghcr.io/blhackslash/<name>`.

| Image | Based on | What's added |
| --- | --- | --- |
| `caddy-custom` | `caddy:2.11` | cloudflare DNS, layer4, cloudflare IP source, combine IP ranges plugins |
| `custom-code` | `linuxserver/code-server` | Julia (from the official `julia:1` image) |
| `fail2ban-custom` | `crazymax/fail2ban:1.1.1` | `jq` |
| `media-converter` | `alpine:3.24` | the converter itself; tags `cpu`, `intel`, `amd`, `latest` (intel + amd) |
| `nextcloud-custom` | `nextcloud:35` | `ffmpeg` for video previews |
| `synapse-admin-custom` | `awesometechnologies/synapse-admin:0.11.4` | nginx on port 8081 |

## Layout

```
images/<name>/Dockerfile       # build context for each image
images/<name>/smoke-test.sh    # optional: run against the built image in CI
images.json                    # which images/tags/build-args CI builds
.github/workflows/build.yml    # the one build workflow
.github/dependabot.yml         # weekly PRs for base images and actions
```

Each image directory keeps its full git history from the repo it came from
(`git log -- images/<name>`).

## How builds run

- **Pull requests** build and smoke-test the images whose directory changed, without pushing.
- **Pushes to `main`** build, test and push the images whose directory changed.
  Changes to `images.json` or the workflow rebuild everything.
- **Sundays 04:00 UTC** everything is rebuilt to pick up upstream base-image updates.
  The run also re-enables its own workflow, so GitHub's 60-day inactivity rule can't switch it off.
- **Run workflow** (Actions tab) builds everything, or only the images you list.

Every push writes the moving tag (`latest`, `cpu`, ...) and a dated tag
(`2026-11-22`, `cpu-2026-11-22`), so a bad rebuild can be rolled back by pinning the date.

## Adding an image

1. Create `images/<name>/Dockerfile` (and optionally an executable `smoke-test.sh` that takes the image ref).
2. Add `{ "name": "<name>", "tag": "latest" }` to `images.json`.
3. Open a PR. The first push to `main` creates `ghcr.io/blhackslash/<name>`.

Moving an image that already exists in ghcr from another repo: in the package's
settings, under *Manage Actions access*, give this repo the **Write** role,
otherwise the push fails with 403.
