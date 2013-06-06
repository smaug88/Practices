# phantom variables: they are not shown
def_little dL1_Hits    ""
def_little dL1_Misses  ""
def_little dL1_wHits   ""
def_little dL1_wMisses ""

# visualize this way
def_stat dCache_Hits   "dL1_Hits_Sum+dL1_wHits_Sum"     "dCache"  "Total number of dCache hits"
def_stat dCache_Misses "dL1_Misses_Sum+dL1_wMisses_Sum" "dCache" "Total number of dCache misses"
def_stat dCache_Miss_Rate    "(dCache_Hits+dCache_Misses)?(dCache_Misses*100)/(dCache_Hits+dCache_Misses):0" "dCache" "Percentage of dCache misses"
