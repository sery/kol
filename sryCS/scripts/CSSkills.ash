
//string charsheet = visit_url("charsheet.php");
import <zlib.ash>

string charsheet = visit_url("showplayer.php?who=1384581");
/*foreach s in $skills[Advanced Cocktailcrafting,
					Advanced Saucecrafting,
					Aloysius' Antiphon of Aptitude,
					Astral Shell,
					Blubber Up,
					Carlweather's Cantata of Confrontation,
					Cletus's Canticle of Celerity,
					Disco Aerobics,
					Disco Fever,
					Double-Fisted Skull Smashing,
					Drescher's Annoying Noise,
					Elemental Saucesphere,
					Empathy of the Newt,
					Fat Leon's Phat Loot Lyric,
					Giant Growth,
					Grab a Cold One,
					Jackasses' Symphony of Destruction,
					Leash of Linguini,
					Manicotti Meditation,
					Moxie of the Mariachi,
					Musk of the Moose,
					Open a Big Yellow Present,
					Pastamastery,
					Patience of the Tortoise,
					Pride of the Puffin,
					Pulverize,
					Rage of the Reindeer,
					Reptilian Fortitude,
					Sauce Contemplation,
					Saucegeyser,
					Seal Clubbing Frenzy,
					Simmer,
					Singer's Faithful Ocelot,
					Smooth Movement,
					Song of Bravado,
					Song of Sauce,
					Song of Starch,
					Song of the North,
					Spaghetti Breakfast,
					Spirit of Rigatoni,
					Springy Fusilli,
					Stevedave's Shanty of Superiority,
					Summon Smithsness,
					Suspicious Gaze,
					Tenacity of the Snapper,
					The Magical Mojomuscular Melody,
					The Moxious Madrigal,
					The Ode to Booze,
					The Power Ballad of the Arrowsmith,
					The Sonata of Sneakiness,
					Transcendent Olfaction,
					Ur-Kel's Aria of Annoyance,
					Wry Smile]{

string sstg = to_string(s);
print(sstg);
string hcs = sstg + "</a> (<b>HP</b>)";
print(hcs);
	if (~contains_text(charsheet,hcs )) print("Missing: " + s, "red");
	else if (~contains_text(charsheet,sstg )) print("Upgrade: " + s, "blue");
				*/

string summonStgU;
string summonStgM;

foreach s in $skills[Advanced Cocktailcrafting,		Advanced Saucecrafting,
					Grab a Cold One,				Pastamastery,
					Pulverize,						Spaghetti Breakfast]{
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg )) {summonStgU += "Upgrade: " + s + "<br>";} 
	else summonStgM += "Missing: " + s + "<br>";
}

if(length(summonStgU) > 0 || length(summonStgM) > 0){
	print("Summons:");
	if (~have_skill($skill[Summon Smithsness])) print("Missing: " + "Summon Smithsness", "red");
	print_html("<font color='red'>"+summonStgM+"</font><font color='blue'>"+summonStgU+"</font>");
	
}

string miscStgU;
string miscStgM;

foreach s in $skills[Adventurer of Leisure,			Disco Nap,
					Double-Fisted Skull Smashing,	Rapid Prototyping,
					Spirit of Rigatoni,				Tao of the Terrapin,
					The Ode to Booze]{
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg )){ miscStgU += "Upgrade: " + s + "<br>"; } //print("Upgrade: " + s, "blue");
	else miscStgM += "Missing: " + s + "<br>";
}

if(length(miscStgU) > 0 || length(miscStgM) > 0){
	print_html("Misc:<br><font color='red'>"+miscStgM+"</font><font color='blue'>"+miscStgU+"</font><br>");
}


string hpStgU;
string hpStgM;

foreach s in $skills[Abs of Tin,				Gnomish Hardigness,
					Irrepressible Spunk,		Moxie of the Mariachi,
					Patience of the Tortoise,	Reptilian Fortitude,
					Sauce Contemplation,		Slimy Sinews,
					Song of Bravado,			Song of Starch,
					Spirit of Ravioli,			Stevedave's Shanty of Superiority,
					The Power Ballad of the Arrowsmith]{ //'
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg )) { hpStgU += "Upgrade: " + s + "<br>"; } 
	else hpStgM += "Missing: " + s + "<br>";
}

