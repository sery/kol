import <sry_DreadDistro.ash>

int [string] ignored;
string page;
file_to_map("DungeonLogs/ignoredPlayers.txt",ignored);
//initData();
getCurrentRun();
parseLogs();
parseLoot();
pointsParse();
int [string,string] raw;
int [string] pointsList;
file_to_map("DungeonLogs/pointsView.txt",pointsList);
void parseDistro(){

	file_to_map("DungeonLogs/instances.txt", instances);
	clear(raw);
	foreach instanceID in instances{
		foreach distroID in instances[instanceID].lootDistro {
			
			string fullDistroID = instanceID +"-"+distroID;
			string lootItem = instances[instanceID].lootDistro[distroID].itemName;
			string distroPlayer = instances[instanceID].lootDistro[distroID].playerName;
			
				//lootByPlayer[distroPlayer,item].lootBreakdown[fullDistroID].itemName = lootItem;
				//lootByPlayer[distroPlayer].lootBreakdown[fullDistroID].itemQuant = instances[instanceID].lootDistro[distroID].itemQuant;
			if (!(ignored contains distroPlayer)){
				if (fallsOutfit contains to_item(lootItem)) raw[distroPlayer, "FFSO"] +=1;
				if (lootItem == "Helps-You-Sleep") raw[distroPlayer, "FFS1"] +=1;
				if (lootItem == "Quiets-Your-Steps") raw[distroPlayer, "FFS2"] +=1;
				if (lootItem == "Protects-Your-Junk") raw[distroPlayer, "FFS3"] +=1;
				
				if (gwolfOutfit contains to_item(lootItem)) raw[distroPlayer, "GWO"] +=1;
				if (lootItem == "Great Wolf's rocket launcher") raw[distroPlayer, "GW1"] +=1;
				if (lootItem == "Great Wolf's beastly trousers") raw[distroPlayer, "GW2"] +=1;
				if (lootItem == "Great Wolf's lice") raw[distroPlayer, "GW3"] +=1;
				
				if (mayorOutfit contains to_item(lootItem)) raw[distroPlayer, "MGO"] +=1;
				if (lootItem == "Mayor Ghost's gavel") raw[distroPlayer, "MG1"] +=1;
				if (lootItem == "Mayor Ghost's sash") raw[distroPlayer, "MG2"] +=1;
				if (lootItem == "Mayor Ghost's scissors") raw[distroPlayer, "MG3"] +=1;
				
				if (zhoaOutfit contains to_item(lootItem)) raw[distroPlayer, "ZHAO"] +=1;
				if (lootItem == "HOA regulation book") raw[distroPlayer, "ZHA1"] +=1;
				if (lootItem == "HOA zombie eyes") raw[distroPlayer, "ZHA2"] +=1;
				if (lootItem == "HOA citation pad") raw[distroPlayer, "ZHA3"] +=1;
				if (lootItem == "wriggling severed nose") raw[distroPlayer, "Noses"] +=1;
	
				if (drunkOutfit contains to_item(lootItem)) raw[distroPlayer, "CDO"] +=1;
				if (lootItem == "Drunkula's bell") raw[distroPlayer, "CD1"] +=1;
				if (lootItem == "Drunkula's ring of haze") raw[distroPlayer, "CD2"] +=1;
				if (lootItem == "Drunkula's wineglass") raw[distroPlayer, "CD3"] +=1;
				
				if (uskeleOutfit contains to_item(lootItem)) raw[distroPlayer, "USO"] +=1;
				if (lootItem == "Unkillable Skeleton's sawsword") raw[distroPlayer, "US1"] +=1;
				if (lootItem == "Unkillable Skeleton's shield") raw[distroPlayer, "US2"] +=1;
				if (lootItem == "Unkillable Skeleton's restless leg") raw[distroPlayer, "US3"] +=1;
				
				if (consumablesDrops contains to_item(lootItem)) raw[distroPlayer, "Consumables"] +=1;
				if (lootItem == "skull capacitor") raw[distroPlayer, "Capacitors"] +=1;
				}
			
			}
		
		}
	
	map_to_file(raw,"DungeonLogs/rawloot.txt");
	
}

