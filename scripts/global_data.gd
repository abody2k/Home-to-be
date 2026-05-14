extends Node

enum MISSIONS{
	
	WAKING_UP,
	TALKING_TO_CAPTIN,
	REACHING_SHORE,
	FINDING_LOCALS,
	FINDING_HOME,
	MEETING_THOSE_IN_CELLS,
	TALKING_TO_LOCALS,
	BRINGING_FOOD,
	PROTECTING_LOCALS,
	VISITING_HOME,
	TRANSMISSION_FAILS,
	HEADING_TO_CAVES,
	TIME_TRAVEL,
	DRIVING_BOAT_TO_SHIP,
	MASSACRE,
	GENEISIS,
	THE_END
}


var last_mission_finished : MISSIONS

var current_mission : MISSIONS = MISSIONS.WAKING_UP

func mission_completed():
	if current_mission == MISSIONS.THE_END:
		pass
	else:
		current_mission+=1
		#run function for the next mission