if(length(hpStgU) > 0 || length(hpStgM) > 0){
	print_html("HP:<br><font color='red'>"+hpStgM+"</font><font color='blue'>"+hpStgU+"</font><br>");
}


string itemStgU;
string itemStgM;

foreach s in $skills[Fat Leon's Phat Loot Lyric,	Mad Looting Skillz,
					Natural Born Scrabbler,			Powers of Observatiogn,
					Singer's Faithful Ocelot,		Thief Among the Honorable]{
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { itemStgU += "Upgrade: " + s + "<br>"; } 
	else itemStgM += "Missing: " + s + "<br>";
}

if(length(itemStgU) > 0 || length(itemStgM) > 0){
	print_html("Item Drops:<br><font color='red'>"+itemStgM+"</font><font color='blue'>"+itemStgU+"</font><br>");
}


string musStgU;
string musStgM;

foreach s in $skills[Patience of the Tortoise,			Rage of the Reindeer,
					Seal Clubbing Frenzy,				Song of Bravado,
					Stevedave's Shanty of Superiority,	The Power Ballad of the Arrowsmith]{//'
	string sstg = to_string(s);

	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg )) musStgU+= "Upgrade: " + s + "<br>";
	else musStgM += "Missing: " + s + "<br>";
}

if(length(musStgU) > 0 || length(musStgM) > 0){
	print_html("Muscle:<br><font color='red'>"+musStgM+"</font><font color='blue'>"+musStgU+"</font><br>");
}


string mysStgU;
string mysStgM;

foreach s in $skills[Manicotti Meditation,	Sauce Contemplation,
					Song of Bravado,		Stevedave's Shanty of Superiority,
					The Magical Mojomuscular Melody]{//'
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { mysStgU += "Upgrade: " + s + "<br>"; } 
	else mysStgM += "Missing: " + s + "<br>";
}

if(length(mysStgU) > 0 || length(mysStgM) > 0){
	print_html("Mysticality:<br><font color='red'>"+mysStgM+"</font><font color='blue'>"+mysStgU+"</font><br>");
}


string moxStgU;
string moxStgM;

foreach s in $skills[Blubber Up,				Disco Aerobics,
					Disco Fever,				Disco Smirk,
					Moxie of the Mariachi,		Song of Bravado,
					The Moxious Madrigal, 		Stevedave's Shanty of Superiority]{
//'

	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { moxStgU += "Upgrade: " + s + "<br>"; } 
	else moxStgM += "Missing: " + s + "<br>";
}

if(length(moxStgU) > 0 || length(moxStgM) > 0){
	print_html("Moxie:<br><font color='red'>"+moxStgM+"</font><font color='blue'>"+moxStgU+"</font><br>");
}


string meleeStgU;
string meleeStgM;

foreach s in $skills[Claws of the Walrus,		Disco Fever,
					Scowl of the Auk,			Jackasses' Symphony of Destruction,
					Song of the North,			Tenacity of the Snapper]{
//'
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { meleeStgU += "Upgrade: " + s + "<br>"; } 
	else meleeStgM += "Missing: " + s + "<br>";
}

if(length(meleeStgU) > 0 || length(meleeStgM) > 0){
	print_html("Melee Damage:<br><font color='red'>"+meleeStgM+"</font><font color='blue'>"+meleeStgU+"</font><br>");
}


string spellStgU;
string spellStgM;

foreach s in $skills[Arched Eyebrow of the Archmage,	Intrinsic Spiciness,
					Master Saucier,						Simmer,
					Song of Sauce,						Subtle and Quick to Anger]{
//' Also Elron's but you can't use that til 15
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { spellStgU += "Upgrade: " + s + "<br>"; } 
	else spellStgM += "Missing: " + s + "<br>";
}

if(length(spellStgU) > 0 || length(spellStgM) > 0){
	print_html("Spell Damage:<br><font color='red'>"+spellStgM+"</font><font color='blue'>"+spellStgU+"</font><br>");
}


string hotresStgU;
string hotresStgM;

