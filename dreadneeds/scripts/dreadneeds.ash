##Hugely indebted to TheUberFerret for his HoboNeeds script which triggered this.
##Also to Grotfang for his adaptation of Zarqon's update script.
##You know what, so little of this is actually my work all credit really should go to them.

################################EDITABLE STUFF################################

//Set this to true if you wish for all Hobopolis items in your inventory to be moved to your DC.
boolean dc_everything = false;

//If you would like a specific number of each Hobopolis item to be moved to your DC, specify it here. 
//0 means your DC will remain untouched, as opposed to removing all Hobopolis items.
int qty_to_dc = 0;

//Set this to true if you would like to move your hobo code binder to your DC.
boolean hobo_binder = false;

//Set this to true if you would like to move hobo nickels to your DC as well.
boolean hobo_nickel = false;

#############################END OF EDITABLE STUFF############################




buffer table;

int sumIt(item it)
{
	return (item_amount(it) + closet_amount(it) + equipped_amount(it) + storage_amount(it));
}

string dispItem(item what) {
	int iTot = sumIt(what);
	string a;
	if( iTot == 0 )
		a = what + " - <font color='red'>" + iTot + "</font><br>";
	else
		a = what + " - <font color='green'>" + iTot + "</font><br>";
	return a;
	}

/*string dcdispItem(item what)
{
	int idcTot = display_amount( what );
	string b;
	if( idcTot == 0 )
		b = "<font color='red'>" + idcTot + "</font><br>";
	else
		b = "<font color='green'>" + idcTot + "</font><br>";
	return b;
}
*/

string fallsfromsky() {
	buffer a;
	foreach x in $items[Covers-Your-Head,Drapes-You-Regally,Warms-Your-Tush,
						Helps-You-Sleep,Quiets-Your-Steps,Protects-Your-Junk,
						Gets-You-Drunk,
						blood kiwi, eau de mort, bloody kiwitini] {
		a.append( dispItem( x ) );
		}
	return to_string(a);
	}

string greatwolf() {
	buffer a;
	foreach x in $items[Great Wolf's headband,Great Wolf's left paw,Great Wolf's right paw,
						Great Wolf's rocket launcher,Great Wolf's beastly trousers,Great Wolf's lice,
						Hunger&trade; Sauce,
						moon-amber,polished moon-amber,moon-amber necklace] {
		a.append( dispItem( x ) );
		}
	return to_string(a);
	}

string woodsbugbears() {
	buffer a;
	foreach x in $items[ warm fur,snowstick,stinkwater,eerie fetish,dubious loincloth] {
		a.append( dispItem( x ) );
		}	
	return to_string(a);
	}

string woodswerewolves() {
	buffer a;
	foreach x in $items[accidental mutton,drafty drawers,guts necklace,wolfskull mask,groping claw] {
		a.append( dispItem( x ) );
		}	
	return to_string(a);
	}

string zombiehoa() {
	buffer a;
	foreach x in $items[zombie mariachi hat,zombie accordion,zombie mariachi pants,
						HOA regulation book,HOA zombie eyes,HOA citation pad,
						wriggling severed nose,
						Dreadsylvanian seed pod, weedy skirt] {
		a.append( dispItem( x ) );
		}
	return to_string(a);
	}

string mayorghost() {
	buffer a;
	foreach x in $items[Mayor Ghost's toupee,Mayor Ghost's cloak,Mayor Ghost's khakis,
						Mayor Ghost's gavel,Mayor Ghost's sash,Mayor Ghost's scissors,
						ghost pepper,
						intricate music box parts,wax banana,complicated lock impression,replica key,
						Dreadsylvania Auditor's badge] {
		a.append( dispItem( x ) );
		}
	return to_string(a);
	}

string villagezombies() {
	buffer a;
	foreach x in $items[hothammer,Thriller Ice,muddy skirt,grandfather watch,antique spyglass] {
		a.append( dispItem( x ) );
		}
	return to_string(a);
	}

string villageghosts() {
	buffer a;
	foreach x in $items[vengeful spirit,BOOtonniere,bag of unfinished business,ghost thread,transparent pants] {
		a.append( dispItem( x ) );
		}	
	return to_string(a);
	}
	
string drunkula() {
	buffer a;
	foreach x in $items[Thunkula's drinking cap,Drunkula's cape,Drunkula's silky pants,
						Drunkula's bell,Drunkula's ring of haze,Drunkula's wineglass,
						bottle of Bloodweiser,
						ghost shawl] {
		a.append( dispItem( x ) );
		}
	return to_string(a);
	}

