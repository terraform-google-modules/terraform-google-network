# CoreDNS

Helm chart to deploy [CoreDNS](https://github.com/coredns/helm/tree/master/stable/coredns).

## Release management

This project is using the [release drafter](https://github.com/release-drafter/release-drafter) Github action
to generate a changelog for each release. The `release-drafter` is keeping those changes in a draft release
state until you decide to create a tagged release.

If you want to exclude a PR from the changlog just add the `skip-changlog` label to your PR.

## Update dependencies

If a dependant chart is used, it can be updated via

```shell
./update-chart.sh
```
