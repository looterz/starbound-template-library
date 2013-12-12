
--[[---------------------------------------------------------
	Math Helpers
-----------------------------------------------------------]]

--[[---------------------------------------------------------
   Name: Dist( low, high )
   Desc: Distance between two 2d points
------------------------------------------------------------]]
function math.Dist( x1, y1, x2, y2 )
	local xd = x2-x1
	local yd = y2-y1
	return math.sqrt( xd*xd + yd*yd )
end

math.Distance = math.Dist -- alias


--[[---------------------------------------------------------
   Name: BinToInt( bin )
   Desc: Convert a binary string to an integer number
------------------------------------------------------------]]
function math.BinToInt(bin)
	return tonumber(bin,2)
end


--[[---------------------------------------------------------
   Name: IntToBin( int )
   Desc: Convert an integer number to a binary string
------------------------------------------------------------]]
function math.IntToBin(int)

	local str = string.format("%o",int)

	local a = {
			["0"]="000",["1"]="001", ["2"]="010",["3"]="011",
        		["4"]="100",["5"]="101", ["6"]="110",["7"]="111"
		  }
	bin = string.gsub( str, "(.)", function ( d ) return a[ d ] end )
	return bin

end

--[[---------------------------------------------------------
   Name: Clamp( in, low, high )
   Desc: Clamp value between 2 values
------------------------------------------------------------]]
function math.Clamp( _in, low, high )
	if (_in < low ) then return low end
	if (_in > high ) then return high end
	return _in
end

--[[---------------------------------------------------------
   Name: Rand( low, high )
   Desc: Random number between low and high
-----------------------------------------------------------]]
function math.Rand( low, high )
	return low + ( high - low ) * math.random()
end

--[[---------------------------------------------------------
    math.Max, alias for math.max
-----------------------------------------------------------]]
math.Max = math.max

--[[---------------------------------------------------------
   math.Min, alias for math.min
-----------------------------------------------------------]]
math.Min = math.min

--[[---------------------------------------------------------
    Name: EaseInOut(fProgress, fEaseIn, fEaseOut)
    Desc: Provided by garry from the facewound source and converted
          to Lua by me :p
   Usage: math.EaseInOut(0.1, 0.5, 0.5) - all parameters shoule be between 0 and 1
-----------------------------------------------------------]]
function math.EaseInOut( fProgress, fEaseIn, fEaseOut ) 

	if (fEaseIn == nil) then fEaseIn = 0 end
	if (fEaseOut == nil) then fEaseOut = 1 end

	local fSumEase = fEaseIn + fEaseOut; 

	if( fProgress == 0.0 || fProgress == 1.0 ) then return fProgress end

	if( fSumEase == 0.0 ) then return fProgress end
	if( fSumEase > 1.0 ) then
		fEaseIn = fEaseIn / fSumEase; 
		fEaseOut = fEaseOut / fSumEase; 
	end

	local fProgressCalc = 1.0 / (2.0 - fEaseIn - fEaseOut); 

	if( fProgress < fEaseIn ) then
		return ((fProgressCalc / fEaseIn) * fProgress * fProgress); 
	elseif( fProgress < 1.0 - fEaseOut ) then
		return (fProgressCalc * (2.0 * fProgress - fEaseIn)); 
	else 
		fProgress = 1.0 - fProgress; 
		return (1.0 - (fProgressCalc / fEaseOut) * fProgress * fProgress); 
	end
end

--[[---------------------------------------------------------
    Name: Round( round )
-----------------------------------------------------------]]
function math.Round(num, idp)

	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
  
end

--[[---------------------------------------------------------
    Name: Approach( cur, target, inc )
-----------------------------------------------------------]]
function math.Approach( cur, target, inc )

	inc = math.abs( inc )

	if (cur < target) then
		
		return math.Clamp( cur + inc, cur, target )

	elseif (cur > target) then

		return math.Clamp( cur - inc, target, cur )

	end

	return target
	
end

--[[---------------------------------------------------------
    Name: TimeFraction( Start, End, Current )
-----------------------------------------------------------]]
function math.TimeFraction( Start, End, Current )
	return ( Current - Start ) / ( End - Start )