string unkillable() {
	buffer a;
	foreach x in $items[Unkillable Skeleton's skullcap,Unkillable Skeleton's breastplate,Unkillable Skeleton's shinguards,
						Unkillable Skeleton's sawsword,Unkillable Skeleton's shield,Unkillable Skeleton's restless leg,Staff of the Roaring Hearth,
						electric Kool-Aid,
						bone flour,dread tarragon,dreadful roast,stinking agaricus,Dreadsylvanian shepherd's pie] {
		a.append( dispItem( x ) );
		}
	return to_string(a);
	}
	
string castlevampires() {
	buffer a;
	foreach x in $items[vial of hot blood,remorseless knife,cod cape,intimidating coiffure,blood sausage] {
		a.append( dispItem( x ) );
		}
	return to_string(a);
	}
	
string castleskeletons() {
	buffer a;
	foreach x in $items[frying brainpan,old ball and chain,tailbone shield,old dry bone,tonguebone] {
		a.append( dispItem( x ) );
		}	
	return to_string(a);
	}
/*
string market()
{
	buffer a;
	buffer b;
	foreach x in $items[crumpled felt fedora, battered old top-hat, shapeless wide-brimmed hat, mostly rat-hide leggings, hobo dungarees,
	old patched suit-pants, old soft shoes, hobo stogie, rope with some soap on it, sharpened hubcap, very large caltrop, The Six-Pack of Pain,
	sealskin drum, washboard shield, spaghetti-box banjo, marinara jug, makeshift castanets, left-handed melodica, dinged-up triangle,
	hobo monkey]
	{
		a.append( dispItem( x ) );
		b.append( dcdispItem( x ) );
	}
	string c = to_string( a ) + "</TD><TD>" + to_string( b );
	return c;
}

string sewers()
{
	buffer a;
	buffer b;
	foreach x in $items[bottle of Ooze-O, bottle of sewage schnapps, C.H.U.M. chum, C.H.U.M. knife, C.H.U.M. lantern, decaying goldfish liver,
	gator skin, gatorskin umbrella, sewer nuggets, sewer wad, unfortunate dumplings]
	{
		a.append( dispItem( x ) );
		b.append( dcdispItem( x ) );
	}
	string c = to_string( a ) + "</TD><TD>" + to_string( b );
	return c;
}

string candy()
{
	buffer a;
	buffer b;
	foreach x in $items[frostbite-flavored Hob-O, fry-oil-flavored Hob-O, garbage-juice-flavored Hob-O, Roll of Hob-Os, sterno-flavored Hob-O,
	strawberry-flavored Hob-O]
	{
		a.append( dispItem( x ) );
		b.append( dcdispItem( x ) );
	}
	string c = to_string( a ) + "</TD><TD>" + to_string( b );
	return c;
}

string misc()
{
	buffer a;
	buffer b;
	foreach x in $items[bindle of joy, boxcar turtle, dead guy's memento, epic wad, hobo code binder, hobo nickel, Staff of the Deepest Freeze]
	{
		a.append( dispItem( x ) );
		b.append( dcdispItem( x ) );
	}
	string c = to_string( a ) + "</TD><TD>" + to_string( b );
	return c;
}

string boss_skills()
{
	buffer a;
	if(have_skill( $skill[Elron's Explosive Etude])) a.append("<font color='green'>You have the skill Elron's Explosive Etude</font>\n");
	else a.append("<font color='red'>You lack the skill Elron's Explosive Etude: You can aquire it from Ol' Scratch</font>\n");
	if(have_skill( $skill[Benetton's Medley of Diversity])) a.append("<font color='green'>You have the skill Benetton's Medley of Diversity</font>\n" );
	else a.append("<font color='red'>You lack the skill Benetton's Medley of Diversity: You can acquire it from Frosty</font>\n");
	if(have_skill( $skill[The Ballad of Richie Thingfinder])) a.append("<font color='green'>You have the skill The Ballad of Richie Thingfinder</font>\n");
	else a.append("<font color='red'>You lack the skill The Ballad of Richie Thingfinder: You can acquire it from Oscus</font>\n");	
	if(have_skill( $skill[Prelude of Precision])) a.append("<font color='green'>You have the skill Prelude of Precision</font>\n");
	else a.append("<font color='red'>You lack the skill Prelude of Precision: You can acquire it from Zombo</font>\n");
	if(have_skill( $skill[Chorale of Companionship])) a.append("<font color='green'>You have the skill Chorale of Companionship</font>\n");
	else a.append("<font color='red'>You lack the skill Chorale of Companionship: You can acquire it from Chester</font>\n");
	if(have_skill( $skill[Natural Born Scrabbler])) a.append("<font color='green'>You have the skill Natural Born Scrabbler</font>\n");
	else a.append("<font color='red'>You lack the skill Natural Born Scrabbler: You can acquire it by reading Hodgman's journal #1</font>\n");
	if(have_skill( $skill[Thrift and Grift])) a.append("<font color='green'>You have the skill Thrift and Grift</font>\n");
	else a.append("<font color='red'>You lack the skill Thrift and Grift: You can acquire it by reading Hodgman's journal #2</font>\n");
	if(have_skill( $skill[Abs of Tin])) a.append("<font color='green'>You have the skill Abs of Tin</font>\n");
	else a.append("<font color='red'>You lack the skill Abs of Tin: You can acquire it by reading Hodgman's journal #3</font>\n");
	if(have_skill( $skill[Marginally Insane])) a.append("<font color='green'>You have the skill Marginally Insane</font>\n");
	else a.append("<font color='red'>You lack the skill Marginally Insane: You can acquire it by reading Hodgman's journal #4</font>");
	return to_string( a );
}

string book_skills()
{
	buffer a;
	if(have_skill( $skill[Awesome Balls of Fire])) a.append("<font color='green'>You have the skill Awesome Balls of Fire</font>\n");
	else a.append("<font color='red'>You lack the skill Awesome Balls of Fire: You can acquire it by reading Kissin' Cousins</font>\n");
	if(have_skill( $skill[Conjure Relaxing Campfire])) a.append("<font color='green'>You have the skill Conjure Relaxing Campfire</font>\n");
	else a.append("<font color='red'>You lack the skill Conjure Relaxing Campfire: You can acquire it by reading Tales from the Fireside</font>\n");
	if(have_skill( $skill[Snowclone])) a.append("<font color='green'>You have the skill Snowclone</font>\n");
	else a.append("<font color='red'>You lack the skill Snowclone: You can acquire it by reading Blizzards I Have Died In</font>\n");
	if(have_skill( $skill[Maximum Chill])) a.append("<font color='green'>You have the skill Maximum Chill</font>\n");
	else a.append("<font color='red'>You lack the skill Maximum Chill: You can acquire it by reading Maxing, Relaxing</font>\n");
	if(have_skill( $skill[Eggsplosion])) a.append("<font color='green'>You have the skill Eggsplosion</font>\n");
	else a.append("<font color='red'>You lack the skill Eggsplosion: You can acquire it by reading Biddy Cracker's Old-Fashioned Cookbook</font>\n");
	if(have_skill( $skill[Mudbath])) a.append("<font color='green'>You have the skill Mudbath</font>\n");
	else a.append("<font color='red'>You lack the skill Mudbath: You can acquire it by reading Travels with Jerry</font>\n");
	if(have_skill( $skill[Creepy Lullaby])) a.append("<font color='green'>You have the skill Creepy Lullaby</font>\n");
	else a.append("<font color='red'>You lack the skill Creepy Lullaby: You can acquire it by reading Asleep in the Cemetery</font>\n");
	if(have_skill( $skill[Raise Backup Dancer])) a.append("<font color='green'>You have the skill Raise Backup Dancer</font>\n");
	else a.append("<font color='red'>You lack the skill Raise Backup Dancer: You can acquire it by reading Let Me Be!</font>\n");
	if(have_skill( $skill[Inappropriate Backrub])) a.append("<font color='green'>You have the skill Inappropriate Backrub</font>\n");
	else a.append("<font color='red'>You lack the skill Inappropriate Backrub: You can acquire it by reading Sensual Massage for Creeps</font>\n");
	if(have_skill( $skill[Grease Lightning])) a.append("<font color='green'>You have the skill Grease Lightning</font>\n");
	else a.append("<font color='red'>You lack the skill Grease Lightning: You can acquire it by reading Summer Nights</font>");
	return to_string( a );
}*/

