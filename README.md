# resolve-them
A customizable and platform-independent bash script written to resolve the
dependencies of your package.

## Platform supported
Currently, this bash script only works on **Deb-based** and **pacman-based**
systems. **redhat-based systems** and **OSX** are NOT supported. 
Pull requests are welcome :)

## License
GNU GENERAL PUBLIC LICENSE Version 3

## Installation & Usage

#### Download and run the script
* $ git clone https://github.com/lorix-lpan/resolve-them
* $ cd resolve-them
* $ bash resolve.sh

#### Configuration
Please read the comments on the file contains the script. You need to 
modify a few global variables before executing it.

## Functions

The script executes in the following order:

1. Detect the package manager installed(apt-get or pacman) then assign the
   name of the package manager to variable PACM.
2. Check if the dependencies are installed according to the array variable
   PACK_LIST_ARCH or PACK_LIST_DEB
3. Install the dependencies

Note: Different package managers have different names for the same package.

## Examples

For example usage, please check out
https://github.com/lorix-lpan/alleles-fixation/blob/master/install.sh