/*void numberCruncher(){
	int[int,string,string]raw2;
	matcher m=create_matcher("^([A-WY-Z]+)([\\dX])$","");
	//foreach clanName,clanNum in raw[0,".union"]{
		file_to_map("rawloot.txt",raw2);
 	foreach user in raw2 if(user.char_at(0)!=".") foreach thing,val in raw2[user] if(thing.char_at(0)!=".")raw[user,thing]+=val;
		else raw[user,thing]=val;
		}
 	foreach user in raw if(user.char_at(0)!="."){
  		raw[user,".points"]=0;
  		foreach thing in pointList raw[user,".points"]+=round(raw[user,thing]*raw[".weight",thing]/10.0);
		foreach thing in $strings[FFS,GW,ZHA,MG,CD,US]{
   		raw[user,"Loot"]+=raw[user,thing+"O"];
   		for i from 1 to 3 raw[user,"HM Loot"]+=raw[user,thing+i];
	}*/
  
string linkName(string u){
 return "<a href=\"showplayer.php?who="+get_player_id(u)+"\">"+u+"</a>";
}

void addDefs(){
 if(!(raw[".weight"] contains ".adjust"))raw[".weight",".adjust"]=10;
 if(!(raw[".weight"] contains ".-adjust"))raw[".weight",".-adjust"]=10;
 if(!(raw[".weight"] contains "Bosses"))raw[".weight","Bosses"]=10000;
 if(!(raw[".weight"] contains "Boss Losses"))raw[".weight","Boss Losses"]=0;
 if(!(raw[".weight"] contains "Kills"))raw[".weight","Kills"]=10;
 if(!(raw[".weight"] contains "Losses"))raw[".weight","Losses"]=0;
 if(!(raw[".weight"] contains "Noncombats"))raw[".weight","Noncombats"]=0;
 if(!(raw[".weight"] contains "Sheets"))raw[".weight","Sheets"]=0;
 if(!(raw[".weight"] contains "Unlocks"))raw[".weight","Unlocks"]=0;
 if(!(raw[".weight"] contains "Loot"))raw[".weight","Loot"]=10000;
 if(!(raw[".weight"] contains "HM Loot"))raw[".weight","HM Loot"]=10000;
 if(!(raw[".weight"] contains "Capacitors"))raw[".weight","Capacitors"]=0;
 if(!(raw[".weight"] contains "Noses"))raw[".weight","Noses"]=0;
 if(!(raw[".weight"] contains "Consumables"))raw[".weight","Consumables"]=0;
}

string lootListCM(){
 string o='"FFS":{name: "Falls-From-Sky", accesskey:"f", items: {"FFSX":{name: "Outfit"},"FFS1":{name: "Helps-You-Sleep"},"FFS2":{name: "Quiets-Your-Step"},"FFS3":{name: "Protects-Your-Junk"}} },';
 o+='"GW":{name: "Great Wolf", accesskey:"g", items: {"GWX":{name: "Outfit"},"GW1":{name: "Rocket Launcher"},"GW2":{name: "Beastly Trousers"},"GW3":{name: "Lice"}} },';
 o+='"ZHA":{name: "Zombie HOA", accesskey:"z", items: {"ZHAX":{name: "Outfit"},"ZHA1":{name: "Regulation Book"},"ZHA2":{name: "Zombie Eyes"},"ZHA3":{name: "Citation Pad"}} },';
 o+='"MG":{name: "Mayor Ghost", accesskey:"m", items: {"MGX":{name: "Outfit"},"MG1":{name: "Gavel"},"MG2":{name: "Sash"},"MG3":{name: "Scissors"}} },';
 o+='"CD":{name: "Count Drunkula", accesskey:"d", items: {"CDX":{name: "Outfit"},"CD1":{name: "Bell"},"CD2":{name: "Ring"},"CD3":{name: "Wineglass"}} },';
 o+='"US":{name: "Unkillable Skeleton", accesskey:"s", items: {"USX":{name: "Outfit"},"US1":{name: "Sawsword"},"US2":{name: "Shield"},"US3":{name: "Restless Leg"}} },';
 o+='"Capacitors":{name: "Skull Capacitor"},"Noses":{name: "Wriggling Nose"}';
 return o;
}

