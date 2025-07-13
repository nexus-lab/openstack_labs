# OpenStack Labs

This repository contains the LaTeX source and compiled PDFs of a set of computer labs that guide students through managing and interacting with an OpenStack environment. The labs start with simple concepts like launching an instance, and each subsequent lab introduces a new OpenStack concept. The final lab is a capstone project of creating an FTP server, which combines almost all the concepts learned to that point.

The topics covered by the labs include:

- Launching an instance
- Creating and managing projects, users, and roles
- Creating images and flavors
- Creating and managing internal and external networks, routers, and floating IP addresses
- Creating and managing security groups and SSH key pairs
- Customizing instances with cloud-init
- Managing the running state of an instance (pausing, suspending, shelving, rescuing, etc.)

All topics are taught with both the *Horizon Dashboard* web interface and the *OpenStack Unified CLI*.

> [!NOTE]
> These labs were based on the [Red Hat OpenStack Administration I: Core Operations for Domain Operators](https://www.redhat.com/en/services/training/cl110-red-hat-openstack-administration-i) course. However, the labs in this repository have been expanded and modified.

## Using the Labs

These labs assume that the environment is set up to the specifications in [environment_setup.md](environment_setup.md). Once the environment is set up, students should be able to get a lab reservation, log in to the `workstation` machine, and follow the lab instructions.

## Prerequisites

- A LaTeX distribution (e.g., [MikTeX](https://miktex.org), [TeX Live](https://www.tug.org/texlive/))
- If using the provided Makefiles:
  - A Perl environment (e.g., [Strawberry Perl](https://strawberryperl.com))
  - [`latexmk`](https://mgeier.github.io/latexmk.html)

## Building the LaTeX Source

First, clone the repository, and navigate to the repository's root directory.

```bash
git clone https://github.com/nexus-lab/openstack_labs
cd openstack_labs
```

At this point, you should have the most up-to-date PDFs. However, you might want to make changes and recompile the LaTeX source. A `Makefile` is provided for each lab for compilation with `latexmk` and PDFLaTeX. To compile them, either run the provided `make_all.bat` file from the root directory of the repository (Windows only), or navigate to each directory containing a `Makefile` and run

```bash
make
```
