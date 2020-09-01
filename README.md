# fault-tolerance
demo on using k3s to manage network fault tolerance

1. Setup a k3s cluster
1. deploy the speed-limit.yaml
1. watch the pods in the fault-tolerance namespace
    `watch kubectl get pods -n fault-tolerance`
1. Throttle the speed allowance in the router (I am using a GL.inet 750s)

Notice that the pod in the daemonset stops and exits. 
A new pod is deployed and it doesn't start until the throttle is lifted

