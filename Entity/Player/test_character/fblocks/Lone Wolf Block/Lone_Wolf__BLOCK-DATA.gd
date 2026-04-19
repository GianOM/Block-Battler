class_name Lone_Wolf
extends FBlock_Data

var base_dmg:= 5

func do_fblock_actions(target: Node):
	
	COMBATE.Clear_Enemies_Dict()
	
	
	
	var number_of_enemies: int = COMBATE.Combat_ID_Dict.size()
	
	
	
	
	var damage:= Damage.new()
	
	#Precisa ser maior que DOIS, pois o Player estar neste dicionario
	if number_of_enemies >= 3:
		damage.amount = base_dmg
		
	else :
		#TODO apply modifiers to base dmg
		damage.amount = base_dmg * 4
	
	
	
	damage.execute(target)
