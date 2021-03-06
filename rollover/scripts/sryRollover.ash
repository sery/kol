/*
  Sery's Rollover Management Script v0.63x
  
  Designed to optimise rollover adventure amounts and remind you to do daily stuff. With great thanks to bumcheekcity &hippoking.
  ...who actually wrote most of it.
  
  Also, thanks to TH3Y who added some stuff.
  
  VERSION:
  0.5	- Released to the general public.
  0.55	- Fixed bug in maximiser code and wand code.  Extra checks.
  0.56	- Fixed bug in hot tub check
  0.6	- Used built-in maximizer, support for soda and new houses, few bug fixes
  0.61  - Maximize command now -tie
  0.62	- Canticle, bricko, sugar shupport.
  0.625 - check for mad hatter buff and Crimbo present (Y0U)
  0.626 - check for Lunch Break, selling bugged beanie / balaclava (Y0U)
  0.63  - better hand support
  0.63x - modified by Sary
  0.7	- Tweaked. A lot.
*/

import <srylib.ash>
import <zlib.ash>
import <Rainbow Gravitation.ash>
//import <ZapWizard.ash>
//import <ClipArt.ash>

void create_RO_Aliases(){
	if (get_property("sry_RO_Alias") < 2){
		set_property("sry_RO_Alias",2);
		cli_execute("alias rolloversim => ashq import <sryRollover.ash> rollover('sim')");
		cli_execute("alias sryROPrefs => ashq import <sryRollover.ash> getRolloverPrefs()");
		}
	if (get_property("sry_RO_Alias") == 2) {
		cli_execute("alias rollpvp => ashq import <sryRollover.ash> rollover('pvp')");
		cli_execute("alias rollover => ashq import <sryRollover.ash> rollover('adv')");
		set_property("sry_RO_Alias",3);
		}
	}

void getRolloverPrefs () {
	print("'sry_RO_autoRainbow' is '"+get_property("sry_RO_autoRainbow")+"'");
	print("'sry_RO_autoSandwich' is '"+get_property("sry_RO_autoSandwich")+"'");
	print("'sry_RO_runQuiet' is '"+get_property("sry_RO_runQuiet")+"'");
	print("'sry_RO_checkBugged' is '"+get_property("sry_RO_checkBugged")+"'");
	print("'sry_RO_checkGnome' is '"+get_property("sry_RO_checkGnome")+"'");
	print("'sry_RO_autoGnome' is '"+get_property("sry_RO_autoGnome")+"'");
	print("'sry_RO_autoGnomeOrder' is '"+get_property("sry_RO_autoGnomeOrder")+"'");
	print("'sry_RO_verbose' is '"+get_property("sry_RO_verbose")+"'");
	}

void setPrefs () {
	if (get_property("sry_RO_autoRainbow") == ""){
		set_property("sry_RO_autoRainbow", true);
		}
	if (get_property("sry_RO_autoSandwich") == ""){
		set_property("sry_RO_autoSandwich", true);
		}
	if (get_property("sry_RO_runQuiet") == ""){
		set_property("sry_RO_runQuiet", true);
		}
	if (get_property("sry_RO_checkBugged") == ""){
		set_property("sry_RO_checkBugged", true);
		}
	if (get_property("sry_RO_checkGnome") == ""){
		set_property("sry_RO_checkGnome", true);
		}
	if (get_property("sry_RO_autoGnome") == ""){
		set_property("sry_RO_autoGnome", true);
		}
	if (get_property("sry_RO_autoGnomeOrder") == ""){
		set_property("sry_RO_autoGnomeOrder", "adv,block,underwater,delevel,attack");
		}
	if (get_property("sry_RO_verbose") == ""){
		set_property("sry_RO_verbose", true);
		}
	}	

boolean valid(string query) {
    item type = to_item(query);
    return(item_amount(type)>0&&can_equip(type)||have_equipped(type));
}


/*
void main(){
	void main("none");
	}
*/