end

--[[---------------------------------------------------------
    Name: Remap( value, inMin, inMax, outMin, outMax )
-----------------------------------------------------------]]
function math.Remap( value, inMin, inMax, outMin, outMax )
	return outMin + ( ( ( value - inMin ) / ( inMax - inMin ) ) * ( outMax - outMin ) )
end

--[[---------------------------------------------------------
	String Helpers
-----------------------------------------------------------]]

--[[---------------------------------------------------------
   Name: string.ToTable( string )
-----------------------------------------------------------]]
function string.ToTable ( str )
	local tbl = {}
	
	for i = 1, string.len( str ) do
		tbl[i] = string.sub( str, i, i )
	end
	
	return tbl
end

--[[---------------------------------------------------------
   Name: explode(seperator ,string)
   Desc: Takes a string and turns it into a table
   Usage: string.explode( " ", "Seperate this string")
-----------------------------------------------------------]]
local totable = string.ToTable
local string_sub = string.sub
local string_gsub = string.gsub
local string_gmatch = string.gmatch
function string.Explode(separator, str, withpattern)
	if (separator == "") then return totable( str ) end
	 
	local ret = {}
	local index,lastPosition = 1,1
	 
	-- Escape all magic characters in separator
	if not withpattern then separator = string_gsub( separator, "[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1" ) end
	 
	-- Find the parts
	for startPosition,endPosition in string_gmatch( str, "()" .. separator.."()" ) do
		ret[index] = string_sub( str, lastPosition, startPosition-1)
		index = index + 1
		 
		-- Keep track of the position
		lastPosition = endPosition
	end
	 
	-- Add last part by using the position we stored
	ret[index] = string_sub( str, lastPosition)
	return ret
end

--[[---------------------------------------------------------
	Table Helpers
-----------------------------------------------------------]]

--[[---------------------------------------------------------
	Name: Empty( tab )
	Desc: Empty a table
-----------------------------------------------------------]]
function table.Empty( tab )

	for k, v in pairs( tab ) do
		tab[k] = nil
	end

end

--[[---------------------------------------------------------
   Name: table.ClearKeys( table, bSaveKey )
   Desc: Clears the keys, converting to a numbered format
-----------------------------------------------------------]]
function table.ClearKeys( Table, bSaveKey )

	local OutTable = {}
	
	for k, v in pairs( Table ) do
		if ( bSaveKey ) then
			v.__key = k
		end
		table.insert( OutTable, v )	
	end
	
	return OutTable

end

function table.ForceInsert( t, v )

	if ( t == nil ) then t = {} end
	
	table.insert( t, v )
	
	return t
	
end

--[[---------------------------------------------------------
   Name: table.Count( table )
   Desc: Returns the number of keys in a table
-----------------------------------------------------------]]
function table.Count (t)
  local i = 0
  for k in pairs(t) do i = i + 1 end
  return i
end


--[[---------------------------------------------------------
   Name: table.Random( table )
   Desc: Return a random key
-----------------------------------------------------------]]
function table.Random (t)
  
  local rk = math.random( 1, table.Count( t ) )
  local i = 1
  for k, v in pairs(t) do 
	if ( i == rk ) then return v, k end
	i = i + 1 
  end

end

--[[---------------------------------------------------------
   Name: table.Add( dest, source )
   Desc: Unlike merge this adds the two tables together and discards keys.
-----------------------------------------------------------]]
function table.Add( dest, source )

	-- At least one of them needs to be a table or this whole thing will fall on its ass
	if (type(source)!='table') then return dest end
	
	if (type(dest)!='table') then dest = {} end

	for k,v in pairs(source) do
		table.insert( dest, v )
	end
	
	return dest
end

--[[---------------------------------------------------------
   Name: xx
   Desc: xx
-----------------------------------------------------------]]
function table.HasValue( t, val )
	for k,v in pairs(t) do
		if (v == val ) then return true end
	end
	return false
end

table.InTable = HasValue

