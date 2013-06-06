# phantom variables: they are not shown
def_statdis iL1dis iL1_State  "" "" 3 1 0

# visualize this way
def_stat iCache_Hits   "iL1dis[1]" "iCache" "Total number of iCache hits"
def_stat iCache_Misses "iL1dis[2]" "iCache" "Total number of iCache misses"
def_stat iCache_Miss_Rate    "(iCache_Hits+iCache_Misses)?((iCache_Misses*100)/(iCache_Hits+iCache_Misses)):0" "iCache" "Percentage of iCache misses"
