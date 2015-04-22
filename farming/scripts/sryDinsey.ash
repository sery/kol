void eatdrinkspleen(){

	if (can_drink()){
		while (have_effect($effect[Ode to Booze])<(inebriety_limit()-my_inebriety())) {
			use_skill($skill[The Ode to Booze]);
			}
		while(floor((inebriety_limit() - my_inebriety()) / 4) > 0){
		/*	while (have_effect($effect[Inigo's Incantation of Inspiration])<10) {
				use_skill($skill[ Inigo's Incantation of Inspiration]);
				}
			if (my_primestat() == $stat[mysticality]) drink(1,$item[cherry bomb]);
			if (my_primestat() == $stat[muscle]) drink(1,$item[grogtini]);
			if (my_primestat() == $stat[moxie]) drink(1,$item[dirty martini]);*/
			drink(1,$item[Ice Island Long Tea]);
			}
		while((inebriety_limit()- my_inebriety()) > 0){
			/*if (can_equip($item[The Necbromancer's Wizard Staff])) {
				equip($item[The Necbromancer's Wizard Staff]);
				drink(1,$item[ice-cold Sir Schlitz]);
				}
			else drink(1,$item[pumpkin beer]);*/
			drink(1,$item[pumpkin beer]);
			}
		}
	if (can_eat()){
		if((fullness_limit()==15) || (fullness_limit()==20)){
		while (have_effect($effect[Got Milk])<(fullness_limit() - my_fullness())) {
				use(1, $item[milk of magnesium]);
				}
			if ((my_fullness()==0)&&(available_amount( $item[spaghetti breakfast]) > 0)) eat(1, $item[spaghetti breakfast]);
			while(floor((fullness_limit() - my_fullness())/5) > 0){
				eat(1,$item[hot hi mein]);
				}
			while(floor((fullness_limit() - my_fullness())/2) > 0){
				eat(1,$item[this charming flan]);
				}
			while((fullness_limit() - my_fullness()) > 0){
				if((fullness_limit()==15)||(fullness_limit()==20)) eat(1,$item[snow crab]);
				}
			}
		}
	if ((spleen_limit()-my_spleen_use()) > 0){
		while(floor((spleen_limit() - my_spleen_use())/3) > 0){
			chew(1,$item[prismatic wad]);
			}	
		/* if ((spleen_limit() - my_spleen_use()) == 3){
			use(1,$item[mojo filter]);
			use(1,$item[groose grease]);
			}
		cli_execute("uneffect Just the Best Anapests"); */
		}

	if(to_int(get_property("_chocolatesUsed"))==0) use(1,$item[choco-crimbot]);
	if((to_int(get_property("_chocolatesUsed"))==1)||(to_int(get_property("_chocolatesUsed"))==2)){
		if (my_class() == $class[Seal Clubber]) use(1,$item[chocolate seal-clubbing club]);
		if (my_class() == $class[Turtle Tamer]) use(1,$item[chocolate turtle totem]);
		if (my_class() == $class[Pastamancer]) use(1,$item[chocolate pasta spoon]);
		if (my_class() == $class[Sauceror]) use(1,$item[chocolate saucepan]);
		if (my_class() == $class[Disco Bandit]) use(1,$item[chocolate disco ball]);
		if (my_class() == $class[Accordion Thief]) use(1,$item[chocolate stolen accordion]);
	}

	}

void advprep(){
	/*while (available_amount($item[bowl of scorpions]) < 11) {
		buy(1, $item[bowl of scorpions]);
		}*/

	//put_closet(item_amount($item[bowling ball]), $item[bowling ball]);
	if (available_amount($item[BittyCar Meatcar]) > 0) use(1, $item[Bittycar meatcar]);
	if (available_amount($item[stinky Cheese Eye]) < 1) cli_execute("fold Stinky Cheese Eye");
	if (available_amount($item[loathing Legion electric knife]) < 1) cli_execute("fold Loathing Legion electric knife");
	//cli_execute("acquire ice house");
	}

