/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*
*		MayorStocker.ash
*		by Sary (#1384581)
*
*
*		for all your Hard Mode Mayor Ghost stocking needs.
*
*		v. 0.1		[15 Sept 2013]
*
*/


//Sets up quick preference checker alias "sryMSPrefs"
if (get_property("sryMSPrefsAlias") != 0){
	set_property("sryMSPrefsAlias",0);
	cli_execute("alias sryMSPrefs => ashq import <mayorstocker.ash> getMayorStockerPrefs()");
	}

void setPrefs () {
	if (get_property("sry_MS_desiredCombatItemAmount") == ""){
		set_property("sry_MS_desiredCombatItemAmount", 10);
		}

	if (get_property("sry_MS_autoBuyCombatItems") == ""){
		set_property("sry_MS_autoBuyCombatItems", false);
		}
	if (get_property("sry_MS_maxPricePerItem") == ""){
		set_property("sry_MS_maxPricePerItem", 250000);
		}
	}
	
void getMayorStockerPrefs () {
	print("'sry_MS_desiredCombatItemAmount' is '"+get_property("sry_MS_desiredCombatItemAmount")+"'");
	print("'sry_MS_autoBuyCombatItems' is '"+get_property("sry_MS_autoBuyCombatItems")+"'");
	print("'sry_MS_maxPricePerItem' is '"+get_property("sry_MS_maxPricePerItem")+"'");
	}
	
void skillsCheck(buffer skilloutput) {
	skilloutput.append("=======SKILLS=======");
	foreach mayorskill in $skills[	Inappropriate Backrub, Chronic Indigestion, Snowclone,
									Stream of Sauce, Sing, Harpoon!, Disco Dance of Doom, 
									Ravioli Shurikens, Spectral Snapper ] {
		
			if (mayorskill == $skill[Chronic Indigestion]) {
				if (have_skill(mayorskill) && have_skill($skill[Spooky Breath])) {
					skilloutput.append("<br><font color='green'>You have "+mayorskill+".</font>");
					skilloutput.append("<br><font color='green'>You have Spooky Breath.</font>");
					}
				else if (!have_skill(mayorskill) && !have_skill($skill[Spooky Breath])) {
					if (can_eat() && ((fullness_limit()-my_fullness())>=8)){
						skilloutput.append("<br>You do NOT have "+mayorskill+", but could eat a burrito to get it.");
						skilloutput.append("<br>You do NOT have Spooky Breath, but could eat a hi mein to get it.");
						}
					else if (can_eat() && ((fullness_limit()-my_fullness())>=5)) {
						skilloutput.append("<br>You do NOT have "+mayorskill+" OR Spooky Breath, but could eat a burrito or hi mein to get ONE of them.");
						}
					else if (can_eat() && ((fullness_limit()-my_fullness())>=3)) {
						skilloutput.append("<br><font color='red'>You do NOT have Spooky Breath, and are too full for a hi mein.</font>");
						skilloutput.append("<br>You do NOT have "+mayorskill+", but could eat a burrito to get it.");
						}
					else {
						skilloutput.append("<br><font color='red'>You do NOT have "+mayorskill+", and are too full for a burrito.</font>");
						skilloutput.append("<br><font color='red'>You do NOT have Spooky Breath, and are too full for a hi mein.</font>");
						}
					}
				else if (!have_skill(mayorskill) && have_skill($skill[Spooky Breath])) {
					skilloutput.append("<br><font color='green'>You have Spooky Breath.</font>");
					if (can_eat() && ((fullness_limit()-my_fullness())>=3)) {
						skilloutput.append("<br>You do NOT have "+mayorskill+", but could eat a burrito to get it.");
						}
					else {
						skilloutput.append("<br><font color='red'>You do NOT have "+mayorskill+", and are too full for a burrito.</font>");
						}
					}
				else if (have_skill(mayorskill) && !have_skill($skill[Spooky Breath])) {
					skilloutput.append("<br><font color='green'>You have "+mayorskill+".</font>");
					if (can_eat() && ((fullness_limit()-my_fullness())>=5)) {
						skilloutput.append("<br>You do NOT have Spooky Breath, but could eat a hi mein to get it.");
						}
					else {
						skilloutput.append("<br><font color='red'>You do NOT have Spooky Breath, and are too full for a hi mein.</font>");
						}
					}
				}		
		
			else if (have_skill(mayorskill)) skilloutput.append("<br><font color='green'>You have "+mayorskill+".</font>");
		
			else {
				if (mayorskill == $skill[Inappropriate Backrub]) {
					skilloutput.append("<br>You do NOT have "+mayorskill+", but you can read 'Sensual Massage for Creeps' and get it.");
					}
				else if (mayorskill == $skill[Snowclone]) {
					skilloutput.append("<br>You do NOT have "+mayorskill+", but you can read 'Blizzards I Have Died In' and get it.");
					}
				else skilloutput.append("<br><font color='red'>You do NOT have "+mayorskill+".</font>");
				}
			}
	}

void equipCheck (buffer equipoutput) {
	equipoutput.append("<br><br>=======EQUIP=======");
	foreach mayorequip in $items[ 	Choker of the Ultragoth, clown wig, plush hamsterpus,
									giant gym membership card, leotarrrd, oven mitts,
									spork, white snakeskin duster, 
									Dreadsylvania Auditor's badge ]
									{
			if (available_amount(mayorequip) > 0) {
				equipoutput.append("<br><font color='green'>You have a "+mayorequip+".</font>");
				}
			else {
				equipoutput.append("<br><font color='red'>You so NOT have a "+mayorequip+".</font>");
				}
			}
	}
	
void itemCheck(buffer itemoutput, int combatItemAmount, boolean autoBuyOn, int maxPrice) {
	itemoutput.append("<br><br>=======ITEMS=======");
	itemoutput.append("<br>You want at least "+combatItemAmount+" of each combat item.");
	foreach mayoritem in $items[	poltergeist-in-the-jar-o, brick of sand, fetid feather,
									sparking El Vibrato drone, blue plastic oyster egg,
									hot clusterbomb, tequila grenade, sharpened hubcap,
									onion shurikens, stone frisbee ] {
		//print("item: "+mayoritem+" | in bag: "+item_amount(mayoritem)+" | closet: "+closet_amount(mayoritem)+" | hangks: "+storage_amount(mayoritem),"green");
		if ((item_amount(mayoritem) < combatItemAmount) && (storage_amount(mayoritem) > 0)) {
			take_storage(combatItemAmount-item_amount(mayoritem), mayoritem);
			}
		if ((item_amount(mayoritem) < combatItemAmount) && (closet_amount(mayoritem) > 0)) {
			take_closet(combatItemAmount-item_amount(mayoritem), mayoritem);
			}
		//print("item: "+mayoritem+" | in bag: "+item_amount(mayoritem)+" | closet: "+closet_amount(mayoritem)+" | hangks: "+storage_amount(mayoritem),"green");
		if (available_amount(mayoritem) >= combatItemAmount) {
			itemoutput.append("<br><font color='green'>You have "+available_amount(mayoritem)+" "+mayoritem+". ("+item_amount(mayoritem)+" in inventory)</font>");
			}
		else if (mayoritem == $item[sharpened hubcap]){
			itemoutput.append("<br><font color='red'>You have "+available_amount(mayoritem)+" "+mayoritem+". You want at least "+(combatItemAmount-available_amount(mayoritem))+" more (from the hobo marketplace).</font>");
			}
		else if (mayoritem == $item[sparking El Vibrato drone]){
			itemoutput.append("<br><font color='red'>You have "+available_amount(mayoritem)+" "+mayoritem+". You want at least "+(combatItemAmount-available_amount(mayoritem))+" more (from El Vibrato).</font>");
			}
		else {
			if (autoBuyOn){
				int prevAmount = available_amount(mayoritem);
				int amountToBuy = combatItemAmount-available_amount(mayoritem);
				buy(amountToBuy, mayoritem, maxPrice);
				if (available_amount(mayoritem) >= combatItemAmount) {
					itemoutput.append("<br><font color='green'>You had "+prevAmount+" "+mayoritem+". We bought "+(available_amount(mayoritem)-prevAmount)+", so now you have "+available_amount(mayoritem)+".</font>");
					}
				else {
					itemoutput.append("<br><font color='red'>You had "+prevAmount+" "+mayoritem+". We bought "+(available_amount(mayoritem)-prevAmount)+", so now you have "+available_amount(mayoritem)+". (You need "+(combatItemAmount-available_amount(mayoritem))+" more.)</font>");
					}
				}
			else {
				itemoutput.append("<br><font color='red'>You have "+available_amount(mayoritem)+" "+mayoritem+". You want at least "+(combatItemAmount-available_amount(mayoritem))+" more.</font>");
				}
			}
		}
	item lovesongstat;
	if (my_primestat() == $stat[Mysticality]) lovesongstat = $item[love song of smoldering passion];
	else if (my_primestat() == $stat[Moxie]) lovesongstat = $item[love song of naughty innuendo];
	else if (my_primestat() == $stat[Muscle]) lovesongstat = $item[love song of sugary cuteness];
	
	if (available_amount(lovesongstat) >= 4*combatItemAmount) {
		itemoutput.append("<br><font color='green'>You have "+available_amount(lovesongstat)+" "+lovesongstat+".</font>");
		}
	else {
		if (autoBuyOn){
			int prevAmount = available_amount(lovesongstat);
			int amountToBuy = (4*combatItemAmount)-available_amount(lovesongstat);
			buy(amountToBuy, lovesongstat, maxPrice);
			if (available_amount(lovesongstat) >= 4*combatItemAmount) {
				itemoutput.append("<br><font color='green'>You had "+prevAmount+" "+lovesongstat+". We bought "+(available_amount(lovesongstat)-prevAmount)+", so now you have "+available_amount(lovesongstat)+".</font>");
				}
			else {
				itemoutput.append("<br><font color='red'>You had "+prevAmount+" "+lovesongstat+". We bought "+(available_amount(lovesongstat)-prevAmount)+", so now you have "+available_amount(lovesongstat)+". (You need "+((4*combatItemAmount)-available_amount(lovesongstat))+" more.)</font>");
				}
			}
		else {
			itemoutput.append("<br><font color='red'>You have "+available_amount(lovesongstat)+" "+lovesongstat+". You want at least "+((4*combatItemAmount)-available_amount(lovesongstat))+" more.</font>");
			}
		}
	}
	
void main() {
	
	buffer output;
	buffer skilloutput;
	buffer equipoutput;
	buffer itemoutput;
	setPrefs();
	
	int combatItemAmount = to_int(get_property("sry_MS_desiredCombatItemAmount"));
	boolean autoBuyOn = to_boolean(get_property("sry_MS_autoBuyCombatItems"));
	int maxPrice = to_int(get_property("sry_MS_maxPricePerItem"));
	
	skillsCheck(skilloutput);
	equipCheck(equipoutput);
	itemCheck(itemoutput, combatItemAmount, autoBuyOn, maxPrice);
	
	print_html(skilloutput);
	print_html(equipoutput);
	print_html(itemoutput);
	
	}