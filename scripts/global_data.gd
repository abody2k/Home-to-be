extends Node

enum MISSIONS{
	
	WAKING_UP,
	TALKING_TO_CAPTIN,
	TAKING_BOAT,
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
	print("MISSION IS ACTUALLY DONE")
	if current_mission == MISSIONS.THE_END:
		pass
	else:
		last_mission_finished = current_mission
		print(current_mission)
		current_mission+= 1 as MISSIONS
		
func start_new_mission():
	print("ENDING MISSION")
	print(current_mission)
	print(MISSIONS.TALKING_TO_CAPTIN)
			## CALL A FUNCTION THAT DOES THINGS FOR EVERY EVENT
	match current_mission:
		MISSIONS.TALKING_TO_CAPTIN:
			print("starting captain mission")
			start_captain_mission()
			
			
			

func start_captain_mission():
	var mc = get_tree().get_first_node_in_group("mc") as CharacterBody3D
	
	## TODO add audio function to *** incoming transmisison ***
	mc.update_dialogs([
		["Captain: Hey, seaman. I heard you were sleeping on the job, you think this is some sort of a trip?",null],
		["You: NNno, Captain. I was just...",null],
		["*** INCOMING TRANSMISSION ***"] ,
		["HELP!, CAN YOU HEAR ME! WE HAVE BEEN STRANDED IN THE SEA FOR MONTHS, PLEASE HELP US",null],
		["Captain: Who is this? and how did you manage to interfer with our communication?", null],
		["PLEASE, WE DON'T HAVE ENOUGH FOOD, THEY ARE HUNTING US",null],
		["Captain: What??! who is hunting you? make some sense",null],
		["We were on a ship and we were attacked, please we don't have enough time.",null],
		["Captain: once we reach shore we will send coordinates for rescue teams to come to you",null],
		["We won't be alive by the time you ******",null], # NOISE
		["Captain: Are you there?",null],
		["This island is uncharted, no one knows about this island. We found trasures over here but our ship was recked, we only have enough food for one day",null],
		["Captain: Say no more, we will come to your rescue. Just wait for us on the shore", null],# TRANSMISION LOST VOICE
		["Captain: did you manage to find the source of the signal?",null],
		["CREWMATE: Sir Yes sir!",null],
		["Captain: You, you were slacking off the whole time sleeping and doing nothing productive and helpful, take some with you and head to the island.",null],
		["You: But sir, capture and rescue is not my profession, we don't know anything about these people.",null],
		["Captain: No butts, that's an order! Do you understand?",null],
		["Yes sir...", func(): get_tree().get_first_node_in_group("ship").get_node("barrier").queue_free()],
	])
	
	