void lootPageHeader(){
	writeln("<html><head><script type=\"text/javascript\" language=\"Javascript\" src=\"jquery-1.10.2.min.js\"></script>");
	writeln("<script type=\"text/javascript\" language=\"Javascript\" src=\"jquery.contextMenu.js\"></script>");
	writeln("<link rel=\"stylesheet\" type=\"text/css\" href=\"jquery.contextMenu.css\"><style type=\"text/css\">");
	//writeln(".directory td,.directory th{font-size:11px;border:0px;border-collapse:separate;padding:0px 10px;}");
	//writeln(".submit{font-size:11px;border:0px;border-collapse:separate;padding:0px 0px;background:transparent;text-decoration:underline;cursor:pointer;}");
	writeln("td.hideBox{height:20px;}");
	writeln("td.hideBox input{display:none;}");
	writeln("td.hideBox:hover input,td.hideBox input:checked{float:right; display:inline; -ms-transform: scale(0.75,0.75); -moz-transform: scale(0.75,0.75); -webkit-transform: scale(0.75,0.75); -o-transform: scale(0.75); margin:0px; border:1px;}");
	writeln(".opts td{text-decoration:underline}");
	writeln(".tableD, .runTable, .userTable{font-size:11px;border:1px solid;border-spacing:0px;border-collapse:separate;background-color:#FFFFFF;width:100%;}");
	writeln(".rowD th,.rowD td{font-size:11px;text-align:center;padding:0px 3px;}");
	writeln(".inner{overflow-x:scroll;margin-left:153px;margin-top:1px;}");
	writeln("table.lootTable{font-size:11px;border:none;border-spacing:0px;border-collapse:collapse;background-color:#FFFFFF;table-layout:fixed;}");
	writeln("table.lootTable tr td{border:1px solid;border-spacing:0px;text-align:center;}");
	writeln("table.lootTable tr th{width:150px;margin-top:-1px;border:1px solid;border-spacing:0px;text-align:left;position:absolute;left:5;}");
	writeln("table.lootTable tr:nth-child(2n+4) td{background-color:#00CCFF;}");
	writeln("table.lootTable tr:nth-child(n+4) td{width:35px;}");
	writeln("table.lootTable tr:nth-child(n+4) td:nth-child(4n-2),td.outfit{background-color:#0066FF;}");
	writeln("table.sortable tbody tr:nth-child(even) td{background-color:#FFFFFF !important}");
	writeln(".userTable {width:50%;}");
	writeln("table.userTable tr td{background-color:#E3E2EA;text-align:left;}");
	writeln("table.userTable tr td:nth-child(2){width:10%;}");
	writeln("table.runTable tr th{font-weight:bold;color:white;background-color:#303030;text-align:left;}");
	writeln("table.runTable tr td{background-color:#989898;text-align:left;}");
	writeln("select, select option{font-size:11px;}");
	writeln(".rowL th,.rowL td{font-size:9px;text-align:left;padding:0px 3px;}");

	writeln(".TST{border-color:black;}");
	writeln(".TSI{font-weight:bold;color:white;background-color:#17037D;}");
	writeln(".TSO{background-color:#E3E2EA;}");

	writeln(".PosT{border-color:green;}");
	writeln(".PosI{font-weight:bold;color:white;background-color:#254117;}");
	writeln(".PosO{background-color:#609060;}");

	writeln(".NegI{font-weight:bold;color:white;background-color:#D93636;}");
	writeln(".NegO{background-color:#FDC5C5;}");

	writeln(".ZeroI{font-weight:bold;color:white;background-color:#303030;}");
	writeln(".ZeroO{background-color:#989898;}");

	writeln(".LootC{color:#303030;}");
	writeln(".LootT{border-color:#CFB53B;}");
	writeln(".LootE{background-color:#A8A8A8;}");
	writeln(".context-menu-item{padding:2px 2px 2px 5px !important;}");
	writeln("</style>");
	writeln("<script language=\"Javascript\" type=\"text/javascript\" src=\"sorttable.js\"></script>");
	writeln("<script language=\"Javascript\" type=\"text/javascript\">$(window).load(function(){");
	writeln("$(function(){$.contextMenu({selector:'.player',callback:function(key,options){if(options.inputs.adjust.$input[0].value!=''){window.location.assign('"+__FILE__+"?adjust='+key+'&who='+this[0].getAttribute(\"id\")+'&to='+options.inputs.adjust.$input[0].value);}},items:{ \"ignore\": {name: \"Ignore\", callback: function(key,options){window.location.assign('"+__FILE__+"?removePlayer='+this[0].getAttribute(\"id\"));}}, \"sep1\": \"---------\", \"adjust\": {name: \"Adjust Value\", type:\"text\", value:\"\"}, \".adjust\": {name: \"Adjustments (Green)\"}, \".-adjust\": {name: \"Adjustments (Red)\"}, \"sep2\":\"---------\", "+lootListCM()+" }, events: {show: function(opt){var d=document.getElementsByClassName('context-menu-list')[0].firstChild.firstChild; d.innerHTML=\"Ignore \"+this[0].getAttribute(\"id\");} } })});");
	writeln("$(function(){$.contextMenu({selector:'.weight',callback:function(key,options){},items:{ \"weight\": {name: \"Edit Weight\", type:\"text\", value:\"\" }, \"submit\": {name: \"Change\", callback: function(key,options){if(options.inputs.weight.$input[0].value!=''){window.location.assign('"+__FILE__+"?change='+this[0].getAttribute(\"id\")+'&to='+options.inputs.weight.$input[0].value);}}}}})});");
	writeln("});function tog(e){ var i=document.getElementById(e);if(i.style.display=='none'){i.style.display='inline';}else{i.style.display='none';}}");
	writeln("function hideAll(){['point','distro','history'].forEach(function(name){var i1=document.getElementById(name+'Tab'); if(i1==null)return; i1.style.textDecoration='underline'; i1.style.cursor='pointer'; i1=document.getElementById(name+'Div'); if(i1==null)return; i1.style.display='none';});}");
	writeln("function show(e){hideAll(); var i1=document.getElementById(e+'Div'); i1.style.display='inline'; i1=document.getElementById(e+'Tab'); i1.style.textDecoration='none'; i1.style.cursor='default';}");
	writeln("</script>");
	 matcher m=create_matcher("<link[^>]+>",page);
	if(m.find())writeln(m.group(0));
	writeln("</head><body>");
	//write("<center><table class=\"directory\"><tr>");
	//write("<td style=\"text-decoration:none; cursor:default;\" id=\"pointTab\" onclick=\"show('point');\">Points</td>");
	//write("<td style=\"text-decoration:underline; cursor:pointer;\" id=\"distroTab\" onclick=\"show('distro');\">Distro</td>");
	//write("<td style=\"text-decoration:underline; cursor:pointer;\" id=\"historyTab\" onclick=\"show('history');\">Data</td>");
	//writeln("</tr></table></center>");
}

	
void displayDistro(){
	//map_to_file(raw,"DungeonLogs/rawloot.txt");
	item[int]drops;
	for i from 0 to 20 drops[i]=to_item(i+6440);
	for i from 21 to 40 drops[i]=to_item(i+6441);
	drops[41]=$item[electric kool-aid];
	drops[44]=$item[skull capacitor];
	drops[45]=drops[20];
	drops[46]=drops[6];
	int maxFor(string a){
  		switch(a){
			case"O":return 3;
			case"Capacitors":return 5;
			case"1":case"2":case"3":case"Noses":return 0;
  			}
		return 500;
		}
	string toBossName(int i){
		switch(i){
			case 0:return "Falls-From-Sky";
			case 1:return "Great Wolf of the Air";
			case 2:return "Zombie Homeowner's Association";
			case 3:return "Mayor Ghost";
			case 4:return "Count Drunkula";
			}
		return "The Unkillable Skeleton";
		}
	write("<div id=\"distroDiv\" style=\"display:none;\"><div class=\"inner\"><table class=\"lootTable\"><tr><th style=\"border:0px\"></th>");
	for i from 0 to 5 write("<td class=\"outfit\"><img title=\""+drops[i*7]+"\" src=\"images/itemimages/"+drops[i*7].image+"\"></td><td rowspan=\"2\" colspan=\"3\" style=\"text-align:center\">"+i.toBossName()+"</td>");
	for i from 3 downto 1 write("<td><img title=\""+drops[i*7+20]+"\" src=\"images/itemimages/"+drops[i*7+20].image+"\"></td>");
	write("</tr><tr><th style=\"border:0px\"></th>");
	for i from 0 to 5 write("<td class=\"outfit\"><img title=\""+drops[i*7+1]+"\" src=\"images/itemimages/"+drops[i*7+1].image+"\"></td>");
	write("<td colspan=\"2\" style=\"border:0px\"></td><td><img title=\""+drops[13]+"\" src=\"images/itemimages/"+drops[13].image+"\"></td></tr><tr><th style=\"border:0px\"></th>");
	for i from 2 to 46 if((i%7>1)&&(i%7<6))write("<td"+(i%7==2?" class=\"outfit\"":"")+"><img title=\""+drops[i]+"\" src=\"images/itemimages/"+drops[i].image+"\"></td>");
	foreach user in raw if(!(ignored contains user)){
		write("</tr><tr><th>"+user+"</th>");
		foreach a in $strings[FFS,GW,ZHA,MG,CD,US] foreach b in $strings[O,1,2,3] write("<td><span"+(raw[user,a+b]>b.maxFor()?" style=\"font-weight:bold\">":">")+raw[user,a+b]+"</span></td>");
				//write("<td><span"+(lootByPlayer[>b.maxFor()?" style=\"font-weight:bold\">":">")+raw[0,user,a+b]+"</span></td>");
  		foreach a in $strings[Capacitors,Noses,Consumables] write("<td><span"+(raw[user,a]>a.maxFor()?" style=\"font-weight:bold\">":">")+raw[user,a]+"</span></td>");
  		}
	writeln("</tr></table></div></div>");
	}
	
	
