# Sary's Carriageman Booze Calculator
	
int [item] sheets;
file_to_map("carriagebooze.txt", sheets);
int totalpossible;
buffer output;

output.append( "<table border=1 cols=6>" );
output.append( "<tr>" );
output.append( "<th>Booze</th>" );
output.append( "<th>Sheets</th>" );
output.append( "<th>Mall Value</th>" );
output.append( "<th>Meat / Sheet</th>" );
output.append( "<th>Available Booze</th>" );
output.append( "<th>Total Credit</th>" );
//output.append( "<th>Other Effects</th>" );
output.append( "</tr>" );
		
foreach booze, val in sheets {
	//if (available_amount(booze)>0){
		int meatval = mall_price(booze);
		int sheetcost = meatval / val;
		int total = available_amount(booze) * val;
		//string effectname = string_modifier(booze, "effect");
		//string effectmods = string_modifier(effectname, "modifiers");
		//string duration = numeric_modifier(booze, "effect duration");
		output.append( "<tr><td>" );
		output.append( booze );
		output.append( "</td><td>" );
		output.append( val );
		output.append( "</td><td>" );
		output.append( meatval );
		output.append( "</td><td>" );
		output.append( sheetcost );
		output.append( "</td><td>" );	
		output.append( available_amount(booze) );
		output.append( "</td><td>" );
		output.append( total );
		//output.append( "</td><td>" );
		//if (length(effectname) > 0){
		//	output.append( "<tr><td></td><td colspan=5>Effect: " );
		//	output.append( "Effect: " );
		//	output.append( effectmods + " (" + duration + " turns)" );
		//	}
		output.append( "</td></tr>" );
			
		totalpossible = totalpossible + total;
		}
	//}

//output.append( "<tr><td><b>Total:</b></td>");
//output.append( "<tr><td><b>Total Possible sheets:</b></td>");
//output.append( "<td></td>" );
//output.append( "<td></td>" );
//output.append( "<td></td>" );
//output.append( "<td></td>" );
//output.append( "<td><b>" );
//output.append( totalpossible );
//output.append( "</b></td></tr>" );
output.append( "</table>" );
#output.toString();
print_html(output);