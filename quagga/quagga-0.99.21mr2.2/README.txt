
These files refer to the OSPF-MDR implementation for quagga OSPFv3,
maintained by the Mobile Routing project at the Naval Research Laboratory:
http://cs.itd.nrl.navy.mil/work/ospf-manet/

conf_files/
-----------
Directory providing simple initial configuration files.

quagga-0.99.21mr2.2-zebra-libcap.patch
--------------------------------------
Changes listing of some libraries to avoid an annoying link error.

quagga-mdr-init_d-relevant.patch
--------------------------------
Minor changes to the init.d script provided in the Debian package:
- to adapt some directory paths;
- for easier coexistence of multiple installations of Quagga: the stop
  option relies on process IDs rather than on full paths of executables.

quagga-mdr-init_d
-----------------
Patched version of the Debian init.d script.

olsrd-quagga-0.99.21mr2.2-hunk1.patch
-------------------------------------
A patch that replaces the first hunk of the patch provided
in the olsrd-0.6.5.4 source tarball to add support for olsrd.

build-quagga-mdr.sh
-------------------
Build and installation script; it should be sufficiently self-explanatory.

