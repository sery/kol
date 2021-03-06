/*
*
*       srylib
*
*       ... because i hate copypastaing functions.
*
*//*
*       v. 0.2  -   23 Sept 2013
*                   can_PVP()               -   returns a boolean of whether or not you can PvP
*                                               based on the status of your hippy stone.
*                                               Keyword: METHOD:CANPVP
*                   count_PVP_fights()      -   returns the number of PVP fights you have remaining.
*                                               if hippy stone is unbroken it returns "0"
*                                               Keyword: METHOD:COUNTFIGHTS
*//*
*       v. 0.1  -   19 Sept 2013
*                   get_current_outfit()    -   produces a map of what you are currently wearing,
*                                               keyed by slot.
*                                               Keyword: METHOD:CURRENTOUTFIT
*                   debug()                 -   prints a line based on the status of 'sryDebugOn'
*                                               Keyword: METHOD:DEBUG
*       
*/                  

/*  METHOD:DEBUG    *//*
*   Sets up debugging info and method. Toggling the 'sryDebugOn' pref toggles debug lines
*   across all of my scripts.
*   Defaults to off (false).
*/
if (get_property("sry_DebugOn") == ""){
    set_property("sry_DebugOn",false);
    }
void debug(string s) {
if (to_boolean(get_property("sry_DebugOn"))) print("DEBUG: " + s, "purple");
}
/*  END: METHOD:DEBUG   */

/*  METHOD:CURRENTOUTFIT    *//*
*   Returns a map of items you are currently wearing, keyed to slot.
*/
item [slot] get_current_outfit(){
    item [slot] wearing;
    foreach equipslot in $slots[hat, weapon, off-hand, back, shirt, 
                                pants, acc1, acc2, acc3, familiar] {
        wearing[equipslot] = equipped_item( equipslot );
        }
    return wearing;
    }
/*  END: METHOD:CURRENTOUTFIT   */

/*  METHOD:CANPVP   *//*
*   DEPRECATED returns a boolean of whether or not you can PvP based on the status of your hippy stone.
*/
boolean can_PVP() {
    if(hippy_stone_broken()) {
        return true;
        }
    else {
        return false;
        }
    }
/*  END: METHOD:CANPVP  */
    
/*  METHOD:COUNTFIGHTS  *//*
*   returns the number of PVP fights you have remaining.
*   if hippy stone is unbroken it returns "0".
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
/*  END: METHOD:COUNTFIGHTS */

/*  METHOD:PVPRESET  *//*
*   checks if a new season of PVP will start tomorrow
*   (thus healing all stones)
*/
boolean pvpreset() {
    string monthday = substring(today_to_string(),4);
    switch (monthday) {
        case "0228" :
        case "0229" :
        case "0430" :
        case "0630" :
        case "0831" :
        case "1031" :
        case "1231" :
            return true;
        default:
            return false;
    }
}
/*  END: METHOD:PVPRESET */