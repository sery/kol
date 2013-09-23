# Sary's Cheapest Candy Finder

# BE CAREFUL WITH THIS. Mafia caches mall prices each session, and ONLY refreshes them
# if you call the 'buy' command for 1 or more of the item, though it doesn't matter if you
# successfully purchase or not.
#
# So, this script looks at how much meat you have out, then closets it all.
# It then tries to buy one of each candy. Because you don't have any meat, it fails but
# this refreshes the cached prices. At the end of it all, it takes out the same amount of
# meat from your closet that you had out before.
#
# MAKE SURE the 'Take items from the closet whenever needed' preference is not selected.
# I don't know if it takes meat if needed if this is checked, but better safe than sorry.
#
# USE AT YOUR OWN RISK.
# I AM **NOT** RESPONSIBLE IF YOU GO BROKE BECAUSE THIS SCRIPT ACTUALLY BUYS THINGS.
# I tested it on my account, with only the expected results. Again...
#
# USE AT YOUR OWN RISK
//False if you want to use mall_value as is, True if you want it to check all prices
if(get_property("checkAllBoozePrice")=="") {
	//print("no pref, creating");
	set_property("checkAllBoozePrice", "false");
	}


int [item] sheets;
file_to_map("carriagebooze.txt", sheets);
int bestvalue = 10000;
item bestbooze;
int bestcost;
int bestprice;
buffer output;
int baggedmeat = my_meat();
string usecloset = get_property("autoSatisfyWithCloset");

if (get_property("checkAllBoozePrice") == "true"){
	set_property("autoSatisfyWithCloset", "false");
	put_closet(baggedmeat);
	}
foreach booze, val in sheets {
	if (is_tradeable(booze)){
		if (get_property("checkAllBoozePrice") == "true"){ buy(1,booze);}
		int meatval = mall_price(booze);
		int sheetcost = meatval / val;
		if (sheetcost < bestvalue) {
			bestbooze = booze;
			bestvalue = sheetcost;
			bestcost = val;
			bestprice = meatval;
			}
	//print("Best: " + bestvalue + ", This: " + booze + " - " + val + " sheets, " + meatval + " meat, " + sheetcost + " mps", "blue");
	output.append("<br>");
	output.append("Best: " + bestvalue + ", This: " + booze + " - " + val + " sheets, " + meatval + " meat, " + sheetcost + " mps");
		}
	}

	//print("The best value booze is '" + bestbooze + "' (" + bestcost + " sheets," + bestprice + " meat," + bestvalue + " meat per sheet).");
	output.append("<br>");
	output.append("<font color='blue'>The best value booze is '" + bestbooze + "' (" + bestcost + " sheets," + bestprice + " meat," + bestvalue + " meat per sheet).</font>");
	print("");
	print("");
	print_html(output);
if (get_property("checkAllBoozePrice") == "true"){
	take_closet(baggedmeat);
	set_property("autoSatisfyWithCloset", usecloset);
	}
