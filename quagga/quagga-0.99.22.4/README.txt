
These files report how I build Quagga 0.99.22.4 on Linux Ubuntu 12.04.x.
The build includes OLSR support: the patch provided by the Quagga plugin
of the OLSR implementation released by oslr.org is used.

conf_files/
-----------
Directory providing simple initial configuration files.

quagga-224-init_d-relevant.patch
--------------------------------
Minor changes to the init.d script provided in the Debian package:
- to adapt some directory paths;
- for easier coexistence of multiple installations of Quagga: the stop
  option relies on process IDs rather than on full paths of executables.

quagga-224-init_d
-----------------
Patched version of the Debian init.d script.

build-quagga-224.sh
-------------------
Build and installation script; it should be sufficiently self-explanatory.

