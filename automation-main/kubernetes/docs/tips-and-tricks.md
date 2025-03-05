# Tips and Tricks

### Accessing the Cluster via `kubectl`
Since the Gardener cluster is managed by Gardener, you will need to use the Gardener technical user kubeconfig file to generate a temporary cluster kubeconfig to access the cluster. The cluster kubeconfig is created with a set expiration time and will need to be regenerated when it expires. To access the cluster, you will need to download the [technical user kubeconfig file](deployment-steps.md#update-technical-user-in-gardener-project-and-download-kubeconfig) from the Gardener project and set the `KUBECONFIG` environment variable to the path of the kubeconfig file. Recommended name for file is kuberobot.yaml or adminkubeconfig.yaml as these are git ignored and will not be commited back to the repository.

```bash
export KUBECONFIG=/path/to/kuberobot.yaml
```

Since the generated a temporary cluster kubeconfig is part of some of the pipeline automation you can leverage the exisiting kubeconfig function available in [common.sh](../scripts/source/common.sh):

```bash
# assuming you are in the root of the repository and tech user kubeconfig is already set from previous step
source scripts/source/common.sh

export GARDNER_PROJECT_NAME="your-gardener-project-name"
export GARDENER_SHOOT_NAME="your-cluster-name"
export TARGET_KUBECONFIG_DIR="/path/to/store/temp/kubeconfig"
export EXPIRATION_TIME="how long the kubeconfig should be valid for in seconds (default is 10min)"

create_temp_kubeconfig "$GARDNER_PROJECT_NAME" "$GARDENER_SHOOT_NAME" "$TARGET_KUBECONFIG_DIR" "$EXPIRATION_TIME"

export KUBECONFIG=$(TARGET_KUBECONFIG_DIR)/kubeconfig.yaml
```
You can now use `kubectl` to interact with the Gardener cluster.

```bash
# Example kubectl commands
# Get the namespaces in the cluster
kubectl get namespaces
# Get the pods in all namespaces
kubectl get pods -A 
```
If you need to install `kubectl` you can do so in macos using brew:

```bash
brew install kubernetes-cli
```

### Accessing the Cluster via with K9S
K9S is a terminal-based UI for interacting with Kubernetes clusters. You can use K9S to access your cluster by setting the KUBECONFIG env var to the generated kubeconfig.yaml file using the steps explained previously. Once set you just need to start K9S and it will automatically use the kubeconfig file to connect to the cluster.

If you need to install K9S you can do so in macos using brew:

```bash
brew install k9s
```

### Accessing the Cluster via with OpenLens/Lens
OpenLens/Lens is a desktop application that provides a visual interface for managing Kubernetes clusters. You can use Lens to access the Gardener cluster by importing the Gardener technical user kubeconfig file. To import the kubeconfig file, open Lens and navigate to `File` > `Add Cluster` and paste the contents of the generated kubeconfig file. Once imported, you can access the Gardener cluster and manage resources using the Lens interface.

There is also a different way to link OpenLens/Lens to the cluster that will allow you to connect to your cluster without having to reimport the temporary kubeconfig everytime you want to access the cluster. To do this, decide on a location on your local machine that you will always use as the `TARGET_KUBECONFIG_DIR` variable. If you use a consistant location for the exported file you can set OpenLens/Lens to always use that file by going to OpenLens/Lens > Settings > Kubernetes > Kubeconfig Syncs > Sync Files and Folders. Target the generated kubeconfig file which will allow you to connect to the cluster even after a new kubeconfig is regenerated instead of having to import it everytime.

If you would like to install OpenLens on macos you can do so using brew:

```bash
brew install --cask openlens
```

If you would like to install Lens on macos, it can be downloaded from the [lens website](https://k8slens.dev/download). Lens requires a license which can be requested via via [Ariba](https://s1-2-eu.ariba.com/gb/?realm=SAPGLOBAL).