void main()
{
//	check_version( "HoboNeeds" , "hoboneeds" , "1.5" , 3627 , 25656 );
	
	table.append( "<TABLE BORDER='1' CELLPADDING='1'>" );
	
	table.append( "<TR><TD colspan=2><B>WOODS</B></TD></TR>");
	table.append( "<TR><TD><B>Falls-From-Sky</B></TD><TD><B>Great Wolf of the Air</B></TD></TR>");
	table.append( "<TR><TD>" + fallsfromsky() + "</TD><TD>" + greatwolf() + "</TD></TR>" );
	table.append( "<TR><TD><B>Bugbears</B></TD><TD><B>Werewolves</B></TD></TR>");
	table.append( "<TR><TD>" +woodsbugbears() + "</TD><TD>" + woodswerewolves() + "</TD></TR>" );
	
	table.append( "<TR><TD colspan=2><B>VILLAGE</B></TD></TR>");
	table.append( "<TR><TD><B>Zombie HOA</B></TD><TD><B>Mayor Ghost</B></TD></TR>");
	table.append( "<TR><TD>" + zombiehoa() + "</TD><TD>" + mayorghost() + "</TD></TR>" );
	table.append( "<TR><TD><B>Zombies</B></TD><TD><B>Ghosts</B></TD></TR>");
	table.append( "<TR><TD>" + villagezombies() + "</TD><TD>" + villageghosts() + "</TD></TR>" );

	table.append( "<TR><TD colspan=2><B>CASTLE</B></TD></TR>");
	table.append( "<TR><TD><B>Count Drunkula</B></TD><TD><B>Unkillable Skeleton</B></TD></TR>");
	table.append( "<TR><TD>" + drunkula() + "</TD><TD>" + unkillable() + "</TD></TR>" );
	table.append( "<TR><TD><B>Vampires</B></TD><TD><B>Skeletons</B></TD></TR>");
	table.append( "<TR><TD>" + castlevampires() + "</TD><TD>" + castleskeletons() + "</TD></TR>" );


	table.append( "</TABLE>" );
	print_html( table.to_string() );

	//print_html( "<B>Hobo Monkey</B>" );
	//if(have_familiar($familiar[Hobo Monkey])) print("You have a hobo monkey in your terrarium" , "green");
	//else print("You do not have a hobo monkey in your terrarium" , "red");
		
	
	/*print_html( "<B>Binder</B>" );
	string binder_text = visit_url("questlog.php?which=5");
	if(index_of(binder_text , "hobo glyphs")!=-1)
	{
		if( contains_text( binder_text , "You have found" ) )
		{
			string [int, int] t;
			t = group_string( binder_text , "found (\\d+) hobo");
			int glyph_num = to_int(t[0][1]);
			if( glyph_num > 0 )
				print( "You have " + glyph_num + " glyph(s)" , "green" );
		}
		else
			print( "You have not yet got any glyphs" , "red" );	
		foreach key in glyph_loc
		{
			if(!binder_text.contains_text(glyph_loc[key]))
				print("You are missing the glyph from " + glyph_loc[key] , "red" );
		}
	}
	else
		print("You have not yet got any glyphs" , "red");
	
	print_html( "<B>Hobo Tattoo</B>" );
	string hobo_tat = visit_url("account_tattoos.php");	
	if(index_of(hobo_tat , "These are the tattoos you have unlocked")!=-1)
	{
		if( contains_text( hobo_tat , "hobotat" ) )
		{
			string [int, int] t;
			t = group_string( hobo_tat , "hobotat(\\d+).gif");
			int tat_num = to_int(t[0][1]);
			if( tat_num > 0 && tat_num < 19 )
			{
				int tat_nic = ( tat_num * 20 ) + 20;
				int tat_tot = 3800 - ( ( ( 10 * tat_num ) + 10 ) * tat_num );
				print( tat_num + " of 19 upgrade(s), " + tat_nic + " nickels needed for the next upgrade, " + tat_tot + " nickels needed for the full tattoo." , "green" );
			}
			else if( tat_num == 19 )
				print( "19 of 19 upgrades, your hobo tattoo is complete!" , "green" );
		}
		else
			print( "You have no parts of the hobo tattoo yet" , "red" );	
	}
	else
		print("You are currently unable to access your tattoos" , "red");
	
	if( qty_to_dc > 0 && !dc_everything )
	{
		foreach i in $items[3116, 3131, 3132, 3133, 3134, 3135, 3136, 3137, 3138, 3139, 3140, 3141, 3132, 3143, 3221, 3222, 3223, 3224, 3225,
		3226, 3227, 3228, 3229, 3230, 3236, 3237, 3238, 3239, 3240, 3241, 3242, 3243, 3244, 3245, 3246, 3247, 3248, 3251, 3252, 3253, 3254, 3255, 3256,
		3257, 3258, 3259, 3260, 3261, 3262, 3284, 3285, 3286, 3310, 3311, 3312, 3313, 3314, 3315, 3316, 3317, 3318, 3319, 3320, 3323, 3324, 3325, 3326,
		3327, 3328, 3329, 3330, 3331, 3332, 3333, 3334, 3335, 3336, 3337, 3338, 3339, 3340, 3341, 3342, 3343, 3344, 3345, 3346, 3347, 3348, 3349, 3350,
		3375, 3376, 3377, 3378, 3379, 3380, 3381, 3382, 3383, 3384, 3385, 3386, 3387, 3388, 3389, 3390, 3391, 3392, 3393, 3394, 3395, 3396, 3397, 3398,
		3399, 3400, 3401, 3402, 3403, 3404, 3405, 3406, 3407, 3408, 3409, 3410, 3411, 3412, 3413, 3414, 3415, 3416, 3422, 3423, 3424, 3425, 3426, 3427,
		3430, 3996, 4020]
		{
			int qty_to_take = display_amount( i ) - qty_to_dc;
			int qty_to_put = qty_to_dc - display_amount( i );
			if ( display_amount ( i ) > qty_to_dc ) 
				take_display ( qty_to_take , i );
			if ( display_amount ( i ) < qty_to_dc && item_amount ( i ) > qty_to_put ) 
				put_display ( qty_to_put , i );
			if ( display_amount ( i ) < qty_to_dc && item_amount ( i ) == qty_to_put ) 
				put_display ( qty_to_put , i );
			if ( display_amount ( i ) < qty_to_dc && item_amount ( i ) < qty_to_put )
				put_display ( item_amount ( i ) , i );
		}
		if ( display_amount ( $item[hobo code binder] ) == 0 && item_amount ( $item[hobo code binder] ) > 0 && hobo_binder )
				put_display ( 1 , $item[hobo code binder] );
		if ( item_amount ( $ item[hobo nickel] ) > 0 && hobo_nickel )
			{
				int qty_to_take = display_amount($item[hobo nickel]) - qty_to_dc;
				int qty_to_put = qty_to_dc - display_amount($item[hobo nickel]);
				if ( display_amount ($item[hobo nickel]) > qty_to_dc ) 
					take_display ( qty_to_take , $item[hobo nickel] );
				if ( display_amount ($item[hobo nickel]) < qty_to_dc && item_amount ($item[hobo nickel]) > qty_to_put ) 
					put_display ( qty_to_put , $item[hobo nickel] );
				if ( display_amount ($item[hobo nickel]) < qty_to_dc && item_amount ($item[hobo nickel]) == qty_to_put ) 
					put_display ( qty_to_put , $item[hobo nickel] );
				if ( display_amount ($item[hobo nickel]) < qty_to_dc && item_amount ($item[hobo nickel]) < qty_to_put )
					put_display ( item_amount ($item[hobo nickel]) , $item[hobo nickel] );
			}
	}
	else if( qty_to_dc == 0 && dc_everything )
	{
		foreach i in $items[3116, 3131, 3132, 3133, 3134, 3135, 3136, 3137, 3138, 3139, 3140, 3141, 3132, 3143, 3221, 3222, 3223, 3224, 3225,
		3226, 3227, 3228, 3229, 3230, 3236, 3237, 3238, 3239, 3240, 3241, 3242, 3243, 3244, 3245, 3246, 3247, 3248, 3251, 3252, 3253, 3254, 3255, 3256,
		3257, 3258, 3259, 3260, 3261, 3262, 3284, 3285, 3286, 3310, 3311, 3312, 3313, 3314, 3315, 3316, 3317, 3318, 3319, 3320, 3323, 3324, 3325, 3326,
		3327, 3328, 3329, 3330, 3331, 3332, 3333, 3334, 3335, 3336, 3337, 3338, 3339, 3340, 3341, 3342, 3343, 3344, 3345, 3346, 3347, 3348, 3349, 3350,
		3375, 3376, 3377, 3378, 3379, 3380, 3381, 3382, 3383, 3384, 3385, 3386, 3387, 3388, 3389, 3390, 3391, 3392, 3393, 3394, 3395, 3396, 3397, 3398,
		3399, 3400, 3401, 3402, 3403, 3404, 3405, 3406, 3407, 3408, 3409, 3410, 3411, 3412, 3413, 3414, 3415, 3416, 3422, 3423, 3424, 3425, 3426, 3427,
		3430, 3996, 4020]
		{
			if ( item_amount (i) > 0) put_display ( item_amount (i), i );
		}
		if ( display_amount ( $item[hobo code binder] ) == 0 && item_amount ( $item[hobo code binder] ) > 0 && hobo_binder )
			put_display ( 1 , $item[hobo code binder] );
		if ( item_amount ( $item[hobo nickel] ) > 0 && hobo_nickel )
			put_display ( item_amount ( $item[hobo nickel] ) , $item[hobo nickel] );
	}
	else if( qty_to_dc > 0 && dc_everything )
		print( "Please edit the script to specify whether you wish to DC all items, or a specified number." , "red" );
		*/
}