foreach s in $skills[Asbestos Heart,		Astral Shell,
					Elemental Saucesphere,	Tolerance of the Kitchen]{
//'
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { hotresStgU += "Upgrade: " + s + "<br>"; } 
	else hotresStgM += "Missing: " + s + "<br>";
}

if(length(hotresStgU) > 0 || length(hotresStgM) > 0){
	print_html("Hot Resistance:<br><font color='red'>"+hotresStgM+"</font><font color='blue'>"+hotresStgU+"</font><br>");
}


string noncomStgU;
string noncomStgM;

foreach s in $skills[Smooth Movement,	The Sonata of Sneakiness]{
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { noncomStgU += "Upgrade: " + s + "<br>"; } 
	else noncomStgM += "Missing: " + s + "<br>";
}

if(length(noncomStgU) > 0 || length(noncomStgM) > 0){
	print_html("Noncombat:<br><font color='red'>"+noncomStgM+"</font><font color='blue'>"+noncomStgU+"</font><br>");
}


string weightStgU;
string weightStgM;

foreach s in $skills[Amphibian Sympathy,	Empathy of the Newt,
					Leash of Linguini]{
//' Also Chorale but can't cast that til 15 so meh.
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { weightStgU += "Upgrade: " + s + "<br>"; } 
	else weightStgM += "Missing: " + s + "<br>";
}

if(length(weightStgU) > 0 || length(weightStgM) > 0){
	print_html("Familiar Weight:<br><font color='red'>"+weightStgM+"</font><font color='blue'>"+weightStgU+"</font><br>");
}


string fightStgU;
string fightStgM;

foreach s in $skills[Curse of Weaksauce,
					Giant Growth,
					Itchy Curse finger,
					Saucegeyser,
					Transcendent Olfaction]{
//' Also Hobo Boss Song but can't cast that til 15 so meh.
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { fightStgU += "Upgrade: " + s + "<br>"; } 
	else fightStgM += "Missing: " + s + "<br>";
}

if(length(fightStgU) > 0 || length(fightStgM) > 0){
	print_html("Fighting:<br><font color='red'>"+fightStgM+"</font><font color='blue'>"+fightStgU+"</font><br>");
}


string initStgU;
string initStgM;

foreach s in $skills[Cletus's Canticle of Celerity,	Overdeveloped Sense of Self Preservation,
					Slimy Shoulders,				Springy Fusilli,
					Suspicious Gaze,				Walberg's Dim Bulb]{
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { initStgU += "Upgrade: " + s + "<br>"; } 
	else initStgM += "Missing: " + s + "<br>";
}

if(length(initStgU) > 0 || length(initStgM) > 0){
	print_html("Initiative:<br><font color='red'>"+initStgM+"</font><font color='blue'>"+initStgU+"</font><br>");
}


string statStgU;
string statStgM;

foreach s in $skills[Aloysius' Antiphon of Aptitude,	Drescher's Annoying Noise,
					Pride of the Puffin,				Ur-Kel's Aria of Annoyance,
					Wry Smile]{//'
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { statStgU += "Upgrade: " + s + "<br>"; } 
	else statStgM += "Missing: " + s + "<br>";
}

if(length(statStgU) > 0 || length(statStgM) > 0){
	print_html("Stats/ML:<br><font color='red'>"+statStgM+"</font><font color='blue'>"+statStgU+"</font><br>");
}


string pluscomStgU;
string pluscomStgM;

foreach s in $skills[Carlweather's Cantata of Confrontation,	Musk of the Moose]{// '
	string sstg = to_string(s);
	string hcs = sstg + "</a> (<b>HP</b>)";
	if (contains_text(charsheet,hcs )); /*print (sstg, "green");*/
	else if (contains_text(charsheet,sstg ))  { pluscomStgU += "Upgrade: " + s + "<br>"; } 
	else pluscomStgM += "Missing: " + s + "<br>";
}

if(length(pluscomStgU) > 0 || length(pluscomStgM) > 0){
	print_html("+Combat:<br><font color='red'>"+pluscomStgM+"</font><font color='blue'>"+pluscomStgU+"</font><br>");
}



