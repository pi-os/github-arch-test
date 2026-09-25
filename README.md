# GitHub ARM Architecture Test

GitHub Actions workflow for validating `armel` and `armhf` execution on an ARM64 runner using Debian and Linux `binfmt_misc`/QEMU support.

## What it tests

- ARM64 runner/kernel information
- CPU architecture and supported modes
- `binfmt_misc` configuration
- `armel` execution through `/usr/libexec/arch-test/armel`
- `armhf` execution through `/usr/libexec/arch-test/armhf`

The workflow intentionally runs both architecture tests and reports a failure after both have been attempted.

## Repository layout

```text
.
├── .github/
│   └── workflows/
│       └── arch-test.yml
├── scripts/
│   └── run-arch-tests.sh
├── .gitignore
└── README.md
```

## GitHub Actions

The workflow uses an ARM64 GitHub-hosted runner:

```yaml
runs-on: ubuntu-24.04-arm
```

and executes the tests inside:

```yaml
container:
  image: docker.io/debian:unstable
```

The workflow does not install `qemu-user-static` or `binfmt-support` inside the Debian container because binfmt/QEMU support is expected to be provided by the runner environment.

## Local execution

On an ARM64 Debian system:

```bash
sudo apt-get update
sudo apt-get install -y --no-install-recommends arch-test
./scripts/run-arch-tests.sh
```

## Notes

`armhf` execution can depend on the runner's binfmt/QEMU configuration. A failure can therefore indicate an infrastructure/emulation problem rather than a failure of the `arch-test` package itself.
