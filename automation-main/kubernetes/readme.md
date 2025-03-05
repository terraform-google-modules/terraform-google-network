# ste-kubernetes

### Welcome to the `ste-kubernetes` repository!

This repository contains the deployment files and instructions for setting up and STE Kubernetes cluster on Gardener.

### To get started, please follow the steps below:

1. Clone this repository to your new cluster repository (the provided repo is a template).
      Note: This cluster requires gitlab runners and a **dedicated** **repository** per cluster deployment.
      A repository template is available: https://gitlab.core.sapns2.us/scs/s4pce/kubernetes (replace <gitlab.core.sapns2.us> with your region specific url)
2. Navigate to the newly created directory.
3. Review the documentation in the `docs` folder for detailed instructions on deploying the cluster.
   - Complete all Prerequisites outlined in [before-you-deploy.md](docs/before-you-deploy.md)
   - Complete all deployment steps outlined in [deployment-steps.md](docs/deployment-steps.md)
4. Once the deployment is complete, you can access deployed tools and applications based on configured base domain.
   - argocd: `https://argocd.<base-domain>`
   - sftpgo: `<configured redirect_base_url>`
5. Helpful tips can be found in the `docs` folder for working with the deployed cluster in [tips-and-tricks.md](docs/tips-and-tricks.md).

### Recommended tools for working with the cluster that will be deployed:
- [kubectl cli](docs/tips-and-tricks.md#accessing-the-cluster-via-kubectl)
- [K9S](docs/tips-and-tricks.md#accessing-the-cluster-via-with-k9s)
- [Openlens/Lens](docs/tips-and-tricks.md#accessing-the-cluster-via-with-openlenslens)
