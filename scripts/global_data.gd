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
			start_captain_mission()
		MISSIONS.REACHING_SHORE:
			start_reaching_shore_mission()
		MISSIONS.FINDING_LOCALS:
			start_finding_locals_mission()
			
			
			

func start_captain_mission():
	var mc = get_tree().get_first_node_in_group("mc") as CharacterBody3D
	
	## TODO add audio function to *** incoming transmisison ***
	mc.update_dialogs([
		["Captain: Hey, seaman. I heard you were sleeping on the job, you think this is some sort of a trip?",null],
		["You: NNno, Captain. I was just...",null],
		["*** INCOMING TRANSMISSION ***",null] ,
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
	
	



func start_reaching_shore_mission():
	var mc = get_tree().get_first_node_in_group("mc") as CharacterBody3D
	
	mc.update_dialogs([
		["You: So we finally reached the shore",null],
		["Crewmate 1: This looks like a creeply place to me, what should we do?",null] ,
		["You: Best thing is to split into 3 groups because it's a big island and we have different things to do, first group will search for resources, the other will try to locate the locals and me and the last group will try to locate the signal location",null],
		["Crewmate 1: This looks like an old temple, look at these writings on the wall, I wonder what they mean", null],
		["Crewmate 2: That's Arabic, I can help with the translations",null],
		["You: that means you should come with me in case we needed help. Come on! let's go!",null],
	])
	
	
	
func start_finding_locals_mission():
	
	var mc = get_tree().get_first_node_in_group("mc") as CharacterBody3D
	
	mc.update_dialogs([
		["You: Now that's a house",null],
		["Crewmate 2: The signal seems to be coming from this room",null] ,
		["You: it seems like nobody toched the radio for a long time, Let's try to contact the ship",null],
		["Crewmate 2: Seems like no signal is there", null],
		["You: You mean this device doesn't work?",null],
		["Crewmate 2: No, I mean the ship is no blocking our signal",null],
		["*** INCOMING TRANSMISSION ***",null],
		["Crewmate 1: sir, we can't seem to contact the ship, we found an old prison over here though, nobody is here. Also, there is no sign for the locals",null],
		["You: copy that. We found the radio and we are also unable to contact the ship, we will be there with you in no time.",null],
		["Crewmate 2: What should we do?",null],
		["You: We should head there and wait for the third group, we are already starving, if no one came we will just abandon the island",null],
		["You: You know, I have a weird feeling about this house, I feel like I been here before",null],
		["Crewmate 2 : You mean on this island?",null],
		["You: I saw this house in a dream, it just feels so real...",null],
		["Crewmate 2 : We don't have time for that, sir... we need to head back to the boat then follow the shore to the left until we meet our crewmates",null],
		["You: Yeah.. sure.",null],
	])
	
