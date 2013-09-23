/*
*
*		srylib
*
*		... because i hate copypastaing functions.
*
*
*		v. 0.1	-	19 Sept 2013
*					get_current_outfit() 	- 	produces a map of what you are currently wearing,
*												keyed by slot.
*												Keyword: METHOD:CURRENTOUTFIT
*					debug()					-	prints a line based on the status of 'sryDebugOn'
*												Keyword: METHOD:DEBUG
*/					

/*
*	METHOD:DEBUG
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

/*
*	METHOD:CURRENTOUTFIT
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


/*
*	Prelim PVP shit
*/
int count_fights() { 
    string PeeVPee=visit_url("peevpee.php?place=fight"); 
    if(PeeVPee.contains_text("You must break your")) { 
        //print("You haven't chosen to PvP, I can't help you!", "blue"); 
        boolean canPVP = false;
    } else if(PeeVPee.contains_text("You're out of fights")) { 
        //print("You are out of fights, wait for rollover!", "red"); 
        boolean canPVP = true;
    } else { 
        matcher PvPs = create_matcher("You have ([0-9,]+) fights remaining today", PeeVPee); 
        if(find(PvPs)) { 
            //print("You have "+ PvPs.group(1) +" fights remaining today", "blue");
            boolean canPVP = true;
            return PvPs.group(1).to_int(); 
        } 
    } 
    return 0; 
} 