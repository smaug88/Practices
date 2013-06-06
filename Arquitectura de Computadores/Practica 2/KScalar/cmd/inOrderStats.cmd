def_state   DState "Cache_Stall?6:(Decode_State!=255?Decode_State:(!Fetch_PrevState?1:6+Fetch_PrevState))" "" ""
def_statdis Stalls DState "" "" 10 1 0

def_stat Mispred_Stalls "Stalls[1]" "Stalls" "Counts CYCLES lost due to\n BRANCH MISPREDICTIONS"
def_stat Raw_Stalls     "Stalls[2]" "Stalls" "Counts CYCLES lost due to\n RAW HAZARDS"
def_stat WB_Stalls      "Stalls[3]" "Stalls" "Counts CYCLES lost due to\n WriteBack HAZARDS"
def_stat Issue_Stalls   "Stalls[4]" "Stalls" "Counts CYCLES lost due to\n lack of ISSUE PORTS"
def_stat dPorts_Stalls  "Stalls[5]" "Stalls" "Counts CYCLES lost due to\n lack of dCACHE Read/Write PORTS"
def_stat dCache_Stalls  "Stalls[6]" "Stalls" "Counts CYCLES lost due to\n DATA CACHE MISSES"
def_stat iCache_Stalls  "Stalls[7]" "Stalls" "Counts CYCLES lost due to\n INSTRUCTION CACHE MISSES"
def_stat BrnchBW_Stalls "Stalls[8]" "Stalls" "Counts CYCLES lost due to\n lack of BRANCH prediction BANDWIDTH\n or because BRANCH QUEUE gets FULL"
def_stat SysCall_Stalls  "Stalls[9]" "Stalls" "Counts CYCLES lost due to\n SYSTEM CALLS and INTERRUPTS\n(includes first execution cycle)"

