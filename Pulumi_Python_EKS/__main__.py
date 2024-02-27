import pulumi
import pulumi_eks as eks
from pulumi import kubernetes as k8s

# Define the name of the EKS cluster
cluster_name = "eks-python-automation"

# Get some values from the Pulumi configuration (or use defaults)
config = pulumi.Config()
min_cluster_size = config.get_float("minClusterSize", 1)
max_cluster_size = config.get_float("maxClusterSize", 3)
desired_cluster_size = config.get_float("desiredClusterSize", 1)
eks_node_instance_type = config.get("eksNodeInstanceType", "t2.micro")
existing_vpc_id = "vpc-01bab204d8528eedb"  # Replace with your existing VPC ID
existing_public_subnet_ids = ["subnet-03cea030789b37116", "subnet-0285a9715566d8961"]  # Replace with your public subnet IDs
existing_private_subnet_ids = ["subnet-049bde5a5f60f8920", "subnet-026a7bd2e301fac3b"]  # Replace with your private subnet IDs

# Create an EKS cluster using existing VPC and subnets
eks_cluster = eks.Cluster(cluster_name,
    vpc_id=existing_vpc_id,
    public_subnet_ids=existing_public_subnet_ids,
    private_subnet_ids=existing_private_subnet_ids,
    instance_type=eks_node_instance_type,
    desired_capacity=desired_cluster_size,
    min_size=min_cluster_size,
    max_size=max_cluster_size,
    node_associate_public_ip_address=False,
)

# Define the namespace
namespace = k8s.core.v1.Namespace(
    "eks-python-automation-namespace",
    metadata={"name": "eks-python-automation"},
    opts=pulumi.ResourceOptions(depends_on=[eks_cluster]),
)

# Define the Kubernetes deployment
deployment = k8s.apps.v1.Deployment(
    "example-deployment",
    metadata={
        "namespace": namespace.metadata["name"],
    },
    spec={
        "selector": {"matchLabels": {"app": "example"}},
        "replicas": 2,
        "template": {
            "metadata": {"labels": {"app": "example"}},
            "spec": {"containers": [{"name": "example", "image": "nginx"}]},
        },
    },
    opts=pulumi.ResourceOptions(depends_on=[namespace]),
)

# Define the Kubernetes service
service = k8s.core.v1.Service(
    "example-service",
    metadata={
        "namespace": namespace.metadata["name"],
        "labels": {"app": "example"},
    },
    spec={
        "ports": [{"port": 80, "targetPort": 80}],
        "selector": {"app": "example"},
        "type": "LoadBalancer",
    },
    opts=pulumi.ResourceOptions(depends_on=[namespace]),
)

# Export the kubeconfig and VPC ID
pulumi.export("kubeconfig", eks_cluster.kubeconfig)
pulumi.export("vpcId", existing_vpc_id)