void dohboxscript(){
	if (have_familiar($familiar[He-Boulder])) {
		familiar currentfam = my_familiar();
		if (my_familiar() != $familiar[He-Boulder]){
			cli_execute("checkpoint");
			use_familiar($familiar[he-boulder]);
			}
		if (available_amount($item[quadroculars] ) <1) buy(1, $item[quadroculars]);
		if ((available_amount($item[Rain-Doh black box] ) <1) && (available_amount($item[Rain-Doh box full of monster] ) <1) && (available_amount($item[can of Rain-Doh] ) <1)) use(1, $item[can of Rain-Doh]);
		set_location($location[The Oasis]);
		cli_execute("maximize meat, equip quadroculars");
		cli_execute("ccs swarm");
		if ((have_effect($effect[Billiards Belligerence])<1) && (to_int(get_property("_poolGames")) < 2)) cli_execute("pool 1");
		if (get_property("rainDohMonster")=="swarm of scarab beatles"){
			cli_execute("use doh box");
			}
		else if (get_property("spookyPuttyMonster")=="swarm of scarab beatles"){
			cli_execute("use putty monster");
			}
		else if (!to_boolean(get_property("_photocopyUsed"))){
			if (get_property("photocopyMonster")=="swarm of scarab beatles"){
				cli_execute("use photocopied monster");
				}
			else {
				if(user_confirm("Do you want me to get some beatles from Faxbot?", 50, true)){
					cli_execute("faxbot beatles");
					cli_execute("use photocopied monster");
					}
				else { 
					print("You don't have a copy of a swarm of scarab beatles, and you won't let me get one.");
					}
				}
			}
		else print("You don't have a copy of a swarm of scarab beatles, and I can't get one.");
		cli_execute("ccs wham");
		use_familiar(currentfam);
		cli_execute("outfit checkpoint");
	
		}
	}

