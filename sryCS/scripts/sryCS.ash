//CS3.ash

boolean isdone(int s)
{
    buffer c = visit_url("council.php");
    return (~contains_text(c, "option value=" + s));
}

void doservice(int s)
{
	print(my_adventures() + " adv, performing service");
    visit_url("council.php"); // Required?
    buffer b = visit_url("choice.php?whichchoice=1089&option="+s+"&pwd");
    if (~isdone(s)) {
	matcher m = create_matcher("guts'\\>(.+?)\\<", b);
	if (find(m)) {
	    print(group(m, 1));
	}
        abort("Failed to do service!");
    }
    print("Test " + s + " done.", "green");
    print(my_adventures() + " adv left");
}

int scriptstage;

void obtain(effect e)
{
    if (have_effect(e) == 0) {
        if (contains_text(e.default, "cast 1 ")) {
	    string s = substring(e.default, 7);
	    if (!have_skill(s.to_skill())) {
		print("Missing " + s.to_skill(), "red");
	        return;
	    }
	}
	cli_execute(e.default);
    }
}

familiar non100()
{
    buffer page = visit_url("ascensionhistory.php?back=self&who="+my_id());
    page = append(page, visit_url("ascensionhistory.php?who="+my_id()+"&prens13=1&back=self"));
    foreach fam in $familiars[] {
        if (have_familiar(fam)) {
	    if (contains_text(page, fam + " (100%)")) {
	        print(fam + " has 100%");
	    } else {
		if (fam != $familiar[black cat] && fam != $familiar[O.A.F.]) {
		    return fam ;
		}
	    }
	}
    }
    foreach fam in $familiars[Galloping Grill, Unconscious Collective, Grim Brother, Golden Monkey, Puck Man, Ms. Puck Man, Mosquito] {
	if (have_familiar(fam)) {
	    return fam;
	}
    }
    return $familiar[none];
}