/*void main(){
	if(get_clan_id()==0){
		write("No clan!</body>");
		return;
		}
	file_to_map("DungeonLogs/rawloot.txt",raw);
	//print("parse start","blue");
	parseDistro();
	//print("parse end","blue");
	page=visit_url("clan_oldraidlogs.php?startrow=0");
	//print("header start","blue");
	//lootPageHeader();
 	//print("header end","blue");
	//addDefs();
 //if(raw[0,".","lastRun"]==0)initData();
 //addNewRuns();
 //checkFF();
 //addProgressRun();
 //numberCruncher();
 	print("display start","blue");
	displayDistro();
	print("display end","blue");
	writeln("</body>");
	print("done","blue");
	}*/
	
void main(){
	file_to_map("DungeonLogs/rawloot.txt",raw);
	foreach user, int in ignored {remove raw[user];}
	parseDistro();
	
	item[int]drops;
	for i from 0 to 20 drops[i]=to_item(i+6440);
	for i from 21 to 40 drops[i]=to_item(i+6441);
	drops[41]=$item[electric kool-aid];
	drops[44]=$item[skull capacitor];
	drops[45]=drops[20];
	drops[46]=drops[6];
	
	int maxFor(string a){
  		switch(a){
			case"O":return 3;
			case"Capacitors":return 5;
			case"1":case"2":case"3":case"Noses":return 0;
  			}
		return 500;
		}
		
	string toBossName(int i){
		switch(i){
			case 0:return "Falls-From-Sky";
			case 1:return "Great Wolf";
			case 2:return "Zombie HOA";
			case 3:return "Mayor Ghost";
			case 4:return "Count Drunkula";
			}
		return "Unkillable Skeleton";
		}
		
	writeln("<html><head><style>"+
			"table {"+
				"font-family:Verdana,Geneva,sans-serif;"+
				"font-size:0.75em;"+
				"border-collapse:collapse;"+
				"}"+
			"td th {"+
				"border: 1px solid black;"+
				"}"+
			"img {"+
				"height: 66%;"+
				"width: 66%;"+
				"}"+
			"</style></head>");
	
	writeln("<body>");
	
	//write("<div id=\"distroDiv\" style=\"display:none;\"><div class=\"inner\"><table class=\"lootTable\"><tr><th style=\"border:0px\"></th>");
	writeln("<table><tr><td></td>");
	//for i from 0 to 5 write("<td class=\"outfit\"><img title=\""+drops[i*7]+"\" src=\"images/itemimages/"+drops[i*7].image+"\"></td><td rowspan=\"2\" colspan=\"3\" style=\"text-align:center\">"+i.toBossName()+"</td>");
	for i from 0 to 5 write("<td><img title='"+drops[i*7]+"' src='images/itemimages/"+drops[i*7].image+"'></td><td rowspan='2' colspan='3'>"+i.toBossName()+"</td>");
	//for i from 3 downto 1 write("<td><img title=\""+drops[i*7+20]+"\" src=\"images/itemimages/"+drops[i*7+20].image+"\"></td>");
	for i from 3 downto 1 write("<td><img title='"+drops[i*7+20]+"' src='images/itemimages/"+drops[i*7+20].image+"'></td>");
	//write("</tr><tr><th style=\"border:0px\"></th>");
	write("</tr><tr><td></td>");
	//for i from 0 to 5 write("<td class=\"outfit\"><img title=\""+drops[i*7+1]+"\" src=\"images/itemimages/"+drops[i*7+1].image+"\"></td>");
	for i from 0 to 5 write("<td class='outfit'><img title='"+drops[i*7+1]+"' src='images/itemimages/"+drops[i*7+1].image+"'></td>");
	write("<td colspan='2'></td><td><img title='"+drops[13]+"' src='images/itemimages/"+drops[13].image+"'></td></tr><tr><td></td>");
	for i from 2 to 46 if((i%7>1)&&(i%7<6))write("<td"+(i%7==2?" class='outfit'":"")+"><img title='"+drops[i]+"' src='images/itemimages/"+drops[i].image+"'></td>");
	foreach user in raw if(!(ignored contains user)){
		write("</tr><tr><th>"+user+"</th>");
		foreach a in $strings[FFS,GW,ZHA,MG,CD,US] foreach b in $strings[O,1,2,3] write("<td><span"+(raw[user,a+b]>b.maxFor()?" >":">")+raw[user,a+b]+"</span></td>");
				//write("<td><span"+(lootByPlayer[>b.maxFor()?" style='font-weight:bold'>":">")+raw[0,user,a+b]+"</span></td>");
  		foreach a in $strings[Capacitors,Noses,Consumables] write("<td><span"+(raw[user,a]>a.maxFor()?">":">")+raw[user,a]+"</span></td>");
  		}
	writeln("</tr></table></div></div>");
	
}