void rollover(String roPriority) {

	string finalReport = "";
	string finalHPMP = "";
	string finalSummons = "";
	string finalBuffs = "";	
	string finalEquip = "";
	string finalAdv = "";
	string finalConsume = "";
	string finalMisc = "";
	string finalPVP = "";

	string body;
	int base_adv = 40;
	int clan_adv = 0;
	int res_adv = 0;
	int fam_adv = 0;
	int camp_adv = 0;
	int skill_adv = 0;
	int outfit_adv = 0;
	int extra_adv_total = 0;
	
	//Make sure the user is logged in.
	boolean notLoggedIn = true;
	while (notLoggedIn) {
    //body is a piece of depleted grimacite gear. 
		body = visit_url("/desc_item.php?whichitem=642914247");
		if (!contains_text(body,"not available")) {
			notLoggedIn = false;
		} else {
			cli_execute("login "+my_name());
		}
	}
	
	foreach fam in $familiars[Disembodied Hand, Fancypants Scarecrow, Mad Hatrack]{
		if (familiar_equipped_equipment(fam) != $item[none]){
			familiar current_fam = my_familiar();
			use_familiar(fam);
			equip($slot[familiar],$item[none]);
			use_familiar(current_fam);
			}
		}
	foreach fam in $familiars[] {
		if ((familiar_equipped_equipment(fam) == $item[Loathing Legion Helicopter]) || (familiar_equipped_equipment(fam) == $item[solid shifting time weirdness])) {
			familiar current_fam = my_familiar();
			use_familiar(fam);
			equip($slot[familiar],$item[none]);
			use_familiar(current_fam);
			}
		}
	boolean haveCheese = false;
		if(available_amount($item[stinky cheese diaper]) == 0){
			item cheesy;
			foreach cheesy in get_related($item[stinky cheese diaper], "fold"){
				vprint(cheesy + ", " + available_amount(cheesy), 15);
 				if(available_amount(cheesy) != 0) haveCheese = true;
 				}
 			}
	
	if(haveCheese && (available_amount($item[Stinky Cheese Diaper]) == 0)) {
		if (to_boolean(get_property("sry_RO_runQuiet"))){
			if ((available_amount($item[Stinky Cheese Diaper]) == 0) && !have_equipped($item[Stinky Cheese Diaper])) {
				cli_execute("fold diaper");
				finalEquip += "Folded your stinky cheese pants.<br>";
				}
			}
		else if (user_confirm("You might have adventures coming from your cheese pants.\nDo you want to fold them?")){
			if ((item_amount($item[Stinky Cheese Diaper]) == 0) && !have_equipped($item[Stinky Cheese Diaper])) {		
				cli_execute("fold diaper");
				finalEquip += "Folded your stinky cheese pants.<br>";
				}
			}
		}
	
	boolean haveknife = false;
	if(available_amount($item[Loathing Legion moondial]) == 0){
		item llk;
		foreach llk in get_related($item[Loathing Legion moondial], "fold"){
			vprint(llk + ", " + available_amount(llk), 15);
 			if(available_amount(llk) != 0) {
 				if (item_amount(llk) + equipped_amount(llk) == 0) {
 					if (closet_amount(llk) != 0) take_closet(1, llk);
 					else if (can_interact() && (storage_amount(llk) != 0)) take_storage(1, llk);
 					}
 				haveknife = true;
 				}
 			}
 		}
	if(haveknife){
		if (to_boolean(get_property("sry_RO_runQuiet"))){
			if (available_amount($item[Loathing Legion Moondial]) == 0){
				cli_execute("fold moondial");
				finalEquip += "Folded your Loathing Legion moondial.<br>";
				}
			}
		else if (user_confirm("You might have adventures coming from your LLK.\nDo you want to fold it?")){
			cli_execute("fold moondial");
			finalEquip += "Folded your Loathing Legion moondial.<br>";
			}
		}
					
	if (!contains_text(roPriority, "sim")){
		if (!to_boolean(get_property("sry_RO_runQuiet"))) {
			if(my_mp() > my_basestat($stat[mysticality])) {
				if (!user_confirm("Changing your equipment *may* cause you to lose MP.\nDo you want to continue?")){
					abort("Burn some MP and rerun Rollover.");
					}
				}
			}
		familiar oldFam = my_familiar();
		if (contains_text(roPriority, "adv")) cli_execute("maximize adv, -tie, switch Disembodied Hand");
		else if (contains_text(roPriority, "pvp")) cli_execute("maximize fites, -tie, switch Disembodied Hand");//TKTK
		
		if (equipped_item($slot[familiar])!=$item[Time Sword]) use_familiar(oldFam);
		}
	else maximize("adv, -tie, switch hand",true);
	if ((numeric_modifier(equipped_item($slot[back]), "Adventures")<= 0) &&((available_amount($item[auxiliary backbone])>0)&&can_equip($item[auxiliary backbone]))) equip($item[auxiliary backbone]);
	
	print("Finished checking for rollover adventures.", "green");
	print("Compiling rollover tasks...", "green");
	/*
    This ends the section of the code dealing with the equipment for rollover adventures,
    and the part where the code starts becoming logical again. 
	*/
	


	if (to_boolean(get_property("_borrowedTimeUsed"))){
		base_adv -= 20;
		//finalAdv += "You're on Borrowed Time.<br>";
		}
	string rumpus = visit_url("clan_rumpus.php");
	if(can_interact()){
		if (contains_text(rumpus, "rump1_1")) clan_adv += 3;
		if (contains_text(rumpus, "rump2_3")) clan_adv += 5;
		if (contains_text(rumpus, "rump4_3")) clan_adv += 1;
		}



	
		res_adv += to_int(get_property("_resolutionAdv"));		

		fam_adv += to_int(get_property("_hareAdv"));
		fam_adv += to_int(get_property("_gibbererAdv"));

		int [item] my_camp;
		my_camp = get_campground();
		int [item] my_chat;
		my_chat = get_chateau();

		if (get_property("chateauAvailable") == "true"){
			if (my_chat contains $item[artificial skylight]) camp_adv += 3;
			}
		if (my_camp contains $item[Meat Maid]) camp_adv += 4;
		if (my_camp contains $item[Clockwork Maid]) camp_adv += 8;
		if (my_camp contains $item[pagoda plans]) camp_adv += 3;
		if (my_camp contains $item[cuckoo clock]) camp_adv += 3;
		
		if (have_skill($skill[Fashionably Late])) skill_adv += 1;
		if (have_skill($skill[The Long View])) skill_adv += 3;
		
	extra_adv_total = base_adv + clan_adv + res_adv + fam_adv + camp_adv + skill_adv;

	if (contains_text(roPriority, "sim")) outfit_adv = numeric_modifier("_spec", "Adventures");
	else  outfit_adv = numeric_modifier("Adventures");
	
	outfit_adv = outfit_adv-camp_adv-skill_adv;
	
	int advtom = outfit_adv + extra_adv_total + my_adventures();

	finalReport += "You will get " + (extra_adv_total+outfit_adv) + " adventures from rollover.<br>";
	if(advtom <= 200) finalReport +="If you log off now, you will start tomorrow with " + advtom + " adventures.<br>";
	if(advtom > 200) {
		finalReport += "If you log off now, you will start tomorrow with 200 adventures.<br>";
		int advlost = advtom-200;
		finalReport += "<font color='red'>You will lose " + advlost + " adventures at rollover. Perhaps you should burn some turns!</font><br>";
		}
	if(to_boolean(get_property("sry_RO_verbose"))){
		finalReport += "-- Current: " +my_adventures()+"<br>";
		finalReport += "-- Base: " + base_adv+"<br>";
		if(can_interact()) { finalReport += "-- Clan: " +clan_adv+"<br>"; }
		else { finalReport += "-- Clan: 0 (Hardcore/Ronin)<br>"; }
		finalReport += "-- Resolutions: " + res_adv+"<br>";
		finalReport += "-- Familiar: " +fam_adv+"<br>";
		finalReport += "-- Campground: " +camp_adv+"<br>";
		finalReport += "-- Skills: " +skill_adv+"<br>";
		finalReport += "-- Outfit: " +outfit_adv+"<br>";
		if (!contains_text(roPriority, "sim")) {
			finalReport += "----- Hat: "+ equipped_item($slot[Hat]) +" ("+to_int(numeric_modifier(equipped_item($slot[Hat]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Hat]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			finalReport += "----- Weapon: "+ equipped_item($slot[Weapon]) +" ("+to_int(numeric_modifier(equipped_item($slot[Weapon]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Weapon]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			finalReport += "----- Offhand: "+ equipped_item($slot[Off-hand]) +" ("+to_int(numeric_modifier(equipped_item($slot[Off-hand]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Off-Hand]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			finalReport += "----- Back: "+ equipped_item($slot[Back]) +" ("+to_int(numeric_modifier(equipped_item($slot[Back]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Back]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			finalReport += "----- Shirt: "+ equipped_item($slot[Shirt]) +" ("+to_int(numeric_modifier(equipped_item($slot[Shirt]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Shirt]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			finalReport += "----- Pants: "+ equipped_item($slot[Pants]) +" ("+to_int(numeric_modifier(equipped_item($slot[Pants]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Pants]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			finalReport += "----- Acc 1: "+ equipped_item($slot[Acc1]) +" ("+to_int(numeric_modifier(equipped_item($slot[Acc1]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Acc1]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			finalReport += "----- Acc 2: "+ equipped_item($slot[Acc2]) +" ("+to_int(numeric_modifier(equipped_item($slot[Acc2]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Acc2]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			finalReport += "----- Acc 3: "+ equipped_item($slot[Acc3]) +" ("+to_int(numeric_modifier(equipped_item($slot[Acc3]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Acc3]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			finalReport += "----- Familiar: "+ equipped_item($slot[Familiar]) +" ("+to_int(numeric_modifier(equipped_item($slot[Familiar]), "Adventures"))+" adv";
				if (hippy_stone_broken() && !pvpreset()) finalReport += ", "+to_int(numeric_modifier(equipped_item($slot[Familiar]), "PVP Fights"))+" pvp";
				finalReport += ")<br>";
			}
		}
	if (to_boolean(get_property("_borrowedTimeUsed"))){
		finalReport += "You're on Borrowed Time.<br>";
		}

	if (stills_available() > 0) {
		finalConsume+= "You can still upgrade "+stills_available()+" ingredients at the Still.<br>";
	}
	
	if (pulls_remaining() > 0) {
		finalMisc+="You can still pull "+pulls_remaining()+" items from Hagnk's today.<br>";
	}
// PVP
if (pvpreset()) {
	finalPVP += "A new PVP season starts tomorrow, and your hippy stone will be automatically fixed.<br>";
	if (hippy_stone_broken() && (pvp_attacks_left() >0)) {
		finalPVP += "<font color='red'>You will lose " + pvp_attacks_left() + " fights at rollover. Perhaps you should burn some fights!</font><br>";
		}
	else if (!hippy_stone_broken()) {
		finalPVP += "You might want to break your stone to get some (relatively) risk free fites!<br>";
		}
	if ((get_property("_fireStartingKitUsed") == "false") && (available_amount($item[CSA fire-starting kit]) > 0)) {
		finalPVP += "You can still get PVP fights from a fire-starting kit today";
		}
	}

else {
	if(hippy_stone_broken() && !pvpreset()){

		int base_pvp = 10;
		int clan_pvp = 0;
		int camp_pvp = 0;
		int skill_pvp = 0;
		int outfit_pvp = 0;
		int extra_pvp_total = 0;
					
		string rumpus = visit_url("clan_rumpus.php");
		if (contains_text(rumpus, "rump1_3")) clan_pvp += 3;
		if (contains_text(rumpus, "rump2_2")) clan_pvp += 5;
		if (contains_text(rumpus, "rump5_1")) clan_pvp += 1;
		

		int [item] my_camp;
		my_camp = get_campground();
		if (my_camp contains $item[tin roof (rusted)]) camp_pvp += 5;
		int [item] my_chat;
		my_chat = get_chateau();

		if (get_property("chateauAvailable") == "true"){
			if (my_chat contains $item[antler chandelier]) camp_pvp += 3;
			}
		
		if (have_skill($skill[Chip on your Shoulder])) skill_pvp += 5;
		
		extra_pvp_total = base_pvp + clan_pvp + camp_pvp + skill_pvp;

		if (contains_text(roPriority, "sim")) outfit_adv = numeric_modifier("_spec", "PvP Fights");
		else  outfit_pvp = numeric_modifier("PvP Fights");
	
		outfit_pvp = outfit_pvp-camp_pvp-skill_pvp;
	
		int pvptom = outfit_pvp + extra_pvp_total + pvp_attacks_left();

		finalPVP += "You will get " + (extra_pvp_total+outfit_pvp) + " PVP fights from rollover.<br>";
		if(pvptom <= 100) finalPVP +="If you log off now, you will start tomorrow with " + pvptom + " PVP fights.<br>";
		if(pvptom > 100) {
			finalPVP += "If you log off now, you will start tomorrow with 100 PVP fights.<br>";
			int pvplost = pvptom-100;
			finalPVP += "<font color='red'>You will lose " + pvplost + " fights at rollover. Perhaps you should burn some fights!</font><br>";
			}
		if ((get_property("_fireStartingKitUsed") == "false") && (available_amount($item[CSA fire-starting kit]) > 0)) {
			finalPVP += "You can still get PVP fights from a fire-starting kit today";
			}
	/*	if(to_boolean(get_property("sry_RO_verbose"))) {
	*		finalPVP += "-- Current: " +pvp_attacks_left()+"<br>";
	*		finalPVP += "-- Base: " + base_pvp+"<br>";
	*		finalPVP += "-- Clan: " +clan_pvp+"<br>"; 
	*		finalPVP += "-- Campground: " +camp_pvp+"<br>";
	*		finalPVP += "-- Skills: " +skill_pvp+"<br>";
	*		finalPVP += "-- Outfit: " +outfit_pvp+"<br>";
	*		}
	*/
		}
	}
// Skills
	/*body = visit_url("/skills.php");
	int start = index_of(body,"select a skill");
	string skills = substring(body,start,index_of(body,"</select>",start));
	int startbuff = index_of(body,"select a buff");
	if(startbuff > -1){
		string buffs = substring(body,startbuff,index_of(body,"</select>",startbuff));
		body = skills+buffs;
		}
	else body = skills;
	string [int] casting = split_string(body, "><");
	*/
				
/*	foreach X in casting {
		if (contains_text(casting[X],"MP")) {
			string skillName = substring(casting[X],index_of(casting[X],">")+1,index_of(casting[X]," ("));
			string skillCost = substring(casting[X],index_of(casting[X]," (")+2,index_of(casting[X],")"));
			string libramCost = substring(skillCost,0,index_of(skillCost," "));
*/
/*		if(((in_bad_moon() || (can_interact()&&((my_path()!="Avatar of Boris") && (my_path()!="Zombie Slayer")) && (
					(contains_text(skillName, "Stickers") && (to_int(get_property("tomeSummons")) <3 ))
				||	(contains_text(skillName, "Snowcone") && (to_int(get_property("tomeSummons")) <3 ))
				||	(contains_text(skillName, "Sugar") && (to_int(get_property("tomeSummons")) <3 ))
				||	(contains_text(skillName, "Smithsness") && (to_int(get_property("tomeSummons")) <3 ))
				||	(contains_text(skillName, "Clip Art") && (to_int(get_property("tomeSummons")) <3 )))))){
					print("You can still cast "+skillName+" today.");
					if (autoClipArt) {
						print("Summoning Clip Art automagically!");
						
						finalSummons += "Created Clip Art automagically. You may want to mall the results.<br>";
						clip_mall();
						}
					else if (!autoClipArt){
						int summonsLeft = 3 - to_int(get_property("tomeSummons"));
						finalSummons += "You can still summon " + summonsLeft + "tome items today.<br>";
						}
					} */
					
//Mr. Skills					
					
//Tome Summons
//In-ronin/hardcore
	if((!can_interact() && (to_int(get_property("tomeSummons")) < 3 )) &&
		(have_skill($skill[Summon Snowcones]) ||
		(have_skill($skill[Summon Stickers]) ||
		(have_skill($skill[Summon Sugar Sheets]) ||
		(have_skill($skill[Summon Clip Art]) ||
		(have_skill($skill[Summon Rad Libs]) ||
		(have_skill($skill[Summon Smithsness])))))))) {
					int summonsLeft = 3 - to_int(get_property("tomeSummons"));
					finalSummons += "You can still summon " + summonsLeft + " tome items today.<br>";
					}
					
//No restrictions					
	if(can_interact()){
		if (have_skill($skill[Summon Snowcones]) && (to_int(get_property("_snowconeSummons")) < 3 )){
			int snowconesLeft = 3 - to_int(get_property("_snowconeSummons"));
			if (snowconesLeft > 1) finalSummons += "You can still summon " + snowconesLeft + " snowcones today.<br>";
			else finalSummons += "You can still summon " + snowconesLeft + " snowcone today.<br>";
			}
		if (have_skill($skill[Summon Stickers]) && (to_int(get_property("_stickerSummons")) < 3 )){
			int stickersLeft = 3 - to_int(get_property("_stickerSummons"));
			if (stickersLeft > 1) finalSummons += "You can still summon " + stickersLeft + " stickers today.<br>";
			else finalSummons += "You can still summon " + stickersLeft + " sticker today.<br>";
			}
		if (have_skill($skill[Summon Sugar Sheets]) && (to_int(get_property("_sugarSummons")) < 3 )){
			int sugarsLeft = 3 - to_int(get_property("_sugarSummons"));
			if (sugarsLeft > 1) finalSummons += "You can still summon " + sugarsLeft + " sugar sheets today.<br>";
			else finalSummons += "You can still summon " + sugarsLeft + " sugar sheet today.<br>";
			}
		if (have_skill($skill[Summon Clip Art]) && (to_int(get_property("_clipartSummons")) < 3 )){
			int clipartLeft = 3 - to_int(get_property("_clipartSummons"));
			if (clipartLeft > 1) finalSummons += "You can still summon " + clipartLeft + " pieces of clip art today.<br>";
			else finalSummons += "You can still summon " + clipartLeft + " piece of clip art today.<br>";
			}
		if (have_skill($skill[Summon Rad Libs]) && (to_int(get_property("_radlibSummons")) < 3 )){
			int radlibsLeft = 3 - to_int(get_property("_radlibSummons"));
			if (radlibsLeft > 1) finalSummons += "You can still summon " + radlibsLeft + " Rad Libs today.<br>";
			else finalSummons += "You can still summon " + radlibsLeft + " Rad Libs today.<br>";
			}
		if (have_skill($skill[Summon Smithsness]) && (to_int(get_property("_smithsnessSummons")) < 3 )){
			int smithsnessLeft = 3 - to_int(get_property("_smithsnessSummons"));
			if (smithsnessLeft > 1) finalSummons += "You can still summon " + smithsnessLeft + " Smithsness today.<br>";
			else finalSummons += "You can still summon " + smithsnessLeft + " Smithsness today.<br>";
			}
		}
				
//Grimoire Summons			
	if (have_skill($skill[Summon Hilarious Objects])	&& (to_int(get_property("grimoire1Summons")) < 1 )){
		finalSummons += "You can still summon hilarious objects today.<br>";
		}
	if (have_skill($skill[Summon Tasteful Items])	&& (to_int(get_property("grimoire2Summons")) < 1 )){
		finalSummons += "You can still summon tasteful items today.<br>";
		}
	if (have_skill($skill[Summon Alice's Army Cards])	&& (to_int(get_property("grimoire3Summons")) < 1 )){
		finalSummons += "You can still summon Alice's Army cards today.<br>";
		}
	if (have_skill($skill[Summon Geeky Gifts])	&& (to_int(get_property("_grimoireGeekySummons")) < 1 )){
		finalSummons += "You can still summon geeky gifts today.<br>";
		}

//Libram Items
	if 	(my_mp() >= to_int(mp_cost($skill[Summon Love Song])) && 
		(have_skill($skill[Summon Candy Heart])	||
		(have_skill($skill[Summon Party Favor])	||
		(have_skill($skill[Summon Love Song])	||
		(have_skill($skill[Summon BRICKOs])		||
		(have_skill($skill[Summon Dice])		||
		(have_skill($skill[Summon Resolutions])	||
		(have_skill($skill[Summon Taffy])	)))))))) {
			finalSummons+="You can summon a Libram item for "+mp_cost($skill[Summon Love Song])+" MP.<br>";
			}
//End Mr. Skills
					
//Class Summons
//Summon Limit Checking
	if (have_skill($skill[Advanced Saucecrafting])	&& (to_int(get_property("reagentSummons")) < 1)){
		finalSummons += "You can still summon reagents today.<br>";
		}
	if (have_skill($skill[Advanced Cocktailcrafting]) && (to_int(get_property("cocktailSummons")) < 1)){
		finalSummons += "You can still summon cocktailcrafting garnishes today.<br>";
		}
	if (have_skill($skill[Pastamastery]) && (to_int(get_property("noodleSummons")) < 1)){
		finalSummons += "You can still summon dry noodles today.<br>";
		}

//Challenge Path Summons
	if (have_skill($skill[Demand Sandwich]) && (to_int(get_property("_demandSandwich")) < 3 )){
		finalSummons += "You can still demand sandwiches today.<br>";
		}
	if (have_skill($skill[Incite Riot]) && !(to_boolean(get_property("_peteRiotIncited")))) {
		finalSummons += "You can still incite a riot today.<br>";
		}
	if (have_skill($skill[Throw Party]) && !(to_boolean(get_property("_petePartyThrown")))) {
		finalSummons += "You can still throw a party today.<br>";
		}

//Other Summons
			
	if (have_skill($skill[Summon Crimbo Candy]) && (to_int(get_property("_candySummons")) < 1 )){
		finalSummons += "You can still summon Crimbo candy today.<br>";
		}
	if (have_skill($skill[Request Sandwich]) && (to_string(get_property("_requestSandwichSucceeded")) != "true")){
		if (can_interact() && to_boolean(get_property("sry_RO_autoSandwich"))){
			while (to_string(get_property("_requestSandwichSucceeded")) != "true"){
				cli_execute("cast request sandwich");
				}
			finalSummons += "Requested a sandwich automagically.<br>";
			}
		else finalSummons += "You can still request a sandwich today.<br>";
		}
	if (have_skill($skill[Lunch Break]) && !(to_boolean(get_property("_lunchBreak")))){
		finalSummons += "You can still take a lunch break today.<br>";
		}
	if (have_skill($skill[Rainbow Gravitation]) && (to_int(get_property("prismaticSummons")) < 3 )){
		if(can_interact()){
			if(to_boolean(get_property("sry_RO_autoRainbow"))){
				finalSummons += "Created prismatic wads automagically.<br>";
				print("Creating prismatic wads automagically!");
				rainbow();
					}
			else if (!to_boolean(get_property("sry_RO_autoRainbow"))){
					int prismsLeft = 3 - to_int(get_property("prismaticSummons"));
					finalSummons += "You can still summon " + prismsLeft + " prismatic wads today.<br>";
					}
			}
		else {
			int prismsLeft = 3 - to_int(get_property("prismaticSummons"));
			finalSummons += "You can still summon " + prismsLeft + " prismatic wads today. (Available: "+
				"<font color='blue'>"+available_amount($item[Cold Wad])+"</font>|"+
				"<font color='red'>"+available_amount($item[Hot Wad])+"</font>|"+
				"<font color='#8A2BE2'>"+available_amount($item[Sleaze Wad])+"</font>|"+
				"<font color='gray'>"+available_amount($item[Spooky Wad])+"</font>|"+
				"<font color='green'>"+available_amount($item[Stench Wad])+"</font>|"+
				available_amount($item[Twinkly Wad])+")<br>";
			}
		}
	if (get_property("chateauAvailable") == "true"){
		if (!to_boolean(get_property("_chateauDeskHarvested"))) {
			finalSummons += "You can still harvest your Chateau desk today.<br>";
		}
	}
	string camptree = visit_url("/campground.php");
	if (!contains_text(camptree,"teatree_used.gif")) {
		finalSummons += "You can still harvest your tea tree today.<br>";
	}
	
//Swagger related things
	buffer skillbody = visit_url("/skills.php");
	matcher summonAnnoyMatch = create_matcher("<option value=107>Summon Annoyance \\(([0-9]+) swagger\\)</option>", skillbody);
	while (summonAnnoyMatch.find()) {
		finalSummons +=  "You can still Summon Annoyances for "+summonAnnoyMatch.group(1)+" swagger today.<br>";
		}

//Misc.
	
	if (have_skill($skill[Canticle of Carboloading]) && !(to_boolean(get_property("_carboLoaded")))){
		finalBuffs += "You can still cast Canticle of Carboloading today.<br>";}					
	
	if (my_inebriety() < inebriety_limit()) {
		finalConsume+="You're not drunk yet.<br>";
	}	
	else if ((my_inebriety() <= inebriety_limit()) && (inebriety_limit() > 0)) {
		finalConsume+="You're not over-drunk yet.<br>";
	}
	if (my_fullness() < fullness_limit()) {
		finalConsume+="You're not full yet.<br>";
	}
	if (my_spleen_use() < spleen_limit() ) {
		finalConsume+="Your spleen could take more of a kicking.<br>";
	}
	
	//Styx Pixie Buff
	if (in_bad_moon()) {
		body = visit_url("/heydeze.php?place=styx");
		if(!contains_text(body, "already sampled")){
			finalBuffs +="You haven't used your styx pixie buff today.<br>";
		}
	}
	
	//We have to check that the war is done, or else it complains about the blank response from
	//postwarisland.php. Thanks, Jick.
	body = visit_url("questlog.php?which=2");
	
	if(contains_text(body,"Make War")) {
		body = visit_url("/postwarisland.php?place=nunnery");
		if(contains_text(body, "allow us")) {
			finalHPMP += "The nuns still have some favours to bestow upon you.<br>";
		}
		
		body = visit_url("/postwarisland.php?place=concert");
		if(contains_text(body,"roll up to the amphitheater")&&!contains_text(body,"tapped out")) {
			finalBuffs += "You haven't used your arena buff.<br>";
		}
	}

	body = visit_url("/friars.php?bro=2");
	if(contains_text(body,"like a blessing")) {	
		finalBuffs += "You haven't used your Friar reward yet.<br>";
	}
	
	//Hermit clovers
	body = visit_url("/hermit.php");
	
	if(contains_text(body,"left in stock")) {
		finalMisc += "You can still get hermit clovers today.<br>";
	}
	
	body = visit_url("/campground.php");
	
	//Check if telescope buff has been used
	if(contains_text(body,"telescope")&&!to_boolean(get_property("telescopeLookedHigh"))) {
		finalBuffs += "You can still use your telescope buff today.<br>";
	}
	
	if(contains_text(body,"_free.gif")) {
		finalHPMP += "You haven't used your free rests.<br>";
	}
	
	//Check not wasting rollover MP
	int rollMP;
	int ind = index_of(body,"campground/rest")+15;
	int house;
	if ((substring(body,ind,ind+1) == "a") || (substring(body,ind,ind+1) == "b")) {
		house = 10;
	}
	else {
		house = to_int(substring(body,ind,ind+1));
	}
	if (item_amount(to_item("Instant House"))>0&&house<4) {
		finalHPMP += "You forgot to use your instant house.<br>";
	}
	
	if (house == 0) {
		finalHPMP += "You will get no rollover MP without a house - buy a tent.<br>";
	}
	else {
		rollMP = house*10;
		if (house == 7) {
			rollMP = 85;
		} else if (house == 8) {
			rollMP = 70;
			}
		else if (house == 9) {
			rollMP = 35;
		}
		if (contains_text(body,"bartender.gif")) {
			rollMP = rollMP+15;
			}
		
		if ((my_mp()+rollMP>my_maxmp()) && (my_path()!="Zombie Slayer")) {
			finalHPMP += "Some of your rollover MP will be wasted.<br>";
			}
		}
	

	
	// Check if zap wand is cold
	body = visit_url("inventory.php?which=3");
	ind = index_of(body,"wand.php");
	if(ind>=0) {
    debug("You have a wand.");
		string url = substring(body,ind,index_of(body,'"',ind));
		debug(url);
		body = visit_url(url);
		if(!contains_text(body,"warm to the touch")&&!contains_text(body,"be careful")) {
			//if(autoZapper){
			//	print("You have decided to zap things automagically. Doing that now.");
			//	finalMisc += "Zapped something automagically. You may want to mall the results.<br>";
			//	autozapping();
			//	}
			//	else if(!autoZapper)
			finalMisc += "Your wand is cold. You should zap something.<br>";
		  
		} else {
			debug("You've used your wand at least once today.");
		}
	}
	else {
    	debug("You don't have a wand at all.");
		}
	
	// Check burrowgrub consumptions used
	//if (to_int(get_property("burrowgrubSummonsRemaining"))>0) {
	//	print("You can still consume burrowgrubs today");
	//}
	
	// Check if the day's demon summon has been used
	if (!to_boolean(get_property("demonSummoned")) && can_interact()) {
		body = visit_url("manor3.php");
		ind = index_of(body,"title=\"Summoning Chamber\"");
		if(ind>=0) {
			finalBuffs+= "You can still summon a demon today.<br>";
		}
	}
	
	// Check if the Legendary Beat can still be used today
	if (!to_boolean(get_property("_legendaryBeat")) && (available_amount($item[The Legendary Beat]) > 0)){
		finalBuffs += "You can still use the Legendary Beat today.<br>";
	}
	
	// Check if the ball pit can still be used today
	if (can_interact()&&!to_boolean(get_property("_ballpit"))) {

		finalBuffs += "You can still jump in the ball pit today.<br>";
	}
	
	if((item_amount($item[Clan VIP Lounge key])>0)&&(!in_bad_moon()||can_interact())) {
		// Check if the hot tub can still be used today
		if (to_int(get_property("_hotTubSoaks"))<5) {
			finalHPMP += "You can still relax in the hot tub today.<br>";
		}
			
		//Check pool table has been used for the day.
	if (is_unrestricted("Pool Table")) {
			if(to_int(get_property("_poolGames")) < 3) {
				finalBuffs += "You can still play pool today.<br>";
		}}
		
		// Check if the shower can still be used today
		if (is_unrestricted("April Shower")) {
			if (!to_boolean(get_property("_aprilShower"))) {
				finalBuffs += "You can still take a shower today.<br>";
		}}
		
		// Check if the swimming pool can still be used today
		if (is_unrestricted("Clan Swimming Pool")){
			if (!to_boolean(get_property("_olympicSwimmingPool"))) {
				finalBuffs += "You can still swim laps or sprints today.<br>";
		}}

		// Check if the mad hatter buff can still be used today
		if (get_property("_lookingGlass")==true&&get_property("_madTeaParty")==false) {
			finalBuffs += "You can still visit the mad hatter today. Use the 'hatter' command to see which buffs are available.<br>";
		}
		
		//Outdated?
		// Check if there is a Crimbo Tree present available
		//if (get_property("_crimboTree")==true&&to_int(get_property("crimboTreeDays"))==0) {
		//	finalMisc += "You have a present available under the Crimbo Tree.<br>";
		//}
	
		// Check if you can still fight a fax today
		if (!to_boolean(get_property("_photocopyUsed"))) {
			//if ((my_path() != "Avatar of Jarlsberg") &&
			//	((my_path() != "Avatar of Boris") &&
			//	(my_path() != "Trendy"))){
			if (is_unrestricted("deluxe fax machine"))
				finalMisc += "You can still fight a photocopied monster today.<br>";
				}
		
	
	} else print("You don't have access to the VIP lounge.", "gray");

		if (get_property("chateauAvailable") == "true"){
			if (!to_boolean(get_property("_chateauMonsterFought"))) {

			if (get_property("chateauMonster") != "")finalMisc += "You can still fight your Chateau painting today.<br>";
		}
	}

	int [item] myshed; myshed = get_campground(); 
	if (myshed contains $item[portable Mayo Clinic]) {
		if (!to_boolean(get_property("_mayoTankSoaked"))) finalMisc += "You can still soak in your Mayo tank today.<br>";
		} 
	if (myshed contains $item[Little Geneticist DNA-Splicing Lab]) {
		if (to_int(get_property("_dnaPotionsMade"))!=3) {
			int tonicsLeft = 3 - to_int(get_property("_dnaPotionsMade"));
			finalMisc += "You can still make " + tonicsLeft + " gene tonics today.<br>";
			} 
		if (!to_boolean(get_property("_dnaHybrid"))) finalMisc += "You can still hybridize yourself today.<br>";

	}
	if (available_amount(to_item("neverending soda"))>0 &&get_property("oscusSodaUsed")==false) {
		finalHPMP += "You can still drink Oscus's Soda today.<br>";
	}
	
    
    /*if(to_boolean(get_property("sry_RO_checkBugged"))){
     *   if (item_amount(to_item("bugged balaclava"))>0 ) {
      *      print("You could sell your bugged balaclava today (and get another tomorrow).");
       * }

       * if (item_amount(to_item("bugged beanie"))>0 ) {
        *    print("You could sell your bugged beanie today (and get another tomorrow).");
      *  }
    }*/

    if(to_boolean(get_property("sry_RO_checkBugged"))){
    	if (have_familiar($familiar[Baby Bugged Bugbear])) {
    		if (get_property("_gotBuggedBeanie")!=1) {
	
    			familiar current_fam = my_familiar();
    			if (my_familiar() != $familiar[Baby Bugged Bugbear]) use_familiar($familiar[Baby Bugged Bugbear]);
				equip( $slot[familiar], $item[none] );
						
				int closet_beanies = closet_amount($item[bugged beanie]);
		   		int closet_bala = closet_amount($item[bugged balaclava]);
    			int inv_beanies = item_amount($item[bugged beanie]);
    			int inv_bala = item_amount($item[bugged balaclava]);
    			int sum_buggedhats = closet_amount($item[bugged beanie])+closet_amount($item[bugged balaclava])+item_amount($item[bugged beanie])+item_amount($item[bugged balaclava]);

    			//If you're out of Ronin/HC OR you lack any bugged hats...
    			if(can_interact() || (sum_buggedhats==0) ) {
    				//unclosets any bugged beanies and balaclavas, and shoves all you have into your dc
    				if (can_interact()){
    					take_closet(closet_amount($item[bugged beanie]),$item[bugged beanie]);
    					take_closet(closet_amount($item[bugged balaclava]),$item[bugged balaclava]);
    					put_display(inv_beanies+closet_beanies, $item[bugged beanie]);
    					put_display(inv_bala+closet_bala,$item[bugged balaclava]);
    					}
    				//visits the arena, if you get the bugged beanie today, set _gotBuggedBeanie so we don't need to check again if you rerun.
    				string arenastring = visit_url("arena.php");
    				if (contains_text(arenastring, "Congratulations on your %arenawins arena win.")) {
    					set_property("_gotBuggedBeanie", 1);
						finalMisc += "Got a bugged beanie.<br>";
						}
					else finalMisc += "Tried to get a bugged beanie, but failed. Maybe you already got one today?<br>";
					
					//undisplays your balas and beanies, closeting as appropriate.
					if(can_interact()){
						take_display(inv_beanies+closet_beanies, $item[bugged beanie]);
    					take_display(inv_bala+closet_bala,$item[bugged balaclava]);
    					put_closet(closet_amount($item[bugged beanie]),$item[bugged beanie]);
    					put_closet(closet_amount($item[bugged balaclava]),$item[bugged balaclava]);
						}
					use_familiar(current_fam);
    				
    				}

    			else if (!can_interact() && (sum_buggedhats!=0)) {
    				finalMisc += "I wanted to get you a bugged beanie, but you're in hardcore/ronin and already have one (or a balaclava) in your inventory or closet.<br>";
    				finalMisc += "If you want me to get one, you should either autosell the ones you have, or put them in your store or display case.<br>";
    				}
				}
    		}
    	}
    
    if(to_boolean(get_property("sry_RO_checkGnome"))) {
    	if (have_familiar($familiar[Reagnimated Gnome])) {
    		if (get_property("_gotGnomeEquip") !=1) {
    			if (!to_boolean(get_property("sry_RO_autoGnome"))) finalMisc += "You might be able to get some equipment for your Reagnimated Gnome at the Arena.<br>";
    			else {
    				string old597val = get_property("choiceAdventure597");
    				item [int] gnomeOrderAmt;
    				item itemPicked;
    				string [int] gnomeOrder = split_string(get_property("sry_RO_autoGnomeOrder"),",");
    				foreach x,gequip in gnomeOrder {
    					if (gequip == "attack") gnomeOrderAmt[x] = $item[gnomish tennis elbow];
						if (gequip == "underwater") gnomeOrderAmt[x]=$item[gnomish swimmer's ears];
    					if (gequip == "block") gnomeOrderAmt[x]=$item[gnomish coal miner's lung];
    					if (gequip == "delevel") gnomeOrderAmt[x]=$item[gnomish athlete's foot];
    					if (gequip == "adv") gnomeOrderAmt[x]=$item[gnomish housemaid's kgnee];
    					}
    				foreach o,i  in gnomeOrderAmt {
    					if ((available_amount(i) == 0) && (itemPicked == $item[none])) itemPicked = i;
						}

					switch (itemPicked) {
						case $item[gnomish tennis elbow]:
							set_property("choiceAdventure597","3");
							break;
						case $item[gnomish swimmer's ears]:
							set_property("choiceAdventure597","1");
							break;
    					case $item[gnomish coal miner's lung]:
    						set_property("choiceAdventure597","2");
    						break;
    					case $item[gnomish athlete's foot]:
    						set_property("choiceAdventure597","5");
    						break;
    					case $item[gnomish housemaid's kgnee]:
    						set_property("choiceAdventure597","4");
    						break;
						default:
							set_property("choiceAdventure597","4");
						}
    				
    				familiar current_fam = my_familiar();
    				if (my_familiar() != $familiar[Reagnimated Gnome]) use_familiar($familiar[Reagnimated Gnome]);
					
					string arenastring = visit_url("arena.php");
					if (contains_text(arenastring,"Susie is probably still mad at your little Gnome buddy"))set_property("_gotGnomeEquip",1);
					else {
						visit_url("choice.php?pwd&whichchoice=597&option="+get_property("choiceAdventure597"));
						finalMisc += "Outfitted your Reagnimated Gnome with a "+itemPicked+".<br>";
						set_property("_gotGnomeEquip",1);
    					}
    				use_familiar(current_fam);
    				set_property("choiceAdventure597",old597val);
					}
				}
			}
		}
    

	// Visit the BHH to redeem any completed bounties
	body = visit_url("/bhh.php");
	
	print("");
	print_html("<font color='blue'>			<center>=============== ROLLOVER REPORT ===============</center></font><br>");
	print_html("							<center>================= adventures ==================</center><br>");
	if (length(finalReport)>0) print_html(finalReport);
	//if (length(finalAdv)>5) print_html(finalAdv);
	if (length(finalPVP)>0) print_html("	<center>==================== pvp ======================</center><br>");
	if (length(finalPVP)>0) print_html(finalPVP);
	if (length(finalEquip)>0) print_html("	<center>================= equipment ===================</center><br>");
	if (length(finalEquip)>0) print_html(finalEquip);
	if (length(finalConsume)>0) print_html("<center>================ consumption ==================</center><br>");
	if (length(finalConsume)>0) print_html(finalConsume);
	if (length(finalHPMP)>0) print_html("	<center>=================== hp/mp =====================</center><br>");
	if (length(finalHPMP)>0) print_html(finalHPMP);
	if (length(finalBuffs)>0) print_html("	<center>==================== buffs ====================</center><br>");
	if (length(finalBuffs)>0) print_html(finalBuffs);
	if (length(finalSummons)>0) print_html("<center>=================== summons ===================</center><br>");
	if (length(finalSummons)>0) print_html(finalSummons);
	if (length(finalMisc)>0) print_html("	<center>================ miscellaneous ================</center><br>");
	if (length(finalMisc)>0) print_html(finalMisc);
	if (get_property("sry_RO_Alias") < 3) print_html("<font color='red'>Your aliases may be out of date. <br>Run sryRollover.ash to fix this.</font><br>");
	print("");
	print("Rollover checking complete.", "green");
}

void main() {
	create_RO_Aliases();
	setPrefs();
	print("Rollover setup complete. Use the aliases 'rollover','rollpvp' or 'rolloversim' to prep for rollover, or 'sryROPrefs' to check settings.","blue");
	}