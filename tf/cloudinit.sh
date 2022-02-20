#!/bin/bash
echo "Add ansible-key public SSH key"
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7BwsqlmVrikZwb/22x2Q8ZDVLHllSEygzlaV8l+Hjbh+x3mApXbffF/lYCuuYuzG8biaYJAsTSiXtWKjFNVHJCGHgnYoQlc36iQO7SCn+thJgF/o3Ot31/mlEe6uZf/yJ1eOWSDzrbQ1ApsR1uErCvyRvQGdrNpEoJBgM/NZeTf7uUV3FwxmRkCM42lLswrP+8jNSsLNdPiKg8ElDdsM7tTcMSeI9MwWa1C6hAMRtYw+sPOoAk8lyijgsMTZ5z5s3kbL18uUv+E+q+vxsaAu/QGT5DngbcPdE661Fo2UyFET/QMIMZCyCb+0D65mcm/s6z9qfs0udHj703Ec+xf73 MBP-ansible-key" >> /home/admin/.ssh/authorized_keys
echo "Update"
sudo apt update && sudo apt upgrade -y
