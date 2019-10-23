# ptfe-base-box
Ubuntu Bionic 64 Base Box for PTFE installation

*Vagrant* *VirtualBox* **base box**¹ of Ubuntu Bionic Beaver 64bit created with *Packer* for the purpose of the future PTFE instllation on top.
For the corresponding technologies mentioned here see in details [Prerequisite section](#prerequisites)

*¹* - *There are a special category of boxes known as "base boxes." These boxes contain the bare minimum required for Vagrant to function, are generally not made by repackaging an existing Vagrant environment (hence the "base" in the "base box").*

# Purpose 

This repository attempts to have minimal amount of code that is required to create an Ubuntu Bionic Beaver 64it box using Packer for running in VirtualBox with management by Vagrant. You should have Packer, Vagrant and VirtualBox installed. 

To learn more about the mentioned above tools and technologies -  please check section [Technologies near the end of the README](#technologies)


# How to use



# Technologies

1. **To download the content of this repository** you will need **git command-line tools**(recommended) or **Git UI Client**. To install official command-line Git tools please [find here instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for various operating systems. 
2. **For managing infrastructure** we using Terraform - open-source infrastructure as a code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON. More you encouraged to [learn here](https://www.terraform.io). 
3. **This project for virtualization** recommends **VirtualBox**, download the binaries for your [platform here](https://www.virtualbox.org/wiki/Downloads) and then follow [instructions for installation](https://www.virtualbox.org/manual/ch02.html)
4. **For managing VM** (virtual machines), we are going to use **Vagrant**. To install **Vagrant** , please follow instructions here : [official Vargant installation manual](https://www.vagrantup.com/docs/installation/)
5. For creating base box image from scratch we need **Packer** - an open source tool for creating identical machine images for multiple platforms from a single source configuration.  You can [download binaries for your platform here](https://www.packer.io/downloads.html)  and then [follow this installation instruction](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).  In our case Packer is going to take care of installing OS into VM, communicating with it, doing basic provision and preparing for us packed Vagrant box, ready to use.
6. **Terraform Enterprise** - is HashiCorp's self-hosted distribution of Terraform Cloud. It offers enterprises a private instance of the Terraform Cloud application, with no resource limits and with additional enterprise-grade architectural features like audit logging and SAML single sign-on.
*Terraform Cloud* is an application that helps teams use Terraform together. It manages Terraform runs in a consistent and reliable environment, and includes easy access to shared state and secret data, access controls for approving changes to infrastructure, a private registry for sharing Terraform modules, detailed policy controls for governing the contents of Terraform configurations, and more. You can read more [here](https://www.terraform.io/docs/enterprise/index.html)

 

# TODO
- [ ] get require ISO links and checksums
- [ ] create basic template
- [ ] build first box
- [ ] create initial Vagrant template to run the box
- [ ] tune packer template, for PTFE requirements
- [ ] test box
- [ ] update readme with instructions
- [ ] add steps to publish box on vagrant cloud using `vagrant cloud publish`


# DONE
- [x] create initial readme
