import <clan_raidlogs.ash>
/*
Taken symobls:
string[string] FF=form_fields();
string[string] contexts;
string page;
string[int] layout;
int[string,string,string] data;
string[string] players;
int[int,string,string] odata;
string[string] options;
int runType=-1;
boolean activeComment=false;
string clearID="!Made it<br>Through";
string[string,string] theMatcher;
*/
int[int,string,string] raw;
string runRowMatcher="<tr><td class=small>([^&]+)&nbsp;&nbsp;</td><td class=small>([^&]+)&nbsp;&nbsp;</td><td class=small>([^&]+)[^v]+[^=]+=(\\d+)";
activeComment=false;
boolean[string] pointList=$strings[Kills,Bosses,Unlocks,Sheets,Noncombats,Losses,Boss Losses,.adjust];
boolean[string] lootList=$strings[Loot,HM Loot,Capacitors,Noses,Consumables,.-adjust];

int lookupClanId(string c){
 string page=visit_url("clan_signup.php?action=search&whichfield=1&searchstring="+c);
 matcher m=create_matcher("(?i)whichclan=(\\d+)\">"+c+"<",page);
 if(m.find())return m.group(1).to_int();
 return 0;
}

void toggleRun(int clan, int run){
 int m=1;
 map_to_file(raw,"raidlog/dreadKP."+get_clan_id()+".txt");
 file_to_map("raidlog/dreadKP."+clan+".txt",raw);
 if(!(raw contains run))return;
 if(raw[run,".","ignore"]==1)remove raw[run,".","ignore"];
 else{
  m=-1;
  raw[run,".","ignore"]=1;
 }
 foreach user,thing,val in raw[run] if((user.char_at(0)!=".")&&(thing.char_at(0)!="."))raw[0,user,thing]+=m*val;
 map_to_file(raw,"raidlog/dreadKP."+clan+".txt");
 file_to_map("raidlog/dreadKP."+get_clan_id()+".txt",raw);
}



void initData(){
 print("first time, might take a while","olive");
 print("getting clan runs");
 buffer allRuns;
 buffer nextPage;
 int row=0;
 repeat{
  nextPage=visit_url("clan_oldraidlogs.php?startrow="+row);
  allRuns.append(nextPage);
  row+=10;
 }until(nextPage.contains_text("gray>next"));
 print("parsing runs");
 matcher m=create_matcher(runRowMatcher,allRuns);
 while(m.find()){
 	addRun(m.group(4).to_int(),m.group(3),m.group(1),m.group(2));
 	print(m);}
 raw[0,".clanName",get_clan_name()]=1;
 map_to_file(raw,"raidlog/dreadKP."+get_clan_id()+".txt");
 print("initialization complete","blue");
}

void numberCruncher(){
 int[int,string,string]raw2;
 matcher m=create_matcher("^([A-WY-Z]+)([\\dX])$","");
 foreach clanName,clanNum in raw[0,".union"]{
  file_to_map("raidlog/dreadKP."+clanNum+".txt",raw2);
  foreach user in raw2[0] if(user.char_at(0)!=".") foreach thing,val in raw2[0,user]if(thing.char_at(0)!=".")raw[0,user,thing]+=val;
  else raw[0,user,thing]=val;
 }
 foreach user in raw[0] if(user.char_at(0)!="."){
  raw[0,user,".points"]=0;
  foreach thing in pointList raw[0,user,".points"]+=round(raw[0,user,thing]*raw[0,".weight",thing]/100.0);
  foreach thing in $strings[FFS,GW,ZHA,MG,CD,US]{
   raw[0,user,"Loot"]+=raw[0,user,thing+"X"];
   for i from 1 to 3 raw[0,user,"HM Loot"]+=raw[0,user,thing+i];
  }
  raw[0,user,".total"]=raw[0,user,".points"];
  foreach thing in lootList raw[0,user,".total"]-=round(raw[0,user,thing]*raw[0,".weight",thing]/100.0);
  raw[0,user,".combined"]=raw[0,user,".total"];
 }
 foreach user in raw[-1] if(user.char_at(0)!="."){
  raw[-1,user,".points"]=0;
  foreach thing in pointList raw[-1,user,".points"]+=round(raw[-1,user,thing]*raw[0,".weight",thing]/100.0);
  foreach thing in $strings[FFS,GW,ZHA,MG,CD,US]{
   raw[-1,user,"Loot"]+=raw[-1,user,thing+"X"];
   for i from 1 to 3 raw[-1,user,"HM Loot"]+=raw[-1,user,thing+i];
  }
  raw[-1,user,".total"]=raw[-1,user,".points"];
  foreach thing in lootList raw[-1,user,".total"]-=round(raw[-1,user,thing]*raw[0,".weight",thing]/100.0);
  raw[0,user,".combined"]+=raw[-1,user,".total"];
 }
 foreach user in raw[0] if(user.char_at(0)!=".")foreach thing in lootList if(thing!=".-adjust") raw[0,user,".loot"]+=raw[-1,user,thing]+raw[0,user,thing];
}

