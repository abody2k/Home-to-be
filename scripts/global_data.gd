extends Node

enum MISSIONS{
	
	WAKING_UP,
	TALKING_TO_CAPTIN,
	TAKING_BOAT,
	REACHING_SHORE,
	FINDING_LOCALS,
	TALKING_TO_LOCALS,
	DELIVERING_FOOD,
	HEADING_TO_CAVES,
	TIME_TRAVEL,
	MASSACRE,
	GENEISIS,
	THE_END
}


var eating = 0


func increase_eaters():
	eating+=1
	
	if eating == 4:
		mission_completed()
		
func is_this_mission_over(mission : int):
	return current_mission > mission
	
	
	
var last_mission_finished : MISSIONS

var current_mission : MISSIONS = MISSIONS.FINDING_LOCALS

func mission_completed():
	print("MISSION IS ACTUALLY DONE and its number is : " + str(current_mission))
	
	if current_mission == MISSIONS.THE_END:
		pass
	else:
		last_mission_finished = current_mission
		current_mission+= 1 as MISSIONS
		
func start_new_mission():
	print("STARTING NEW MISSION : ")
	print(current_mission)
			## CALL A FUNCTION THAT DOES THINGS FOR EVERY EVENT
	match current_mission:
		MISSIONS.TALKING_TO_CAPTIN:
			start_captain_mission()
		MISSIONS.REACHING_SHORE:
			start_reaching_shore_mission()
		MISSIONS.FINDING_LOCALS:
			start_finding_locals_mission()
		MISSIONS.TALKING_TO_LOCALS:
			start_talking_to_locals()
		MISSIONS.DELIVERING_FOOD:
			start_delivering_food_mission()
		MISSIONS.HEADING_TO_CAVES:
			start_heading_to_caves()
		MISSIONS.TIME_TRAVEL:
			start_time_travel_mission()
		MISSIONS.MASSACRE:
			(get_tree().get_first_node_in_group("player") as AnimationPlayer).play("massacre")
		MISSIONS.GENEISIS:
			#switch to lab
			pass
			
			
			

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
		["Yes sir...", jump_into_boat.bind(mc)],
	])
	
	

func jump_into_boat(mc):
	get_tree().get_first_node_in_group("ship").get_node("barrier").queue_free()
	mc.jump_into_boat()

