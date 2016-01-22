#!/bin/sh

mkdir drivers
mkdir drivers/winx64
mkdir drivers/winx86
# Windows 64bit Drivers
curl --output drivers/winx64/vmxnet3n61x64.sys   http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3n61x64.sys
curl --output drivers/winx64/vmxnet3n61x86.sys   http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3n61x86.sys
curl --output drivers/winx64/vmxnet3ndis6.cat    http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3ndis6.cat
curl --output drivers/winx64/vmxnet3ndis6.inf    http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3ndis6.inf
curl --output drivers/winx64/vmxnet3ndis6ver.dll http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3ndis6ver.dll

# Windows 32bit Drivers
curl --output drivers/winx86/vmxnet3n61x64.sys   http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3n61x64.sys
curl --output drivers/winx86/vmxnet3n61x86.sys   http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3n61x86.sys
curl --output drivers/winx86/vmxnet3ndis6.cat    http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3ndis6.cat
curl --output drivers/winx86/vmxnet3ndis6.inf    http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3ndis6.inf
curl --output drivers/winx86/vmxnet3ndis6ver.dll http://int-resources.ops.puppetlabs.net/VMware/Win64%20Drivers/vmxnet3ndis6ver.dll

