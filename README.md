# Phylomatic-awk

_A CLI `phylomatic` written in Awk_

Phylomatic is a tool for attaching members of a user-supplied list of
taxa (in the ‘`taxa`’ file) to a master, or ‘mega’ phylogeny (in the
‘`phylo`’ file) at as terminal a position as possible, using the
internal node names of the megatree.  

Please see
[Webb and Donoghue (2005)](http://camwebb.info/files/pubs/webb2005_men.pdf)
for more information on the goals of the tool, and
[this page](https://camwebb.info/doc/phylomatic.html) for a short
history of its implementation.

## Usage

Basic usage is:

    phylomatic OPTIONS --newick <phylo_file> --taxa <taxa_file>

where OPTIONS are:

 * `--noclean`: Do not clean single-daughter nodes from output phylogeny
 * `--fyout`: Output a tabular `fy` representation of the output phylogeny

and required arguments are:

 * `--newick <phylo_file>`: a file containing a single Newick
     serialization of a phylogeny. Two key requirements: The taxon
     names must begin with a character from `A-Z` or `a-z` or `_`
     (i.e. not numbers), and any branch lengths must not be in
     scientific notation (i.e. ‘0.0001’, not ‘1.0E-4’).
 * `--taxa <taxa_file>`: a file containing taxa to be grafted into the
     phylogeny. Format: plain text, one taxon per line. Parent taxa
     may be prefixed to the taxon to be matched with slashes (`/`); if
     the taxon name itself is not found in the phylogeny, one of its
     parent taxa may be. See below, and examples.

For example, to use the Zanne 2014 megatree included in the `data/`
directory, with an example list of taxa, in the `examples/` directory,
and send the Newick output to a file `out.new`:

    phylomatic --newick data/zanne2014.new --taxa examples/taxa2 > out.new

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

The default Awk on Macs is not Gawk, but the script may run as is
(though it uses Gawk extensions that are not POSIX standard). Run the
script in a Terminal window with:

    awk -f phylomatic --newick ...etc

If the script fails with syntax error or illegal statement errors, you
will need to install Gawk, e.g., using [Homebrew](https://brew.sh/) or
[Fink](https://www.finkproject.org/).

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

## The taxa file

Each [RETURN]-delimited line of the file lists a set of hierarchical
taxon names (delimited by ‘`/`’), which will be sought for as either
terminal or internal node names in the megatree. An example:

      annonaceae/annona/Annona_cherimola
      annonaceae/annona/Annona_muricata
      fagaceae/Quercus_robur
      dipterocarpaceae/shorea/Shorea_parvifolia

The last name on each line is the name that will be spliced into the
returned tree. Note that phylomatic will not match a taxon `Z` in
`x/y/Z` where `Z` is an internal node in the megatree (reference)
phylogeny. In the case where, for instance, an output tree of just
genera is desired, but some of the genera appear in the megatree as
internal node names, ‘dummy species’ names can be used genus (e.g.,
`betulaceae/alnus/alnus_sp`); a text editor can later be used to
remove the ‘`_sp`’ from the output tree.

This ‘`/`’-delimited format allows the creation of unlimited
user-defined phylogenetic structure. The program reads the string from
right to left, matching the taxon at the first position it can in i)
the ‘megatree,’ or ii) the growing user-defined tree. Hence, a `taxa`
file containing:

```
annonaceae/g1/s1
annonaceae/g2/s2
annonaceae/g2/s3
annonaceae/g2/s4/ssp1
annonaceae/g2/s4/ssp2
```

will produce a tree containing:
`((s1)g1,(s2,s3,(ssp1,ssp2)s4)g2)annonaceae`.  See `taxa` files the
`examples` directory.

