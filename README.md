# Phylomatic-awk

A CLI phylomatic written in Awk

Internal phylogeny representation
---------------------------------

Each node is represented by the following array values:

 * `nodename` : the node identifier (string)
 * `parent[nodename]` : the parent node identifier
 * `bl[nodename]` : branch length to the parent node (float or string)
 * `taxon[nodename]` : the taxon assoc with that node identifier (string)
 * `nDaughter[nodename]` : the number of distal edges (integer)
 * `note` : any notes associated with the node (string)
 * `lDaughter[nodename]` : the left daughter of a node, created only
   during writing of newick (string)
 * `rSister[nodename]` : the right sister of a node, created only
   during writing of newick (string)
 * `age[nodename]` : the age of the node, measured from (ultramentric)
   tips (integer or float)

Other globals valiables:

 * `hasBL` : does the tree contain BLs? (0|1)
 * `totalBL` : the total tip to root BL sum (assumes an ultrametric
   tree) (float or string)
 * `rootNode` : the root node

