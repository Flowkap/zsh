# #!/bin/bash

# # purge all helm
# helm ls --all --short | xargs -L1 helm delete --purge

# # sleep a bit so that stuff can actally be deleted properly.
# sleep 1m

# # purge all custom ressource definitions / prometheus has a bug
# kubectl get customresourcedefinitions.apiextensions.k8s.io | awk '{if (NR>1) print $1}' | tr "\n" " " | xargs kubectl delete customresourcedefinitions.apiextensions.k8s.io

# # purge all pvc
# kubectl get persistentvolumeclaims | awk '{if (NR>1) print $1}' | tr "\n" " " | xargs kubectl delete persistentvolumeclaim
# kubectl get persistentvolumes | awk '{if (NR>1) print $1}' | tr "\n" " " | xargs kubectl delete persistentvolumes

# # clean misc
# kubectl get jobs | awk '{if (NR>1) print $1}' | tr "\n" " " | xargs kubectl delete jobs
# kubectl get configMaps | awk '{if (NR>1) print $1}' | tr "\n" " " | xargs kubectl delete configMaps

# # clean only core
# helm ls | grep core | awk '{print $1}' | xargs -L1 helm delete --purge
