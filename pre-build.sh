#!/bin/sh

mkdir drivers
curl --output drivers/vmxnet3n61x64.sys   http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3n61x64.sys
curl --output drivers/vmxnet3n61x86.sys   http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3n61x86.sys
curl --output drivers/vmxnet3ndis6.cat    http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3ndis6.cat
curl --output drivers/vmxnet3ndis6.inf    http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3ndis6.inf
curl --output drivers/vmxnet3ndis6ver.dll http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3ndis6ver.dll
