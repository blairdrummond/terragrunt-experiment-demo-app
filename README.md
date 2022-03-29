# terragrunt-experiment-demo-app

A very simple Hello world api with a unix timestamp.

**Note: The CI/CD intentionally does not push any images.**

## Features

### FastAPI

Implemented in FastAPI, a nice rest API framework for python

### No critical CVEs (at time of writing)

Dockerized in an alpine python image with (at the tinme of writing) zero critical CVEs. For contrast, try `trivy image python:3`

```
2022-03-28T19:47:17.550-0400	[34mINFO[0m	Detected OS: debian
2022-03-28T19:47:17.550-0400	[34mINFO[0m	Detecting Debian vulnerabilities...
2022-03-28T19:47:17.685-0400	[34mINFO[0m	Number of language-specific files: 1
2022-03-28T19:47:17.685-0400	[34mINFO[0m	Detecting python-pkg vulnerabilities...

python:3 (debian 11.2)
======================
Total: 25 (CRITICAL: 25)

+----------------------+------------------+----------+--------------------+-----------------+---------------------------------------+
|       LIBRARY        | VULNERABILITY ID | SEVERITY | INSTALLED VERSION  |  FIXED VERSION  |                 TITLE                 |
+----------------------+------------------+----------+--------------------+-----------------+---------------------------------------+
| curl                 | CVE-2021-22945   | CRITICAL | 7.74.0-1.3+deb11u1 |                 | curl: use-after-free and              |
|                      |                  |          |                    |                 | double-free in MQTT sending           |
|                      |                  |          |                    |                 | -->avd.aquasec.com/nvd/cve-2021-22945 |
```

#### Is Alpine bad for Python?

There is literature out there saying Alpine is bad for python https://pythonspeed.com/articles/alpine-docker-python/ . This should be taken with a grain of salt. The main issue is that python packages don't usually have wheels compiled against [musl](https://musl.libc.org/), which is the C library Alpine uses. So this means you're often stuck building packages yourself. If you're building FastAPI (as we are) this is fine, however it's pretty noticable when building large projects like `pandas`.

Altogether though, it's a compromise. In my experience, it's better to install python on-top of `ubuntu` base images rather than using the official `python` debian-based images, which are usually riddled with CVEs.

### Trivial pytest example

The pytest example was really only included to be able to show it off in CI.

## TODO

This example is by no means the gold-standard of a python app. Notable aspects:

- It doesn't have a fancy/standard folder structure.
  + I don't write python full time, so I'd need to review the `src,docs,test` etc style.
- No fancy virtual environments.
  + Python is famously complex with virtual environments, with many competing tools. I am not touching that here, as I find containers are a nice way to avoid those troubles. If I was working in the ecosystem though, I'd look at `conda` (which I have used, and is very useful), or `poetry`.
- I hear `tox` is useful. I have not used it.
- I am not doing any linting of the python code.
- I find that good projects usually use pre-commit hooks for enforcing good python style. I am not doing that here.
