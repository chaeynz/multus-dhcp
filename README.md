# Docker Image for Multus DHCP daemonset

This just tracks the latest download for the cni_plugins from k8snetworkplumbingwg because the reference has an outdated image

Just replace the image in this file to run the daemonset:

https://github.com/k8snetworkplumbingwg/reference-deployment/blob/master/multus-dhcp/dhcp-daemonset.yml

or check ./dhcp-daemonset.yaml which is exactly that.
