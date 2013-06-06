# phantom variables: they are not shown
def_statdis Bpreddis Branch_Predict  "" "" 9 1 0

# visualize this way
def_stat Cond_Hits   "Bpreddis[1]" "Branches" "Total number of correctly-predicted Conditional Branches"
def_stat Cond_Misses "Bpreddis[5]" "Branches" "Total number of mispredicted Conditional Branches"
def_stat Cond_Misp_Rate   "(Cond_Hits+Cond_Misses)?((Cond_Misses*100)/(Cond_Hits+Cond_Misses)):0" "Branches" "Percentage of mispredicted Conditional Branches"

def_stat DirJ_Hits   "Bpreddis[2]" "Branches" "Total number of correctly-predicted Unconditional Direct Jumps"
def_stat DirJ_Misses "Bpreddis[6]" "Branches" "Total number of mispredicted Unconditional Direct Jumps"
def_stat DirJ_Misp_Rate   "(DirJ_Hits+DirJ_Misses)?((DirJ_Misses*100)/(DirJ_Hits+DirJ_Misses)):0" "Branches" "Percentage of mispredicted Unconditional Direct Jumps"

def_stat IndJ_Hits   "Bpreddis[3]" "Branches" "Total number of correctly-predicted Unconditional Indirect Jumps"
def_stat IndJ_Misses "Bpreddis[7]" "Branches" "Total number of mispredicted Unconditional Indirect Jumps"
def_stat IndJ_Misp_Rate   "(IndJ_Hits+IndJ_Misses)?((IndJ_Misses*100)/(IndJ_Hits+IndJ_Misses)):0" "Branches" "Percentage of mispredicted Unconditional Indirect Jumps"

def_stat Ret_Hits   "Bpreddis[4]" "Branches" "Total number of correctly-predicted Returns"
def_stat Ret_Misses "Bpreddis[8]" "Branches" "Total number of mispredicted Returns"
def_stat Ret_Misp_Rate   "(Ret_Hits+Ret_Misses)?((Ret_Misses*100)/(Ret_Hits+Ret_Misses)):0" "Branches" "Percentage of mispredicted Returns"