void which_fam(){
	//int mushrooms = (have_familiar($familiar[astral badger]) == true ? to_int(get_property( "_astralDrops" )) : 5);
	//int absinths = (have_familiar($familiar[green pixie]) == true ? to_int(get_property( "_absintheDrops" )) : 5);
	//int gongs = (have_familiar($familiar[llama lama]) == true ? to_int(get_property( "_gongDrops" )) : 5);
	//int tokens =  (have_familiar($familiar[rogue program]) == true ? to_int(get_property( "_tokenDrops" )) : 5);
	//int transponders =  (have_familiar($familiar[li'l xenomorph]) == true ? to_int(get_property( "_transponderDrops" )) : 5); 
	//int aguas = (have_familiar($familiar[baby sandworm]) == true ? to_int(get_property( "_aguaDrops" )) : 5);
	//int folios = (have_familiar($familiar[blavious kloop]) == true ? to_int(get_property( "_kloopDrops" )) : 2);
	int greases = (have_familiar($familiar[bloovian groose]) == true ? to_int(get_property( "_grooseDrops" )) : 2);
	int dreamjars = (have_familiar($familiar[unconscious collective]) == true ? to_int(get_property( "_dreamJarDrops" )) : 2);
	int fairytales = (have_familiar($familiar[grim brother]) == true ? to_int(get_property( "_grimFairyTaleDrops" )) : 2);
	int powdergold = (have_familiar($familiar[golden monkey]) == true ? to_int(get_property( "_powderedGoldDrops" )) : 2);

//	int item_drop = min(2,min(mushrooms,min(absinths,min(gongs,min(tokens,min(transponders,min(aguas,min(folios,min(greases,min(dreamjars, fairytales))))))))));
	int item_drop = min(2,min(powdergold,min(greases,min(dreamjars, fairytales))));

	/*
	if (have_familiar($familiar[Knob Goblin Organ Grinder]) && (to_int(get_property( "_pieDrops" )) < 3)) {
		use_familiar($familiar[Knob Goblin Organ Grinder]);
		}
	else if (have_familiar($familiar[grimstone golem]) && (to_int(get_property( "_grimstoneMaskDrops" )) < 1)) {
		use_familiar($familiar[grimstone golem]);
		}
	else if (have_familiar($familiar[Angry Jung Man]) && (to_int(get_property( "_jungDrops" )) < 1)) {
		use_familiar($familiar[Angry Jung Man]);
		}
		*/
	if (item_drop != 2) {
		/*if (mushrooms <= item_drop && mushrooms < 5) {	
			use_familiar($familiar[astral badger]);
			}
		else if (absinths <= item_drop && absinths < 5) {	
			use_familiar($familiar[green pixie]);
			}
		else if (gongs <= item_drop && gongs < 5) {
			use_familiar($familiar[llama lama]);
			}
		else if (tokens <= item_drop && tokens < 5) {
			use_familiar($familiar[rogue program]);
			}
		else if (transponders <= item_drop && transponders < 5){
			use_familiar($familiar[li'l xenomorph]);
			}
		else if (aguas <= item_drop || aguas < 5) {	
			use_familiar($familiar[baby sandworm]);
			}
		/*else if (folios <= item_drop || folios < 2) {	
			use_familiar($familiar[blavious kloop]);
			}*/
		if (greases <= item_drop || greases < 2) {	
			use_familiar($familiar[bloovian groose]);
			}
		else if (dreamjars <= item_drop || dreamjars < 2) {	
			use_familiar($familiar[Unconscious Collective]);
			}
		else if (fairytales <= item_drop || fairytales < 2) {	
			use_familiar($familiar[Grim Brother]);
			}
		else if (powdergold <= item_drop || powdergold < 2) {	
			use_familiar($familiar[Golden Monkey]);
			}
		}
	/*else if (have_familiar($familiar[Happy Medium]) && (to_int(get_property( "_mediumSiphons" )) < 3)) {
		use_familiar($familiar[Happy Medium]);
		}*/
	/*else if (have_familiar($familiar[Pair of Stomping Boots]) && (to_int(get_property( "_pasteDrops" )) < 2)) {
		use_familiar($familiar[Pair of Stomping Boots]);
		}*/
	else if (have_familiar($familiar[Adventurous Spelunker]) && (to_int(get_property( "__spelunkingTalesDrops" )) < 1)) {
		use_familiar($familiar[Adventurous Spelunker]);
		}
	else {
		if (!have_familiar($familiar[hobo monkey])) use_familiar($familiar[leprechaun]);
		//if (have_familiar($familiar[grimstone golem])) use_familiar($familiar[grimstone golem]);
		if (have_familiar($familiar[hobo monkey])) use_familiar($familiar[hobo monkey]);
		}
	}

string maximizefor(){
	string maximizeforString = "";
	maximizeforString += "meat";
	//if (available_amount($item[camp scout backpack])>0) maximizeforString += ", equip camp scout backpack";
	if (
		(available_amount($item[buddy bjorn])>0) && (
			((have_familiar($familiar[Grim Brother]) && (to_int(get_property("_grimFairyTaleDropsCrown")) <1)) && (my_familiar() != $familiar[Grim Brother])) || 
			((have_familiar($familiar[grimstone golem]) && (to_int(get_property("_grimstoneMaskDropsCrown")) <1))  && (my_familiar() != $familiar[grimstone golem])) )) maximizeforString += ", equip buddy bjorn";
	if (to_int(get_property("_stinkyCheeseCount")) < 100) maximizeforString += ", equip stinky cheese eye";
	//if ((to_int(get_property("_pantsgivingCrumbs")) < 9) && ((to_int(get_property("_pantsgivingCount")) < 50) || (to_int(get_property("_pantsgivingFullness")) != 2))) maximizeforString += ", equip pantsgiving";
	if (to_int(get_property("_pantsgivingFullness")) != 2) maximizeforString += ", equip pantsgiving";
	if (to_int(get_property("_mayflySummons")) < 30 ) maximizeforString += ", equip mayfly bait";
	/*if ((my_familiar()== $familiar[knob goblin organ grinder]) && (((to_int(get_property( "_pieDrops" )) == 1) && (to_int(get_property( "_piePartsCount" )) == 4)) || ((to_int(get_property( "_pieDrops" )) == 2) && (to_int(get_property( "_piePartsCount" )) == 10)))) {
		if (available_amount($item[microwave stogie] ) <1) buy(1, $item[microwave stogie]);
		maximizeforString += ",equip microwave stogie";
		}*/
	//if (my_primestat() == $stat[moxie]) maximizeforString += ", -melee";
	return maximizeforString;
	}