string linkName(string u){
 return "<a href=\"showplayer.php?who="+raw[0,u,".id"]+"\">"+u+"</a>";
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
 writeln(".directory td,.directory th{font-size:11px;border:0px;border-collapse:separate;padding:0px 10px;}");
 writeln(".submit{font-size:11px;border:0px;border-collapse:separate;padding:0px 0px;background:transparent;text-decoration:underline;cursor:pointer;}");
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
 write("<center><table class=\"directory\"><tr>");
 write("<td style=\"text-decoration:none; cursor:default;\" id=\"pointTab\" onclick=\"show('point');\">Points</td>");
 write("<td style=\"text-decoration:underline; cursor:pointer;\" id=\"distroTab\" onclick=\"show('distro');\">Distro</td>");
 write("<td style=\"text-decoration:underline; cursor:pointer;\" id=\"historyTab\" onclick=\"show('history');\">Data</td>");
 writeln("</tr></table></center>");
}

string toSimpleDec(int i){
 if(i==0)return "";
 string r=to_string(i/100.0)+"0";
 if(i<1)r=r.substring(0,5);
 else r=r.substring(0,4);
 while(r.char_at(r.length()-1)=="0")r=r.substring(0,r.length()-1);
 if(r.char_at(r.length()-1)==".")r=r.substring(0,r.length()-1);
 r=" ("+r+")";
 return r;
}