func start_reaching_shore_mission():
	var mc = get_tree().get_first_node_in_group("mc") as CharacterBody3D
	
	mc.update_dialogs([
		["You: So we finally reached the shore",null],
		["Crewmate 1: This looks like a creeply place to me, what should we do?",null] ,
		["You: Best thing is to split into 3 groups because it's a big island and we have different things to do, first group will search for resources, the other will try to locate the locals and me and the last group will try to locate the signal location",null],
		["Crewmate 1: This looks like an old temple, look at these writings on the wall, I wonder what they mean", null],
		["Crewmate 2: That's Arabic, I can help with the translations",null],
		["You: that means you should come with me in case we needed help. Come on! let's go!",mc.move_troops_to_shore],
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
	


	
func start_talking_to_locals():
	
	var mc = get_tree().get_first_node_in_group("mc") as CharacterBody3D
	
	mc.update_dialogs([
		["You: here we are",null],
		["Crewmate 1: ...",null] ,
		["You: Where is the other group?",null],
		["Crewmate 1: They haven't returned yet", null],
		["You: What? you have to be here so that we can all depart, this is nuts.",null],
		["Crewmate 2: What about the locals?",func (): (get_tree().get_first_node_in_group("screeching") as AudioStreamPlayer3D).play()],
		["...",null], #SCRECHING SOUND
		["Crewmates : WTF was that???",null],
		["You: Close all the doors",func (): (get_tree().get_first_node_in_group("player") as AnimationPlayer).play("monsters_appearing")],
		["unknown : STOP",func (): (get_tree().get_first_node_in_group("islanders") as Node3D).visible = true], # islanders move toward the player
		["unkown: Don't be afaid, human",null],
		["You:Yoooo, WTF are you??? EVERYONE, HOLD POSITIONS!",null],#everyone aims at the islanders
		["unknown : We called for your help, remember? we need your help",null],
		["You:Don't come any closer or else we will shoot",null],
		["Crewmates : We better shoot them sir!",null],
		["unknown: help us and we will give you the treasure of the island",null],
		["You: hold it right there, Speak, beast.",null],
		["unknown: We are not alone on this island as you already know, as a matter of fact there are monsters among us, they come at night and can't be killed but they live in caves on the Eastren side of the island",null],
		["You: wait, our crewates went to the east searching for food and shelter, are you saying they are...",null],
		["unknown: Yes they are dead. There is no food or shelted to be found, all they found is their fate waiting for them",null],
		["You: But they have guns with them",null],
		["unknown: Nothing works on these things, this screaching sound you here outside? that's them and they are coming for us, we are the food of the island.",null],
		["You: What are you suggesting then?",null],
		["unknown: There is an ancient machine in the caves that can help reverse everything and fix everything. You see, before you did what you did we weren't actually here, but you had to catch him didn't you?",null],
		["You: What?",null],
		["unknown: It is not a dream!",func (): mc.ammo = 10],
		["You: But how? do you..",func (): (get_tree().get_first_node_in_group("screeching") as AudioStreamPlayer3D).play()],
		["...",func (): get_tree().call_group("monsters","make_visible")], # screaching sound and monsters come in
		["unknown: They are here!",func (): get_tree().get_first_node_in_group("player").play("prison_mission_start") ],
		["You: EVERYONE AIM AND SHOOT THE MONSTERS!",func (): get_tree().get_first_node_in_group("random").playing = true],
		
	])
	
func start_delivering_food_mission():
	
	var mc = get_tree().get_first_node_in_group("mc") as CharacterBody3D
	
	mc.update_dialogs([
		["You: Shit, I'm out of ammo",null],
		["Crewmate 1: What should we do? sir",null] ,
		["You: Let's give them something to eat! everyone shoot the natives!",null],
		["unknown: But we had a deal", null],
		["You: We don't even know you, thanks for the info",null],
		["unknown : What you are going to find out..",null],
		["...",null], #everyone shoots the islanders
		["You: Let's head to the caves while these things are eating, the treasure is porbably there, we will take it then we will head to the boat",func (): get_tree().call_group("soliders","enable_shooting_mode")],
		["Crewmate 1: Sir yes sir!",func (): mc.ammo = 100],
		
		
	])
	
func start_heading_to_caves():
	
	var mc = get_tree().get_first_node_in_group("mc") as CharacterBody3D
	
	mc.update_dialogs([
		["You: What is this weird place",null],
		["Crewmate 1: There are a lot of writings on the wall",null] ,
		["You: Can't you translate it?",null],
		["Crewmate 1: They are telling a sad story", null],
		["You: We don't have time for that let's go deeper",null],
		["Crewmate 1 : Yes sir...",null],
		
		
	])
	
func start_time_travel_mission():
	
	var mc = get_tree().get_first_node_in_group("mc") as CharacterBody3D
	
	mc.update_dialogs([
		["You: Would you look at this, A DEAD END",null],
		["Crewmate 1: Quite the opposite sir...",null] ,
		["You: Do you see something I'm not seeing?",null],
		["Crewmate 1: the writing on the walls and this thing", null],
		["You: Can you ealborate more?",null],
		["Crewmate 1 : These sad poems are about someone missing their lover, it seems like this whole thing started because of it and judging by the fact that there are no correspondings it seems like someone was taken away!",null],
		["You: Can you ealborate more?",null],
		["Crewmate 1: the writing on the walls and this thing", null],
		["You: And?",null],
		["Crewmate 1: this thing is a time machine but it warns against questioning what happened in the past and not accepting fate.", null],		
		["You: Are you saying we should die or what? because that's what is going to happen if we don't leave this place and we are already surrounded by these monsters",null],
		["Crewmate 1: Judging by what we did at the prison cells? Maybe we should die.", null],		
		["You: That's your choice man, but how do I activate this thing? these things are getting closer",null],
		["Crewmate 1: You just walk into the white zone...", null],
		["You: Aren't you going to come with me?",null],
		["Crewmate 1: I have decided to face the consquences for my own actions...", null],		
	])
	
