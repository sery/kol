/*
*
*		srylib
*
*		... because i hate copypastaing functions.
*
*//*
*		v. 0.2	- 	23 Sept 2013
*					can_PVP()				-	returns a boolean of whether or not you can PvP
*												based on the status of your hippy stone.
*												Keyword: METHOD:CANPVP
*					count_PVP_fights()		-	returns the number of PVP fights you have remaining.
*												if hippy stone is unbroken it returns "0"
*												Keyword: METHOD:COUNTFIGHTS
*//*
*		v. 0.1	-	19 Sept 2013
*					get_current_outfit() 	- 	produces a map of what you are currently wearing,
*												keyed by slot.
*												Keyword: METHOD:CURRENTOUTFIT
*					debug()					-	prints a line based on the status of 'sryDebugOn'
*												Keyword: METHOD:DEBUG
*		
*/					

/*	METHOD:DEBUG	*//*
*	Sets up debugging info and method. Toggling the 'sryDebugOn' pref toggles debug lines
*	across all of my scripts.
*	Defaults to off (false).
*/
if (get_property("sry_DebugOn") == ""){
	set_property("sry_DebugOn",false);
	}
void debug(string s) {
if (to_boolean(get_property("sry_DebugOn"))) print("DEBUG: " + s, "purple");
}
/*	END: METHOD:DEBUG	*/

/*	METHOD:CURRENTOUTFIT	*//*
*	Returns a map of items you are currently wearing, keyed to slot.
*/
item [slot] get_current_outfit(){
	item [slot] wearing;
	foreach equipslot in $slots[hat, weapon, off-hand, back, shirt, 
								pants, acc1, acc2, acc3, familiar] {
		wearing[equipslot] = equipped_item( equipslot );
		}
	return wearing;
	}
/*	END: METHOD:CURRENTOUTFIT	*/

/*	METHOD:CANPVP	*//*
*	returns a boolean of whether or not you can PvP based on the status of your hippy stone.
*/
boolean can_PVP() {
	if(!to_boolean(get_property("_sry_canPVP"))) {
		string PeeVPee=visit_url("peevpee.php?place=fight"); 
		if(PeeVPee.contains_text("You must break your")) { 
        	debug("You haven't chosen to PvP, I can't help you!"); 
        	set_property("_sry_canPVP", false);
        	return to_boolean(get_property("_sry_canPVP"));
        	}
        else if(PeeVPee.contains_text("You're out of fights")) { 
        	debug("You are out of fights, wait for rollover!"); 
    		set_property("_sry_canPVP", true);
    		return to_boolean(get_property("_sry_canPVP"));
    		}
    	else { 
        	matcher PvPs = create_matcher("You have ([0-9,]+) fight(?:s)? remaining today", PeeVPee); 
       		if(find(PvPs)) { 
        	    debug("You have "+ PvPs.group(1) +" fights remaining today");
            	set_property("_sry_canPVP", true);
            	return to_boolean(get_property("_sry_canPVP"));
            	}
    		else return to_boolean(get_property("_sry_canPVP"));
            }
        }
    else return to_boolean(get_property("_sry_canPVP"));    
    }
/*	END: METHOD:CANPVP	*/
	
/*	METHOD:COUNTFIGHTS	*//*
*	returns the number of PVP fights you have remaining.
*	if hippy stone is unbroken it returns "0".
*/
int count_PVP_fights() {
	if(!can_PVP()){
		return 0;
    	} 
    else {
    	string PeeVPee=visit_url("peevpee.php?place=fight"); 
        matcher PvPs = create_matcher("You have ([0-9,]+) fight(?:s)? remaining today", PeeVPee); 
        if(find(PvPs)) { 
            debug("You have "+ PvPs.group(1) +" fights remaining today");
            return PvPs.group(1).to_int(); 
        	}
        else return 0; 
		} 
	} 
/*	END: METHOD:COUNTFIGHTS	*/