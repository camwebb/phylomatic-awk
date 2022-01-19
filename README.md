# Phylomatic-awk

A CLI `phylomatic` written in Awk

## Usage

Basic usage is:

    phylomatic OPTIONS --newick <phylo_file> --taxa <taxa_file>

Where OPTIONS are:

 * `--noclean`: Do not clean single-daughter nodes from output phylogeny
 * `--fyout`: Output a tabular `fy` representation of the output phylogeny

and required arguments are:

 * `--newick <phylo_file>`: a file containing a single Newick
     serialization of a phylogeny. Two key requirements: The taxon
     names must begin with a character from `A-Z` or `a-z` or `_`
     (i.e. not numbers), and any branch lengths may not be in
     scientific notation.
 * `--taxa <taxa_file>`: a file containing taxa to be grafted into the
     phylogeny. Format: plain text, one taxon per line. Parent taxa
     may be prefixed to the taxon to be matched with slashes (`/`); if
     the taxon name itself is not found in the phylogeny, one of its
     parent taxa may be. See examples.

The program may also be used to just convert a Newick file into `fy`
format:

    phylomatic --new2fy --newick <phylo_file>

## Installation

The Awk script is self contained and can easily be run in any
environment where [GNU Awk](https://www.gnu.org/software/gawk/) is
available.

### Linux

Gawk is usually the default Awk on Linux, and usually comes
pre-installed.  The script can be run either as an executable using
the hashbang on the first line `#!/usr/bin/gawk`:

    ./phylomatic

or explicitly as a script via: 

    gawk -f phylomatic --newick ...etc

### Mac

The default Awk on Macs is not Gawk, but the script runs as is (though
it uses extensions that are not POSIX standard). Run the script in a
Terminal window with: 

    awk -f phylomatic --newick ...etc`

### Windows

The script can be easily run using Gawk cross-compiled for Windows,
and the `CMD.EXE` command prompt:

 * Download Gawk from
   [Ezwinports](https://sourceforge.net/projects/ezwinports/files/) and unzip
   on the Desktop.
 * (This step may not be needed... try `gawk.exe` first without
   it. Otherwise: download `libgcc-6.3.0-1-mingw32-dll-1.tar.xz`
   [here](https://sourceforge.net/projects/mingw/files/MinGW/Base/gcc/Version6/gcc-6.3.0/libgcc-6.3.0-1-mingw32-dll-1.tar.xz/download). Then [extract](https://tukaani.org/xz/)
   the file it contains: `libgcc_s_dw2-1.dll` and place this DLL file
   in the same directory as `gawk.exe`.)
 * Download the latest `phylomatic-awk` [release](https://github.com/camwebb/phylomatic-awk/releases/), and unzip on the Desktop.
 * In the menubar search box, type `CMD.EXE` and open it. This is the old
   DOS commandline. MS `Powershell` can also be used.

Type these commands (altering the version numbers if different). The
latest `CMD.EXE` has command line TAB-completion which speeds things
up. Basic commands: `dir` = view directory files, `cd` = change
directory, `copy`, `more` = see file contents.

    cd Desktop\phylomatic-awk-1.0.0
    dir
      ...
    ..\gawk-5.1.0-w32-bin\bin\gawk.exe -f phylomatic
    ..\gawk-5.1.0-w32-bin\bin\gawk.exe -f phylomatic --clean --newick data/zanne2014.new --taxa examples/taxa2
    ..\gawk-5.1.0-w32-bin\bin\gawk.exe -f phylomatic --clean --newick data/zanne2014.new --taxa examples/taxa2 > out.new
    dir
      ...
    more out.new

