use AppleScript version "2.4" -- Yosemite (10.10) or later
use framework "Foundation"
use scripting additions

tell application "Capture One 20"
	
	set focalLength to get EXIF focal length of image of current document
	set starRating to get rating of variant of current document
	
end tell
set L0_24 to 0
set L25_49 to 0
set L50_74 to 0
set L75_100 to 0
set theList to {}
repeat with i from 1 to (count of focalLength)
	if item i of starRating is not 0 then
		set theList's end to item 1 of my theSplit(item i of focalLength, space)
		
	end if
end repeat

repeat with a from 1 to (count of theList)
	set itemA to item a of theList as integer
	if itemA is less than or equal to 24 then
		set L0_24 to L0_24 + 1
	end if
	if itemA < 49 and itemA > 25 then
		set L25_49 to L25_49 + 1
	end if
	if itemA < 74 and itemA > 50 then
		set L50_74 to L50_74 + 1
	end if
	if itemA < 100 and itemA > 75 then
		set L75_100 to L75_100 + 1
	end if
end repeat

display dialog "Favorite focal lengths" & return & return & "less than 24mm = " & L0_24 & return & "24mm - 49mm = " & L25_49 & return & "50mm - 74mm = " & L50_74 & return & "75mm - 100mm = " & L75_100

on theSplit(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end theSplit