void displayPoints(){
 write("<div id=\"pointDiv\" style=\"display:inline;\"><center><form action=\""+__FILE__+"\"><table class=\"tableD ZeroT\"><tr class=\"RowD\"><td class=\"ZeroI\" onclick=\"tog('LootTable')\">"+raw[0].pullField(".clanName")+" Loot Deductions</td></tr>");
 write("<tr><td><center><div id=\"LootTable\" style=\"display:inline;\"><table class=\"sortable tableD TST\"><tr><th class=\"TSI\">Players</th>");
 write("<th class=\"PosI\">Points Earned</th>");
 foreach thing in lootList if(thing!=".-adjust") write("<th id=\""+thing+"\" class=\"weight "+(raw[0,".weight",thing]>0?"NegI":(raw[0,".weight",thing]<0?"PosI":"ZeroI"))+"\">"+thing+raw[0,".weight",thing].toSimpleDec()+"</th>");
 write("<th class=\"NegI\">Adjustments</th><th class=\"TSI\">Points</th><th class=\"TSI\">(With Current)</th></tr>");
 foreach user in raw[0] if(user.char_at(0)!="."){
  if(raw[0,user,".ignore"]==1)continue;
  if((raw[0,user,".points"]==0)&&(raw[0,user,".total"]==0))continue;
  odata[count(odata)+1,".data"]=raw[0,user];
  odata[count(odata),".name",user]=1;
 }
 sort odata by -value[".data",".combined"];
 foreach index in odata{
  write("<tr class=\"RowD player\" id=\""+odata[index].pullField(".name")+"\"><td class=\"TSO hideBox\" style=\"text-align:left\">"+odata[index].pullField(".name").linkName()+"<input type=\"checkbox\" name=\"ignores[]\" value=\""+odata[index].pullField(".name")+"\"></td>");
  write("<td class=\"PosO\">"+odata[index,".data",".points"]+"</td>");
  foreach thing in lootList {
   write("<td class=\""+(raw[0,".weight",thing]>0?"NegO":(raw[0,".weight",thing]<0?"PosO":"ZeroO"))+"\">"+odata[index,".data",thing]+"</td>");
   if((raw[0,".weight",thing]!=0)&&(thing!=".-adjust"))raw[0,".total",".loot"]+=odata[index,".data",thing];
  }
  write("<td class=\"TSO\">"+odata[index,".data",".total"]+"</td><td class=\"TSO\">"+odata[index,".data",".combined"]+"</tr>");
 }
 writeln("</table></div></center></td></tr></table><br>");//<--End Loot Table, Begin Point Table
 write("<table class=\"tableD ZeroT\"><tr class=\"RowD\"><td class=\"ZeroI\" onclick=\"tog('PointsTable')\">"+raw[0].pullField(".clanName")+" Loot Points</td></tr>");
 write("<tr><td><center><div id=\"PointsTable\" style=\"display:inline;\"><table class=\"sortable tableD TST\"><tr><th class=\"TSI\">Players</th>");
 foreach thing in pointList if(thing!=".adjust") write("<th id=\""+thing+"\" class=\"weight "+(raw[0,".weight",thing]<0?"NegI":(raw[0,".weight",thing]>0?"PosI":"ZeroI"))+"\">"+thing+raw[0,".weight",thing].toSimpleDec()+"</th>");
 write("<th class=\"PosI\">Adjustments</th><th class=\"TSI\">Earned Points</th></tr>");
 clear(odata);
 foreach user in raw[0] if(user.char_at(0)!="."){
  if(raw[0,user,".ignore"]==1)continue;
  if(raw[0,user,".points"]==0)continue;
  odata[count(odata)+1,".data"]=raw[0,user];
  odata[count(odata),".name",user]=1;
 }
 sort odata by -value[".data",".points"];
 foreach index in odata{
  write("<tr class=\"RowD player\" id=\""+odata[index].pullField(".name")+"\"><td class=\"TSO hideBox\" style=\"text-align:left\">"+odata[index].pullField(".name").linkName()+"<input type=\"checkbox\" name=\"ignores[]\" value=\""+odata[index].pullField(".name")+"\"></td>");
  foreach thing in pointList
   write("<td class=\""+(raw[0,".weight",thing]<0?"NegO":(raw[0,".weight",thing]>0?"PosO":"ZeroO"))+"\">"+odata[index,".data",thing]+"</td>");
  write("<td class=\"TSO\">"+odata[index,".data",".points"]+"</td></tr>");
  raw[0,".total",".points"]+=odata[index,".data",".points"];
 }
 write("<tfoot><tr class=\"RowD\"><td class=\"TSI\">Totals</td><td class=\"PosI\" colspan=\"2\">Points Earned</td><td class=\"PosO\">"+raw[0,".total",".points"]+"</td>");
 write("<td class=\"NegI\" colspan=\"2\">Amount of Loot</td><td class=\"NegO\">"+raw[0,".total",".loot"]+"</td>");
 write("<td class=\"TSI\" colspan=\"2\">Zero Sum Value</td><td class=\"TSO\">"+(raw[0,".total",".points"]*1.0/raw[0,".total",".loot"]).to_string()+"</td></tr></tfoot>");
 writeln("</table></div></center></td></tr></table><br>");
 write("<input type=\"submit\" name=\"ignoreSelected\" value=\"Ignore Selected\"><br>");
 write("Above table includes: "+raw[0].pullField(".clanName"));
 foreach clanName in raw[0,".union"] write(", "+clanName);
 write("<br>Add another clan: <input type=\"text\" name=\"addClan\"></input>");
 write("<input type=\"submit\" value=\"Add!\"></form>");//Current Run Below
 write("<table class=\"tableD ZeroT\"><tr class=\"RowD\"><td class=\"ZeroI\" onclick=\"tog('PointsTable')\">"+raw[0].pullField(".clanName")+" Current Run</td></tr>");
 write("<tr><td><center><div id=\"PointsTable\" style=\"display:inline;\"><table class=\"sortable tableD TST\"><tr><th class=\"TSI\">Players</th>");
 foreach thing in pointList if(thing!=".adjust"){
  write("<th class=\""+(raw[0,".weight",thing]<0?"NegI":(raw[0,".weight",thing]>0?"PosI":"ZeroI"))+"\">");
  write(thing+raw[0,".weight",thing].toSimpleDec()+"</th>");
 }
 foreach thing in lootList if(thing!=".-adjust"){
  write("<th class=\""+(raw[0,".weight",thing]>0?"NegI":(raw[0,".weight",thing]<0?"PosI":"ZeroI"))+"\">");
  write(thing+raw[0,".weight",thing].toSimpleDec()+"</th>");
 }
 write("<th class=\"TSI\">Total Points</th></tr>");
 clear(odata);
 foreach user in raw[-1] if(user.char_at(0)!="."){
  if(raw[0,user,".ignore"]==1)continue;
  if(raw[-1,user,".total"]==0)continue;
  odata[count(odata)+1,".data"]=raw[-1,user];
  odata[count(odata),".name",user]=1;
 }
 sort odata by -value[".data",".total"];
 foreach index in odata{
  write("<tr class=\"RowD\"><td class=\"TSO hideBox\" style=\"text-align:left\" oncontextmenu=\"removePlayer('"+odata[index].pullField(".name")+"'); return false;\">"+odata[index].pullField(".name").linkName()+"</td>");
  foreach thing in pointList if(thing!=".adjust")
   write("<td class=\""+(raw[0,".weight",thing]<0?"NegO":(raw[0,".weight",thing]>0?"PosO":"ZeroO"))+"\">"+odata[index,".data",thing]+"</td>");
  foreach thing in lootList if(thing!=".-adjust")
   write("<td class=\""+(raw[0,".weight",thing]>0?"NegO":(raw[0,".weight",thing]<0?"PosO":"ZeroO"))+"\">"+odata[index,".data",thing]+"</td>");
  write("<td class=\"TSO\">"+odata[index,".data",".total"]+"</td></tr>");
 }
 writeln("</table></div></center></td></tr></table></center></div>");
}