void finalcleanup(){
	maximize("mp, equip pantsgiving",false);

	int times_to_rest = 0;
	if (have_skill($skill[Adventurer of Leisure])) times_to_rest += 2;
	if (have_skill($skill[Disco Nap])) times_to_rest += 1;
	if (have_skill($skill[Executive Narcolepsy])) times_to_rest += 1;
	if (have_skill($skill[Dog Tired])) times_to_rest += 5;
	if (have_skill($skill[Food Coma])) times_to_rest += 10;
	if (have_familiar($familiar[unconscious collective])) times_to_rest += 3;

	while(to_int(get_property("timesRested")) < times_to_rest) {
		if (mp_cost( $skill[Summon Resolutions] ) < my_mp()) use_skill($skill[Summon Resolutions]);
		cli_execute("rest");
	}
	while (my_mp()> my_basestat( $stat[mysticality] )){
		use_skill($skill[Summon Resolutions]);
		}
	cli_execute("pool 1");
	if (get_property("sidequestArenaCompleted")=="fratboy") cli_execute("concert winklered");
	if ((get_property("questL11Manor")=="finished") && (get_property("demonSummoned")=="false")) cli_execute("summon 2");
	if (have_effect($effect[Everything Looks Yellow]) == 0) dohboxscript();
	
	if (available_amount($item[the legendary beat])>0) use(1,$item[the legendary beat]);
	if (available_amount($item[bag o' tricks])>0) use(1,$item[bag o' tricks]);
	if (available_amount($item[fishy pipe])>0) use(1,$item[fishy pipe]);
	if (have_skill($skill[Summon Annoyance])) use_skill($skill[Summon annoyance]);
	if (have_skill($skill[Summon Clip Art])) cli_execute("create 3 cold-filtered");
	if((have_skill($skill[Superhuman Cocktailcrafting])) && (my_primestat()==$stat[moxie])) cli_execute("create 10 definit");	
	cli_execute("swim laps");
	cli_execute("friars familiar");
	cli_execute("telescope high");
	cli_execute("ballpit");
	maximize("mp, equip pantsgiving",false);
	if (my_maxmp()-my_mp()>1000) cli_execute("shower mp");
	while (mp_cost( $skill[Summon Resolutions] ) < my_mp()) use_skill($skill[Summon Resolutions]);
	if (get_property("sidequestNunsCompleted")=="fratboy") {
		if (my_maxmp()-my_mp()>1000) cli_execute("nuns");
		while (mp_cost( $skill[Summon Resolutions] ) < my_mp()) use_skill($skill[Summon Resolutions]);
		if (my_maxmp()-my_mp()>1000) cli_execute("nuns");
		while (mp_cost( $skill[Summon Resolutions] ) < my_mp()) use_skill($skill[Summon Resolutions]);
		if (my_maxmp()-my_mp()>1000) cli_execute("nuns");
		while (mp_cost( $skill[Summon Resolutions] ) < my_mp()) use_skill($skill[Summon Resolutions]);
		}
	if ((my_maxmp()-my_mp()>500)&&(available_amount($item[oscus's neverending soda])>0)) use(1,$item[oscus's neverending soda]);
	while (mp_cost( $skill[Summon Resolutions] ) < my_mp()) use_skill($skill[Summon Resolutions]);
	if ((to_int(get_property("_zapCount")) == 0) && (my_ascensions() == to_int(get_property("lastZapperWand")))) cli_execute("acquire peach;zap peach");
	cli_execute("rollover");
	cli_execute("/msg buffy 25 ode");


}

void pantsFull(){
	if (((to_int(get_property("_pantsgivingCount")) > 48) && (fullness_limit() > my_fullness()))&&(have_effect($effect[got milk])==0)) {
				use(1, $item[milk of magnesium]);
				eat(1, $item[bag of qwop]);
				cli_execute("hottub");
				}
			else if ((to_int(get_property("_pantsgivingCount")) > 49) && (fullness_limit() > my_fullness())) {
				eat(1, $item[bag of qwop]);
				cli_execute("hottub");
				}
	
}
void crownDrops(){
				if ((to_int(get_property("_grimFairyTaleDropsCrown")) <1) && have_familiar($familiar[grim brother])) {
				if ((my_familiar() != $familiar[grim brother]) && (have_equipped($item[Buddy Bjorn]))) 
					bjornify_familiar($familiar[grim brother]);}
			if ((to_int(get_property("_grimstoneMaskDropsCrown")) <1) && have_familiar($familiar[grimstone golem])) {
				if ((my_familiar() != $familiar[grimstone golem]) && (have_equipped($item[Buddy Bjorn]))) 
					bjornify_familiar($familiar[grimstone golem]);}
}
void main(){
	//boolean satWithCloset = to_boolean(get_property("autoSatisfyWithCloset"));
	//if (satWithCloset) set_property("autoSatisfyWithCloset","false");

	set_property("valueOfAdventure",2750);
	string startedAt = time_to_string();
	int startingMeat = my_meat();
	eatdrinkspleen();
	advprep();
	string maxStringbefore = maximizefor();
	maximize(maxStringbefore, false);
	if ( have_familiar($familiar[he-boulder])) {
		while (my_adventures() > 100) {
			if (have_effect($effect[Everything Looks Yellow]) == 0) dohboxscript();
			set_location($location[Barf Mountain]);
			while (have_effect($effect[Everything Looks Yellow]) != 0) {
				pantsFull();
				familiar usingfam = my_familiar();
				which_fam();
				boolean runMax = false;
				if (maxStringbefore != maximizefor()) {
					runMax = true;
					maxStringbefore = maximizefor();
					}
				if (my_familiar() != usingfam) runMax=true;
				if (runMax) maximize(maximizefor(),false);
				crownDrops();
				adv1($location[Barf Mountain], -1, "");
				}
			}
		}
	while (my_adventures() > 56) {
		set_location($location[Barf Mountain]);
		pantsFull();
		familiar usingfam = my_familiar();
		boolean runMax = false;
		if (maxStringbefore != maximizefor()) {
			runMax = true;
			maxStringbefore = maximizefor();
			}
		if (my_familiar() != usingfam) runMax=true;
	
		if (runMax) maximize(maximizefor(),false);
		crownDrops();
		adv1($location[Barf Mountain], -1, "");
		}
	if (my_adventures() < 57) finalcleanup();
	print("i think i'm done?","red");
	print("Started at "+startedAt+" and finished at "+time_to_string()+".","red");
	int gainedmeat = my_meat() - startingMeat;
	print("Gained " + gainedmeat + " liquid meat.");
	print("All you should need to do now is check for a Jick Jar and drink a nightcap","red");
	print("Best to be on the safe side and double check, though.","red");
	//if (satWithCloset) set_property("autoSatisfyWithCloset","true");

}