--[[---------------------------------------------------------
   Name: table.SortDesc( table )
   Desc: Like Lua's default sort, but descending
-----------------------------------------------------------]]
function table.SortDesc( Table )
	return table.sort( Table, function(a, b) return a > b end )
end

--[[---------------------------------------------------------
   Name: table.LowerKeyNames( table )
   Desc: Lowercase the keynames of all tables
-----------------------------------------------------------]]
function table.LowerKeyNames( Table )

	local OutTable = {}

	for k, v in pairs( Table ) do
	
		-- Recurse
		if ( istable( v ) ) then
			v = table.LowerKeyNames( v )
		end
		
		OutTable[ k ] = v
		
		if ( isstring( k ) ) then
	
			OutTable[ k ]  = nil
			OutTable[ string.lower( k ) ] = v
		
		end		
	
	end
	
	return OutTable
	
end

--[[---------------------------------------------------------
   Name: xx
   Desc: xx
-----------------------------------------------------------]]
function table.Merge(dest, source)

	for k,v in pairs(source) do
	
		if ( type(v) == 'table' && type(dest[k]) == 'table' ) then
			-- don't overwrite one table with another;
			-- instead merge them recurisvely
			table.Merge(dest[k], v)
		else
			dest[k] = v
		end
	end
	
	return dest
	
end

--[[---------------------------------------------------------
	Name: CopyFromTo( FROM, TO )
	Desc: Make TO exactly the same as FROM - but still the same table.
-----------------------------------------------------------]]
function table.CopyFromTo( FROM, TO )

	-- Erase values from table TO
	table.Empty( TO )
	
	-- Copy values over
	table.Merge( TO, FROM )
	
end

--[[---------------------------------------------------------
   Name: table.LowerKeyNames( table )
   Desc: Lowercase the keynames of all tables
-----------------------------------------------------------]]
function table.CollapseKeyValue( Table )

	local OutTable = {}
	
	for k, v in pairs( Table ) do
	
		local Val = v.Value
	
		if ( istable( Val ) ) then
			Val = table.CollapseKeyValue( Val )
		end
		
		OutTable[ v.Key ] = Val
	
	end
	
	return OutTable

end

--[[---------------------------------------------------------
	GetFirstKey
-----------------------------------------------------------]]
function table.GetFirstKey( t )

	local k, v = next( t )
	return k
	
end

function table.GetFirstValue( t )

	local k, v = next( t )
	return v
	
end

function table.GetLastKey( t )

	local k, v = next( t, table.Count(t) - 1 )
	return k
	
end

function table.GetLastValue( t )

	local k, v = next( t, table.Count(t) - 1 )
	return v
	
end

function table.FindNext( tab, val )
	
	local bfound = false
	for k, v in pairs( tab ) do
		if ( bfound ) then return v end
		if ( val == v ) then bfound = true end
	end
	
	return table.GetFirstValue( tab )	
	
end

function table.FindPrev( tab, val )
	
	local last = table.GetLastValue( tab )
	for k, v in pairs( tab ) do
		if ( val == v ) then return last end
		last = v
	end
	
	return last
	
end

function table.GetWinningKey( tab )
	
	local highest = -10000
	local winner = nil
	
	for k, v in pairs( tab ) do
		if ( v > highest ) then 
			winner = k
			highest = v
		end
	end
	
	return winner
	
end

function table.KeyFromValue( tbl, val )
	for key, value in pairs( tbl ) do
		if ( value == val ) then return key end
	end
end

function table.RemoveByValue( tbl, val )

	local key = table.KeyFromValue( tbl, val )
	if ( !key ) then return false end
	
	table.remove( tbl, key )
	return key;
	
end

function table.KeysFromValue( tbl, val )
	local res = {}
	for key, value in pairs( tbl ) do
		if ( value == val ) then table.insert( res, key ) end
	end
	return res
end

function table.Reverse( tbl )

	 local len = #tbl;
	 local ret = {};
	 
	 for i = len, 1, -1 do
		  ret[len-i+1] = tbl[i];
	 end

	 return ret;
  
end

function table.ForEach( tab, funcname )

	for k, v in pairs( tab ) do
		funcname( k, v )
	end

end