void displayDistro(){
 item[int]drops;
 for i from 0 to 20 drops[i]=to_item(i+6440);
 for i from 21 to 40 drops[i]=to_item(i+6441);
 drops[41]=$item[electric kool-aid];
 drops[44]=$item[skull capacitor];
 drops[45]=drops[20];
 drops[46]=drops[6];
 int maxFor(string a){
  switch(a){
   case"X":return 2;
   case"Capacitors":return 4;
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
 foreach user in raw[0] if((raw[0,user,".loot"]>0)&&(raw[0,user,".ignore"]!=1)&&(user.char_at(0)!=".")){
  write("</tr><tr><th>"+user+"</th>");
  foreach a in $strings[FFS,GW,ZHA,MG,CD,US] foreach b in $strings[X,1,2,3] write("<td><span"+(raw[0,user,a+b]>b.maxFor()?" style=\"font-weight:bold\">":">")+raw[0,user,a+b]+"</span></td>");
  foreach a in $strings[Capacitors,Noses,Consumables] write("<td><span"+(raw[0,user,a]>a.maxFor()?" style=\"font-weight:bold\">":">")+raw[0,user,a]+"</span></td>");
 }
 writeln("</tr></table></div></div>");
}

void displayDataLogs(){
 write("<div id=\"historyDiv\" style=\"display:none;\"><center><table class=\"runTable sortable\">");
 string[string,int,int]runs;
 int[int,string,string]raw2;
 foreach clanName,clanNum in raw[0,".union"]{
  file_to_map("raidlog/dreadKP."+clanNum+".txt",raw2);
  foreach i in raw2 if(raw2[i,".type","Dreadsylvania"]==1) runs[clanName,clanNum,i]=raw2[i].pullField(".date");
 }
 foreach i in raw if((i>0)&&(raw[i,".type","Dreadsylvania"]==1))runs[get_clan_name(),get_clan_id(),i]=raw[i].pullField(".date");
 write("<tr><th>Clan</th><th>ID</th><th>Start</th><th>End</th><th colspan=\"2\">Edit</th></tr>");
 matcher m=create_matcher("(.+?) to (.*)","");
 foreach clanName,clanNum,i,date in runs {
  m.reset(date);
  write("<tr><td>"+clanName+"</td><td>"+i+"</td>");
  if(m.find())write("<td>"+m.group(1)+"</td><td>"+m.group(2)+"</td>");
  else write("<td></td><td></td>");
  write("<td>[<a href=\""+__FILE__+"?toggleRun="+i+"&fromClan="+clanNum+"\">"+(raw[i,".","ignore"]==1?"add":"remove")+"</a>]</td>");
  write("<td>[<a href=\""+__FILE__+"?recountRun="+i+"&fromClan="+clanNum+"\">recount</a>]</td></tr>");
 }
 writeln("</table><br></center>");
 write("<form action=\""+__FILE__+"\"><input type=\"submit\" name=\"unignoreSelected\" value=\"Unignore Selected\"><br><table class=\"userTable sortable\"><tr><th>Ignored Users</th><th class=\"sorttable_nosort\">Unignore</th></tr>");
 foreach user in raw[0] if(raw[0,user,".ignore"]==1){
  write("<tr><td>"+user+"</td><td><input name=\"ignores[]\" type=\"checkbox\" value=\""+user+"\"></td></tr>");
 }
 writeln("</table>");
 write("<input type=\"submit\" name=\"unignoreSelected\" value=\"Unignore Selected\"></form></div>");
}

void displayTables(){
 displayPoints();
 displayDistro();
 displayDataLogs();
}

void checkFF(){
 int i;
 if((FF contains "change")&&(FF contains "to")){
  i=to_int(FF["to"].expression_eval()*100);
  i=min(max(-99999,i),99999);
  raw[0,".weight",FF["change"]]=i;
 }
 if(FF contains "addClan"){
  i=lookupClanId(FF["addClan"]);
  if(i>0)raw[0,".union",FF["addClan"]]=i;
 }
 if(FF contains "removePlayer"){
  raw[0,FF["removePlayer"],".ignore"]=1;
 }
 if(FF contains "unignoreSelected"){
  string t="ignores%5B%5D";
  while(FF contains t){
   remove raw[0,FF[t],".ignore"];
   t=t+"_";
  }
 } 
 if(FF contains "ignoreSelected"){
  string t="ignores%5B%5D";
  while(FF contains t){
   raw[0,FF[t],".ignore"]=1; 
   t=t+"_";
  }
 }
 if(FF contains "toggleRun")toggleRun(FF["fromClan"].to_int(),FF["toggleRun"].to_int());
 if(FF contains "recountRun")recountRun(FF["fromClan"].to_int(),FF["recountRun"].to_int());
 if(FF contains "adjust"){
  addProgressRun();
  numberCruncher();
  int v=FF["to"].to_int()-raw[0,FF["who"],FF["adjust"]];
  clear(raw);
  file_to_map("raidlog/dreadKP."+get_clan_id()+".txt",raw);
  raw[0,FF["who"],FF["adjust"]]+=v;
 }
 map_to_file(raw,"raidlog/dreadKP."+get_clan_id()+".txt");
}

void main(){
 if(get_clan_id()==0){
  write("No clan!</body>");
  return;
 }
 page=visit_url("clan_oldraidlogs.php?startrow=0");
 lootPageHeader();
 file_to_map("raidlog/dreadKP."+get_clan_id()+".txt",raw);
 addDefs();
 if(raw[0,".","lastRun"]==0)initData();
 addNewRuns();
 checkFF();
 addProgressRun();
 numberCruncher();
 displayTables();
 writeln("</body>");
}