void main()
{
	string body;
	if (turns_played()==0) scriptstage = 0;
    if (can_interact()) {
	foreach i in ($items[Buddy Bjorn, Glass of goat's milk, Ice Island Long Tea, Mojo filter, Pressurized potion of perspicacity, Pressurized potion of puissance, Red foxglove, SPF 451 lip balm, Super weight-gain 9000, Worst candy]) {
	    retrieve_item(1, i);
	}
	//'
	retrieve_item(25, $item[sleaze wad]);
	if (~(get_campground() contains $item[portable Mayo Clinic])) {
	    if ((~get_property("_workshedItemUsed").to_boolean()) && (item_amount($item[portable Mayo Clinic]) > 0)) {
		use(1, $item[portable Mayo Clinic]);
	    } else {
			abort("This script requires a Mayo Clinic installed.");
	    }
	}

	if (~get_property("chateauAvailable").to_boolean()) {
	    abort("This script requires a chateau.");
	} else {
	    foreach chat in $items[foreign language tapes, ceiling fan, continental juice bar] {
			if (~(get_chateau() contains chat)) {
		    	boolean tmp = buy(1, chat);
			}
	    }
	    if (get_property("chateauMonster") != "cowskeleton") {
			abort("This script requires a cowskeleton in your chateau painting.");
	    }
	}

	if (item_amount($item[packet of winter seeds]) > 0) {
	    use(1, $item[packet of winter seeds]);
	}

	foreach s in $skills[Advanced Saucecrafting, Disco Fever, Rage of the Reindeer,  Amphibian Sympathy, Disco Smirk, Reptilian Fortitude, Arched Eyebrow of the Archmage, Elemental Saucesphere, Sauce Contemplation, Asbestos Heart, Empathy of the Newt, Saucestorm, Tenacity of the Snapper, Astral Shell, Fat Leon's Phat Loot Lyric, Scarysauce, The Magical Mojomuscular Melody, Bind Penne Dreadful, Jackasses' Symphony of Destruction, Scowl of the Auk, The Moxious Madrigal, Bind Spice Ghost, Leash of Linguini, Seal Clubbing Frenzy, The Sonata of Sneakiness, Bind Undead Elbow Macaroni, Manicotti Meditation, Simmer, Tolerance of the Kitchen, Blessing of She-Who-Was, Moxie of the Mariachi, Singer's Faithful Ocelot, Blessing of the War Snapper, Patience of the Tortoise, Smooth Movement, Disco Aerobics, The Power Ballad of the Arrowsmith, Stevedave's Shanty of Superiority, Blubber Up, Song of Starch, The Ode to Booze] {
	    if (~have_skill(s)) {
		print("Missing: " + s, "red");
	    }
	}

	if (get_property("lovebugsUnlocked") != true) {
	    // print("Missing: lovebugs", "red");
	}

	print("Ascend Sauce");
	print("Astral Energy Drinks and Statuette");
	print("Wallaby");

	print("You are about to step into a Normal incarnation, and be born under the The Wallaby Moon Sign as a Sauceror.");
	print("You have chosen the Community Service Path.");
	print("You selected a carton of astral energy drinks from the Deli Lama.");
	print("You selected an astral statuette from Pet Heaven.");
    } 

//DAY 1 START

    else if (my_daycount() == 1) {
  
	visit_url("council.php");  // Get the introduction out of the way!

	if (pvp_attacks_left() == 0) {
		print("Smashing stone");
	    visit_url("campground.php?smashstone=Yep.&pwd&confirm=on&shatter=Smash+that+Hippy+Crap%21");
	    visit_url("peevpee.php?action=pledge&place=fight&pwd");

	}
	
	if (item_amount($item[Newbiesport&trade; tent]) > 0) {
	    use(1, $item[Newbiesport&trade; tent]);
	}
	if (item_amount($item[carton of astral energy drinks]) > 0) {
	    use(1, $item[carton of astral energy drinks]);
	}
	if (get_property("questM05Toot") == "started") {
	    visit_url("tutorial.php?action=toot");
	}
	if (item_amount($item[letter from King Ralph XI]) > 0) {
	    use(1, $item[letter from King Ralph XI]);
	}
	if (item_amount($item[pork elf goodies sack]) > 0) {
	    use(1, $item[pork elf goodies sack]);
	}
	foreach stone in $items[baconstone, porquoise, hamethyst] {
	    autosell(item_amount(stone), stone);
	}

	if (turns_played()==0 && my_adventures()==40){
		if (pulls_remaining() == 5 && item_amount($item[buddy bjorn]) < 1 && equipped_amount($item[buddy bjorn])<1){
			take_storage(1, $item[buddy bjorn]);	
			}
		if (pulls_remaining() == 4 && item_amount($item[mojo filter]) < 1){
			take_storage(1, $item[mojo filter]);
			}
		if (pulls_remaining() == 3 && item_amount($item[pressurized potion of puissance]) < 1){
			take_storage(1, $item[pressurized potion of puissance]);
			}	
		if (pulls_remaining() == 2 && item_amount($item[ice Island Long tea]) < 1){
			take_storage(1, $item[ice island long tea]);
			}
		if (pulls_remaining() == 1 && item_amount($item[glass of goat's milk]) == 0 && item_amount($item[milk of magnesium])==0) {
			take_storage(1, $item[glass of goat's milk]);
			}

		if (get_campground() contains $item[potted tea tree]) {
			print("has tea tree");
			visit_url("campground.php?action=teatree");
			visit_url("choice.php?pwd&whichchoice=1104&option=2&choiceform2=Pick+a+low-hanging+tea");

			visit_url("choice.php?pwd&itemid=8606&whichchoice=1105&option=1"); //should be frost tea

			if (item_amount($item[cuppa Frost tea]) > 0) print ("yep you got a frost tea");
			else {
				abort("oops sery messed up");
			}
	//8620
		}

		if (pulls_remaining() > 0 ) abort("you're missing something.");

		if (get_property("_smithsnessSummons") == 0) {
	    	use_skill(3, $skill[Summon Smithsness]);
		}

		if (item_amount($item[hairpiece on fire]) + equipped_amount($item[hairpiece on fire]) == 0) {
	    	retrieve_item(1, $item[hairpiece on fire]);
		}

		if (have_effect($effect[merry smithsness])==0&&item_amount($item[flaskfull of hollow]) == 3) use(3, $item[Flaskfull of Hollow]);

		cli_execute("garden pick");

		if (get_property("_deckCardsDrawn").to_int() == 0 && my_level() < 5) {
			cli_execute("play empress");
		}
		if (get_property("_deckCardsDrawn").to_int() == 5){
	   		cli_execute("play Mickey Mantle");
			autosell(1, $item[1952 Mickey Mantle card]);
		}
		if (get_property("_deckCardsDrawn").to_int() == 10){
			cli_execute("play forest");
		}
	}	
	
	while (item_amount($item[turtle totem]) == 0 || item_amount($item[saucepan]) == 0) {
	    	retrieve_item(1, $item[chewing gum on a string]);
	    	use(1, $item[chewing gum on a string]);
	}

	maximize("mp, -equip actual reality goggles", False);
		
	if (item_amount($item[ice island long Tea])<2 && my_inebriety()==0) retrieve_item(2,$item[Ice Island Long Tea]);

	if (have_effect($effect[Ode to Booze]) < 4) {
	    retrieve_item(1, $item[toy accordion]);
	    if (my_mp() < mp_cost($skill[The Ode to Booze])) {
			visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
	    }
	    use_skill(1, $skill[The Ode to Booze]);
	}

	if (my_inebriety() == 0 && have_effect($effect[Ode to Booze]) >= 4) {
	    drink(1, $item[Ice Island Long Tea]);
	}

	use_familiar($familiar[Crimbo Shrub]);
	    //Decorate Shrub
	if (get_property("shrubGifts") != "yellow") {
	   	visit_url("inv_use.php?pwd&which=3&whichitem=7958");
	    visit_url("choice.php?whichchoice=999&pwd&option=1&topper=2&lights=1&garland=2&gift=1");
	   }

	if (item_amount($item[plaid cowboy hat]) + equipped_amount($item[plaid cowboy hat]) == 0 && get_property("_chateauMonsterFought") != true) {
	   	maximize("mox,-equip actual reality goggles", False);
	  	visit_url("place.php?whichplace=chateau&action=chateau_painting");
		use_skill( $skill[ Open a Big Yellow Present] );
	    
	  	if (item_amount($item[plaid cowboy hat]) == 0) {
			abort("Something got fucked. :(");
	    }
	}

	if (item_amount($item[plaid cowboy hat]) == 0) abort("Something got fucked. :(");

	//TEST 11 (1 of 11)

	if (~isdone(11)) { 
		
		print("TEST #11: nothing - 60adv", "green");
	    doservice(11);
	}

	//POSTTEST 11

	if (item_amount($item[a ten-percent bonus]) == 1) {
	    use(1, $item[a ten-percent bonus]);
	}
	while (my_level()<7){
		if (my_maxmp() > 225){
			while (my_mp() >= 125 && my_mp() >= mp_cost($skill[summon taffy])){
				use_skill($skill[summon taffy]);
			}
		}
		visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
	}
	if (my_level()>=7){
		if (my_spleen_use() == 0) chew(1, $item[astral energy drink]);
	}
	if ((my_spleen_use() == 8) && (item_amount($item[astral energy drink]) == 2)) {
		use(1, $item[mojo filter]);
	}
	if (my_spleen_use() == 7 && item_amount($item[astral energy drink]) == 2 ) {
	    chew(1, $item[astral energy drink]);
	}
	if (my_fullness() == 0 && item_amount($item[handful of Smithereens]) == 3) {
	    if (item_amount($item[This charming Flan]) == 0) retrieve_item(1, $item[This Charming Flan]);	
	}
	if (my_fullness() == 0) eat(1, $item[This Charming Flan]);

	maximize("-equip actual reality goggles", False);
	
	if (item_amount($item[Work is a Four Letter Sword]) == 0 && equipped_amount($item[Work is a Four Letter Sword]) == 0) retrieve_item(1,$item[Work is a Four Letter Sword]);
	if (item_amount($item[A Light That Never Goes Out]) == 0 && equipped_amount($item[A Light That Never Goes Out]) == 0) retrieve_item(1,$item[A Light That Never Goes Out]);
		
		
	//TEST 6 (2 of 11)

	if (~isdone(6)) { 
	    
	    print("PREP TEST #6: melee damage", "green");
		maximize("weapon dmg, -equip actual reality goggles", False);
		
		if (equipped_amount($item[Work is a Four Letter Sword]) == 0) equip($item[Work is a Four Letter Sword]);
		if (equipped_amount($item[A Light That Never Goes Out]) == 0) equip($item[A Light That Never Goes Out]);
		if (have_effect($effect[Jackasses' Symphony of Destruction]) <1) use_skill($skill[Jackasses' Symphony of Destruction]);
		if (have_effect($effect[Rage of the Reindeer]) <1) use_skill($skill[Rage of the Reindeer]);
		if (have_effect($effect[Scowl of the Auk]) <1) use_skill($skill[Scowl of the Auk]);
	  	if (have_effect($effect[Tenacity of the Snapper]) <1) use_skill($skill[Tenacity of the Snapper]);
	    if (have_effect($effect[Blessing of the War Snapper]) <1) use_skill($skill[Blessing of the War Snapper]);

		if (have_effect($effect[Ode to Booze]) < 2 && my_inebriety()==4) {
	  		retrieve_item(1, $item[toy accordion]);
	    	if (my_mp() < mp_cost($skill[The Ode to Booze])) {
				visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
	    	}
	    	use_skill(1, $skill[The Ode to Booze]);
		}
	    if(my_inebriety()==4 && have_effect($effect[Ode to Booze]) >= 2) {
	    	if (get_clan_id() == 672) cli_execute("drink 1 Sockdollager");
	    	else { abort("switch clans!");}
	    }
	    
	    if (my_mp() < mp_cost($skill[Song of the North])) visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
	    if (have_effect($effect[Song of the North]) <1) use_skill($skill[Song of the North]);
		
		bjornify_familiar($familiar[Jumpsuited Hound Dog]);

		print("TEST #6: melee damage - 55adv", "green");
		doservice(6);
	}

	//POSTTEST 6

	if (get_property("reagentSummons") == 0) use_skill($skill[Advanced Saucecrafting]);
	
	if (my_fullness() == 2 && item_amount($item[milk of magnesium]) == 0){
		retrieve_item(1, $item[milk of magnesium]);
		use(1, $item[milk of magnesium]);

		if(item_amount($item[This Charming Flan]) == 0) retrieve_item(1, $item[This Charming Flan]);
		if(item_amount($item[snow crab]) == 0) retrieve_item(1, $item[snow crab]);

		if (have_effect($effect[Got Milk])>=2 && item_amount($item[This Charming Flan])==1) if (my_fullness()==2) eat(1, $item[This Charming Flan]);
		if (have_effect($effect[Got Milk])>=1 && item_amount($item[snow crab])==1) if (my_fullness()==4) eat(1, $item[snow crab]);
		if (have_effect($effect[Got Milk])>=10 && my_fullness()==5) eat(1, $item[weird gazelle steak]);
	}

	//TEST 9 (3 of 11)

	if (~isdone(9)) {
	    print("PREP TEST #9: item/booze drop", "green");
	   
	    maximize("items, -equip actual reality goggles", False);
	
		if (have_effect($effect[Fat Leon's phat loot lyric]) < 1) use_skill($skill[Fat Leon's Phat Loot Lyric]);
		if (have_effect($effect[Singer's Faithful Ocelot]) < 1)use_skill($skill[Singer's Faithful Ocelot]);

		bjornify_familiar($familiar[Reconstituted Crow]);

		print("TEST #9: item/booze drop - 52adv", "green");
	   	doservice(9);
	}

	//POSTTEST 9

	if (item_amount($item[bitchin' meatcar]) < 1) retrieve_item(1, $item[bitchin' meatcar]);
	print("shore shenanigans");
	if (item_amount($item[dingy dinghy])==0){

		set_property("choiceAdventure793",2);

		cli_execute("adv 1 the shore");
		cli_execute("adv 1 the shore");
		cli_execute("adv 1 the shore");

		if (item_amount($item[Shore Inc. Ship Trip Scrip]) != 3) abort();

		else {retrieve_item(1,$item[dinghy plans]);}

		if (item_amount($item[dinghy plans]) == 1 && item_amount($item[dingy dinghy])==0) {
			retrieve_item(1, $item[dingy planks]);
			use(1, $item[dinghy plans]);
		}

		if (item_amount($item[dingy dinghy]) != 1) abort();	
	}
	
	if (item_amount($item[dingy dinghy]) < 1) abort();
	else {
		use_familiar($familiar[Crimbo Shrub]);
		
	   	maximize("mox, -equip actual reality goggles", False);

	  	if (item_amount($item[filthy corduroys]) <1 && equipped_amount($item[filthy corduroys])<1){

	  		adventure(1, $location[Hippy camp],"abort !monstername *hippy* || !monstername *hippy;if monstername *hippy*||monstername *hippy; skill open a big yellow present; endif;");
		
	    	if ((item_amount($item[filthy knitted dread sack]) == 0)||(item_amount($item[filthy corduroys])==0)) {
				abort("Something got fucked. :(");
			}
		}
	}

	outfit( "Filthy Hippy Disguise" );

	if (item_amount($item[lemon]) == 0 && item_amount($item[philter of phorce]) == 0) retrieve_item(1, $item[lemon]);
	if (item_amount($item[grapefruit]) == 0 && item_amount($item[ointment of the occult]) == 0) retrieve_item(1, $item[grapefruit]);
	if (item_amount($item[olive]) == 0 && item_amount($item[serum of sarcasm]) == 0) retrieve_item(1, $item[olive]);
	if (item_amount($item[tomato]) == 0 && item_amount($item[Tomato Juice of Powerful Power]) == 0) retrieve_item(1, $item[tomato]);
	
		hermitbody = visit_url("/hermit.php");

		while(contains_text(hermitbody,"left in stock")){
			hermit(1, $item[ten-leaf clover]);
		}
	
	while (item_amount($item[cherry])==0 && item_amount($item[oil of expertise]) == 0) {// && contains_text(body,"left in stock")){

		set_property("cloverProtectActive", false);
		
		int clomount = item_amount($item[disassembled clover]) + item_amount($item[ten-leaf clover]);
		if (clomount<1) hermit(1, $item[ten-leaf clover]);
		if (item_amount($item[disassembled clover]) > 0 && item_amount($item[ten-leaf clover]) <1) use(1, $item[disassembled clover]);
		
		add_item_condition(1, $item[fruit basket]);
		
		if (item_amount($item[ten-leaf clover]) > 0) adventure(1, $location[Hippy camp]);
		
		if (item_amount($item[fruit basket]) > 0) use(1, $item[fruit basket]);
		
		set_property("cloverProtectActive", true);
		hermitbody = visit_url("/hermit.php");
	}

	if (item_amount($item[lemon])==1 && item_amount($item[philter of phorce])==0) retrieve_item(1, $item[philter of phorce]);
	if (item_amount($item[grapefruit])==1 && item_amount($item[ointment of the occult])==0)retrieve_item(1, $item[ointment of the occult]);
	if (item_amount($item[olive])==1 && item_amount($item[serum of sarcasm])==0)retrieve_item(1, $item[serum of sarcasm]);
	if (item_amount($item[tomato])==1 && item_amount($item[tomato juice of powerful power])==0)retrieve_item(1, $item[tomato juice of powerful power]);
	
	if (have_effect($effect[simmering])<1) use_skill($skill[simmer]);
	
	while (have_effect($effect[Ode to Booze]) < 18 && my_inebriety()==6) {
	    retrieve_item(1, $item[toy accordion]);
	    if (my_mp() < mp_cost($skill[The Ode to Booze])) {
		visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
	    }
	    use_skill(, $skill[The Ode to Booze]);
	}

	if (my_inebriety()==6 && have_effect($effect[Ode to Booze]) >= 4) drink(1, $item[ice island long tea]);
	if (get_clan_id() == 672){
		if (my_inebriety()==10 && have_effect($effect[Ode to Booze]) >= 2) cli_execute("drink 1 Sockdollager");
		if (my_inebriety()==12 && have_effect($effect[Ode to Booze]) >= 2) cli_execute("drink 1 Sockdollager");
	} else {abort("you need to switch clans.");}
	if (my_inebriety()==14 && have_effect($effect[Ode to Booze]) >= 10) overdrink(1, $item[emergency margarita]); //now overdrunk

	maximize("adv, -equip actual reality goggles", False);
	if (get_property("_chateauDeskHarvested") == "false") visit_url("place.php?whichplace=chateau&action=chateau_desk2");
	abort("end day 1: use up your free rests and burn mp, and clanhop for fites.");
	
	} 

//DAY 2 START

else if (my_daycount() == 2) {

	if (get_clan_id() != 672) abort("you should go back to cgc.");

	if (get_property("_smithsnessSummons") == 0 && get_property("_deckCardsDrawn").to_int() == 0){

		if (pulls_remaining() == 5 && item_amount($item[SPF 451 lip balm]) < 1){
			take_storage(1, $item[SPF 451 lip balm]);	
		}
		if (pulls_remaining() == 4 && item_amount($item[super weight-gain 9000]) < 1){
			take_storage(1, $item[super weight-gain 9000]);
		}
		if (pulls_remaining() == 3 && item_amount($item[pressurized potion of perspicacity]) < 1){
			take_storage(1, $item[pressurized potion of perspicacity]);
		}	
		if (pulls_remaining() == 2 && item_amount($item[red foxglove]) < 1){
			take_storage(1, $item[red foxglove]);
		}
		if (pulls_remaining() == 1 && item_amount($item[worst candy]) < 1) {
			take_storage(1, $item[worst candy]);
		}
		if (pulls_remaining() > 0 ) abort("you're missing something.");

		if (get_campground() contains $item[potted tea tree]) {
			print("has meat tree");

			visit_url("campground.php?action=teatree");
			
			visit_url("choice.php?pwd&whichchoice=1104&option=2&choiceform2=Pick+a+low-hanging+tea");

			visit_url("choice.php?itemid=8620&pwd&whichchoice=1105&option=1"); //should be obscuri tea

			if (item_amount($item[cuppa Obscuri tea]) > 0) print ("yep you got a Obscuri tea");
			else {abort("oops sery messed up");}
			//8620
			}

		if (get_property("_smithsnessSummons") == 0) {
	    	use_skill(3, $skill[Summon Smithsness]);
		}
		if (item_amount($item[Staff of the Headmaster's Victuals]) 
			+ equipped_amount($item[Staff of the Headmaster's Victuals]) == 0) { 
	    	retrieve_item(1, $item[Staff of the Headmaster's Victuals]);
		}
		if (item_amount($item[louder than bomb]) == 0) {
	    	retrieve_item(3, $item[louder than bomb]);
		}

		if (get_property("reagentSummons") == 0) {
	    	use_skill(3, $skill[Advanced Saucecrafting]);
		}


		cli_execute("garden pick");

		if (get_property("_chateauDeskHarvested") == "false") visit_url("place.php?whichplace=chateau&action=chateau_desk2");

		if (item_amount($item[soda water]) == 0) retrieve_item(1, $item[soda water]);

		if (get_property("_rapidPrototypingUsed") < 5 && item_amount($item[cordial of concentration]) == 0) retrieve_item(1, $item[cordial of concentration]);
		if (get_property("_rapidPrototypingUsed") < 5 && item_amount($item[oil of expertise]) == 0 && item_amount($item[cherry]) > 0) retrieve_item(1, $item[oil of expertise]);
	
		if (get_property("_deckCardsDrawn").to_int() == 0){
			cli_execute("play forest");
		}
		if (get_property("_deckCardsDrawn").to_int() == 5){
			cli_execute("play giant growth");
		}

		if (item_amount($item[green mana]) != 3) abort("Something got fucked. :(");  // this needs to come after you get the mana, dumbass.

	}

	//TEST 7 (4 of 11)

	if (~isdone(7)) { 

	    print("PREP TEST #7: spell damage", "green");
	    
	    maximize("spell dmg, -equip actual reality goggles", False);
		
		if (have_effect($effect[Concentration]) < 1) use(1, $item[cordial of concentration]);
		if (have_effect($effect[song of sauce]) < 1) use_skill($skill[song of sauce]);

		bjornify_familiar($familiar[Mechanical Songbird]);

		print("TEST #7: spell damage - 47adv", "green");
		doservice(7);
	}

//POSTTEST 7 '

		hermitbody = visit_url("/hermit.php");

		while(contains_text(hermitbody,"left in stock")){
			hermit(1, $item[ten-leaf clover]);
		}
	
	while (item_amount($item[cherry])==0 && item_amount($item[oil of expertise]) == 0) {// && contains_text(body,"left in stock")){

		set_property("cloverProtectActive", false);
		
		int clomount = item_amount($item[disassembled clover]) + item_amount($item[ten-leaf clover]);
		if (clomount<1) hermit(1, $item[ten-leaf clover]);
		if (item_amount($item[disassembled clover]) > 0 && item_amount($item[ten-leaf clover]) <1) use(1, $item[disassembled clover]);
		
		add_item_condition(1, $item[fruit basket]);
		
		if (item_amount($item[ten-leaf clover]) > 0) adventure(1, $location[Hippy camp]);
		
		if (item_amount($item[fruit basket]) > 0) use(1, $item[fruit basket]);
		
		set_property("cloverProtectActive", true);
		hermitbody = visit_url("/hermit.php");
	}

	/*if (item_amount($item[cherry]) == 0 && item_amount($item[oil of expertise]) == 0){
		body = visit_url("/hermit.php");
	
		int clomount = item_amount($item[disassembled clover]) + item_amount($item[ten-leaf clover]);
		
		while (item_amount($item[cherry])==0 && item_amount($item[oil of expertise]) == 0 && contains_text(body,"left in stock")){
			clomount = item_amount($item[disassembled clover]) + item_amount($item[ten-leaf clover]);

			set_property("cloverProtectActive", false);
			hermit(1, $item[ten-leaf clover]);
			
			if (item_amount($item[disassembled clover]) > 0 && item_amount($item[ten-leaf clover]) <1) use(1, $item[disassembled clover]);
		
			add_item_condition(1, $item[fruit basket]);

			outfit( "Filthy Hippy Disguise" );
		
			if (item_amount($item[ten-leaf clover]) > 0) adventure(1, $location[Hippy camp]);
		
			if (item_amount($item[fruit basket]) > 0) use(1, $item[fruit basket]);
		
			set_property("cloverProtectActive", true);
			body = visit_url("/hermit.php");
		*/
	}
}

	if (get_property("_rapidPrototypingUsed") < 5 && item_amount($item[oil of expertise]) == 0 && item_amount($item[cherry]) > 0) retrieve_item(1, $item[oil of expertise]);
	

//TEST 10 (5 of 11)

	if (~isdone(10)) { 

	    print("PREP TEST #10: hot res", "green");
	    
	    use_familiar($familiar[exotic parrot]);
	    maximize("hot res, -equip actual reality goggles", False);
		
		if (have_effect($effect[Fireproof Lips]) < 1) use(1, $item[SPF 451 lip balm]);
		if (item_amount($item[cuppa Frost tea]) > 0 && have_effect($effect[Frost tea]) < 1) //use(1,$item[cuppa Frost tea]);
			{ use(1,$item[cuppa Frost tea]);
			if ( have_effect($effect[Frost tea]) > 0) print("frost tea used successfully");
			}
		if (have_effect($effect[elemental saucesphere]) < 1) use_skill($skill[elemental saucesphere]);
		if (have_effect($effect[astral shell]) < 1) use_skill($skill[astral shell]);
		if (have_effect($effect[Force of Mayo Be With You]) < 1) cli_execute("mayosoak");

		if (~(get_chateau() contains $item[bowl of potpourri])) {
	    	buy(1, $item[bowl of potpourri]);
		}

		if (have_effect($effect[Ode to Booze]) < 2 && my_inebriety()==0) {
	  		retrieve_item(1, $item[toy accordion]);
	    	if (my_mp() < mp_cost($skill[The Ode to Booze])) {
				visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
	    	}
	    	use_skill(1, $skill[The Ode to Booze]);
		}

	    if(get_clan_id( ) == 672) {

	    	if (have_effect($effect[got milk]) < 3) use(1, $item[milk of magnesium]);

	  		if(my_inebriety()==0 && have_effect($effect[Ode to Booze]) >= 2) cli_execute("drink 1 Ish Kabibble");
	    	if(have_effect($effect[got milk]) >= 3 && my_fullness() == 0) cli_execute("eat 1 wet dog");

	    } else { abort("you need to switch clans.");}

	    if (my_fullness() != 3) abort("couldn't eat wet dog");

		bjornify_familiar($familiar[twitching space critter]);

		while (my_basestat($stat[moxie])<35){
			if (my_maxmp() > 225){
				while (my_mp() >= 125 && my_mp() >= get_property("_libramsummoningcost").to_int()){
					use_skill($skill[summon taffy]);
				}
			}
			visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
		}

		maximize("hot res, -equip actual reality goggles", False);

		if (equipped_amount($item[plaid cowboy hat]) < 1) equip($item[plaid cowboy hat]);

		if( have_effect($effect[got milk]) >= 10 && my_fullness() == 3) eat(1, $item[sausage without a cause]);
		
		print("TEST #10: hot res - 25adv", "green");
		doservice(10);
	}

	//POSTTEST 10

	if (isdone(10)){

		if(~(get_chateau() contains $item[foreign language tapes])) {
	   		buy(1, $item[foreign language tapes]);
		}
	}

	//TEST 1 (6 of 11)

	if (~isdone(1)) { 
	    print("PREP TEST #1: hp", "green");
	    
	    maximize("hp, -equip actual reality goggles", False);
		
		if (have_effect($effect[Superveiny 9000]) <1) use(1, $item[super weight-gain 9000]);
		if (have_effect($effect[Digitalis\, Dig It]) <1) use(1, $item[red foxglove]);

		while (have_effect($effect[Ode to Booze]) < 10 && my_inebriety()==2) {
	  		retrieve_item(1, $item[toy accordion]);
	    	if (my_mp() < mp_cost($skill[The Ode to Booze])) {
				visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
	    	}
	    	use_skill(1, $skill[The Ode to Booze]);
		}

	    if(my_inebriety()==2 && have_effect($effect[Ode to Booze]) >= 10) drink(1, $item[vintage smart drink]);
	    
		if (have_effect($effect[song of starch]) <1) use_skill ($skill[song of starch]);
		if (have_effect($effect[expert oiliness]) <1 && item_amount($item[oil of expertise]) > 0) use (1, $item[oil of expertise]);

		if (get_property("_deckCardsDrawn").to_int() == 10){
			cli_execute("play strength");
		}

		if (have_effect($effect[phorcefullness]) <1) use (1, $item[philter of phorce]);
		if (have_effect($effect[tomato power]) <1) use (1, $item[tomato juice of powerful power]);
		if (have_effect($effect[Puissant Pressure]) <1) use (1, $item[pressurized potion of puissance]);
		retrieve_item(1, $item[Ben-Gal&trade; Balm]);
		if (have_effect($effect[Go Get 'Em\, Tiger!]) <1) use (1, $item[Ben-Gal&trade; Balm]); //'

		bjornify_familiar($familiar[adorable space buddy]);

		print("TEST #1: hp - 25adv", "green");
		doservice(1);
	}

//POSTTEST 1

//TEST 2 (7 of 11)

	if (~isdone(2)) { 
	    print("PREP TEST #2: muscle", "green");
	   
	    maximize("muscle, -equip actual reality goggles", False);
		
		if (have_effect($effect[phorcefullness]) < 1) use (1, $item[philter of phorce]);
		if (have_effect($effect[tomato power]) < 1) use (1, $item[tomato juice of powerful power]);
		if (have_effect($effect[expert oiliness]) < 1 && item_amount($item[oil of expertise]) > 0) use (1, $item[oil of expertise]);

		if (have_effect($effect[power Ballad of the Arrowsmith]) < 1) use_skill($skill[the power Ballad of the Arrowsmith]);
		if (have_effect($effect[Macaroni Coating]) < 1) use_skill($skill[Bind Undead Elbow Macaroni]);
		if (have_effect($effect[Blessing of the war Snapper]) < 1) use_skill($skill[Blessing of the War Snapper]);
		if (have_effect($effect[Stevedave's Shanty of Superiority]) < 1) use_skill($skill[Stevedave's Shanty of Superiority]);
		if (have_effect($effect[rage of the Reindeer]) < 1) use_skill($skill[Rage of the Reindeer]);
		if (have_effect($effect[seal clubbing frenzy]) < 1) use_skill($skill[Seal Clubbing Frenzy]);
		if (have_effect($effect[patience of the Tortoise]) < 1) use_skill($skill[Patience of the Tortoise]);

		retrieve_item(1, $item[Ben-Gal&trade; Balm]);
		if (have_effect($effect[Go Get 'Em\, Tiger!]) < 1) use (1, $item[Ben-Gal&trade; Balm]); //'

		maximize("moxie, -equip actual reality goggles", False);

		if(have_effect($effect[giant growth]) < 1 && item_amount($item[green mana])==3) adv1($location[hippy camp],-1,"skill giant growth; if pastround 1;use louder than bomb;endif;");
		
		if(have_effect($effect[giant growth]) > 0) chew (1, $item[blood-drive sticker]);

		maximize("muscle, -equip actual reality goggles", False);

		if (have_effect($effect[song of bravado]) < 1) use_skill ($skill[song of bravado]);
		if (have_effect($effect[Savage Beast Inside]) < 1 )use(1, $item[jar of &quot;Creole Lady&quot; marrrmalade]);
		
		bjornify_familiar($familiar[stab bat]);

		print("TEST #2: muscle - 49adv", "green");
		doservice(2);
	}

	//POSTTEST 2

	retrieve_item(1, $item[saucepanic]);
	while (item_amount($item[saucepan]) == 0) {
	    	retrieve_item(1, $item[chewing gum on a string]);
	    	use(1, $item[chewing gum on a string]);
	}
	retrieve_item(2, $item[saucepanic]);

	//TEST 3 (8 of 11)
		
	if (~isdone(3)) { 
	    print("PREP TEST #3: mysticality", "green");
	    
	    maximize("moxie, -equip actual reality goggles", False);

	    if(have_effect($effect[giant growth]) < 1 && item_amount($item[green mana])==2) adv1($location[hippy camp],-1,"skill giant growth; if pastround 1;use louder than bomb;endif;");
		
		if(have_effect($effect[giant growth]) > 0) use (1, $item[bag of grain]);

		if(my_spleen_use() == 10) chew(1,$item[handful of smithereens]);
		if (have_effect($effect[Perspicacious Pressure]) < 1) use(1, $item[pressurized potion of perspicacity]);
		retrieve_item(1, $item[glittery mascara]);
		if (have_effect($effect[Glittering Eyelashes]) < 1) use(1, $item[glittery mascara]);
		if (have_effect($effect[merry smithsness]) < 1) use(1, $item[flaskfull of hollow]);
		if (have_effect($effect[Mystically oiled]) < 1) use(1, $item[ointment of the occult]);
		if (have_effect($effect[song of bravado]) < 1) use_skill ($skill[song of bravado]);

		maximize("mysticality, -equip actual reality goggles", False);

		equip ($slot[weapon],$item[saucepanic]);
		equip ($slot[off-hand],$item[saucepanic]);

		bjornify_familiar($familiar[grue]);

		print("TEST #3: mysticality - 39adv", "green");
		doservice(3);
	}

	//TEST 4 (9 of 11)
		
	if (~isdone(4)) { 
	    print("PREP TEST #4: moxie", "green");
	    
	    if (have_effect($effect[expert oiliness]) < 1 && item_amount($item[oil of expertise]) > 0) use(1,$item[oil of expertise]);

	    maximize("moxie, -equip actual reality goggles", False);

	    if(have_effect($effect[giant growth]) < 1 && item_amount($item[green mana]) == 1) adv1($location[hippy camp],-1,"skill giant growth; if pastround 1;use louder than bomb;endif;");
		if(have_effect($effect[giant growth]) > 0) use (1, $item[pocket maze]);
		
		
		if (have_effect($effect[Pulchritudinous Pressure]) < 1) use(1, $item[pressurized potion of pulchritude]);
		retrieve_item(1, $item[hair spray]);
		if (have_effect($effect[butt-rock hair]) < 1) use(1, $item[hair spray]);
		if (have_effect($effect[superhuman sarcasm]) < 1) use (1, $item[serum of sarcasm]);
		if (have_effect($effect[tomato power]) < 1) use (1, $item[tomato juice of powerful power]);
		if (have_effect($effect[song of bravado]) < 1) use_skill ($skill[song of bravado]);
		if (have_effect($effect[Stevedave's Shanty of Superiority]) < 1) use_skill ($skill[Stevedave's Shanty of Superiority]);

		maximize("moxie -equip actual reality goggles", False);

		if (have_effect($effect[Ode to Booze]) < 2 && my_inebriety()==12) {
	  		retrieve_item(1, $item[toy accordion]);
	    	if (my_mp() < mp_cost($skill[The Ode to Booze])) {
				visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
	    	}
	    	use_skill(1, $skill[The Ode to Booze]);
		}
		if(get_clan_id( ) == 672) {

	  		if(my_inebriety()==12 && have_effect($effect[Ode to Booze]) >= 2) cli_execute("drink 1 Bee's Knees");
	    	
	    } else { abort("you need to switch clans.");}
	   
		bjornify_familiar($familiar[nosy nose]);

		print("TEST #4: moxie - 39adv", "green");
		doservice(4);
	}


	//TEST 5 (10 of 11)
		
	if (~isdone(5)) { 
	    print("PREP TEST #5: familiar weight", "green");
	    
	    if (have_effect($effect[blue swayed]) < 40) {
	   		while(item_amount($item[pulled blue taffy]) < 4) {
	   			if (my_mp() < mp_cost($skill[Summon Taffy])) {
					visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
	    		}
	    		use_skill(1, $skill[summon taffy]);
			}
			use(4, $item[pulled blue taffy]);
		}
	   	if (have_effect($effect[empathy]) < 1) use_skill($skill[empathy of the newt]);
	   	if (have_effect($effect[leash of Linguini]) < 1) use_skill($skill[leash of Linguini]);

		bjornify_familiar($familiar[barrrnacle]);

		print("TEST #5: familiar weight - 55adv", "green");
		doservice(5);
	}

	//TEST 8 (11 of 11)
		
	if (~isdone(8)) { 
	    print("PREP TEST #8: noncombat", "green");
	    
	   	retrieve_item(1,$item[snow cleats]);
		if (have_effect($effect[snow shoes]) < 1) use(1, $item[snow cleats]);
		equip($item[rusted-out shootin' iron]); //'
		if (item_amount($item[cuppa Obscuri tea]) > 0 && have_effect($effect[Obscuri tea]) < 1) //use(1,$item[cuppa Obscuri tea]);
			{ use(1,$item[cuppa Obscuri tea]);
			if ( have_effect($effect[Obscuri tea]) > 0) print("obs tea used successfully");
			}
	   	if (have_effect($effect[smooth movements]) < 1) use_skill($skill[smooth Movement]);
	   	if (have_effect($effect[the sonata of Sneakiness]) < 1) use_skill($skill[the sonata of Sneakiness]);

		bjornify_familiar($familiar[grimstone golem]);
		
		if (have_effect($effect[Predjudicetidigitation]) < 1) use(1, $item[worst candy]);
		if (have_effect($effect[Throwing Some Shade]) < 1) use(1, $item[shady shades]);
		if (have_effect($effect[A Rose by Any Other Material]) < 1) use(1, $item[squeaky toy rose]);

		print("TEST #8: noncombat - 15 adv", "green");
		doservice(8);
	}
	print("you should die now. or meatfarm.","blue");
	}
	
}
