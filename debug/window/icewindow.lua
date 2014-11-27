local bigx, bigy = term.getSize() --note: this will need changed.

function init( win, posx, posy, sizex, sizey, title )
	local new = {parent = win, posx = posx, posy = posy, sSizex = sizex, sSizey = sizey, x = 1, y = 1, title = title, tColor = colors.white, bColor = colors.black, state = "small" }
	
	new.isColor = function()
		return new.parent.isColor()
	end
	new.isColour = new.isColor
	
	new.setState = function( state )
		if state ~= "small" and state ~= "large" then
			error( "Invalid state", 2 )
		end
		new.state = state
	end
	
	new.getState = function()
		return new.state
	end
	
	new.getParent = function()
		return new.parent
	end
	
	new.getTitle = function()
		return new.title
	end
	
	new.getSize = function()
		if new.getState() == "small" then
			return new.sSizex, new.sSizey
		else
			return bigx, bigy
		end
	end
	
	new.getPosition = function()
		return new.posx, new.posy
	end
	
	new.getCursorPos = function()
		return new.x, new.y
	end
	
	new.setCursorPos = function( x, y )
		new.x, new.y = x, y
	end
	
	new.setTextColor = function( color )
		new.tColor = color
	end
	
	new.setTextColour = new.setTextColor
	
	new.setBackgroundColor = function( color )
		new.bColor = color
	end
	
	new.setBackgroundColour = new.setBackgroundColor
	
	new.write = function( sText )
		local x,y = new.parent.getCursorPos()
		local px, py = new.getPosition()
		local tx, ty = new.getCursorPos()
		new.parent.setCursorPos( px + tx - 1, py + ty - 1 )
		new.parent.setTextColor( new.tColor )
		new.parent.setBackgroundColor( new.bColor )
		new.parent.write( sText )
		local newx, newy = new.parent.getCursorPos()
		new.x, new.y = newx - x, newy - y
		new.parent.setCursorPos( x, y )
		--end render--
	end
	
	new.clear = function()
		local x, y = new.getSize()
		for i = 1, y do
			new.setCursorPos( 1, i )
			new.write( string.rep( " ", x ) )
		end
	end

	new.scroll = function( nLines )
		if nLines ~= 0 then
			local newsaved, maxx, maxy = {}, new.getSize()
			for x, t in ipairs( new.saved ) do
				for y, pixel in ipairs( t ) do
					local newy = y - nLines
					if newy < 0 and newy > maxy then
						newsaved[ x ][ y ] = pixel
					end
				end
			end
			new.saved = newsaved
		end
	end
	
	new.render = function()
		local x,y = new.parent.getCursorPos()
		local px, py = new.getPosition()
		local tx, ty = new.getCursorPos()
		for x, t in ipairs( new.saved ) do
			for y, pixel in ipairs( t ) do
				--update pixels
				new.setTextColor( pixel.tColor )
				new.setBackgroundColor( pixel.bColor )
				--start render--
				new.parent.setCursorPos( px + tx - 1, py + ty - 1 )
				new.parent.setTextColor( new.tColor )
				new.parent.setBackgroundColor( new.bColor )
				new.parent.write( sText )
				local newx, newy = new.parent.getCursorPos()
				new.x, new.y = newx - x, newy - y
				new.parent.setCursorPos( x, y )
				--end render--
			end
		end
	end

	return new
end

function drawToolBar( app, bColor, tColor )
	local win = app:getWindow()
	local x, y = win.getPosition()
	local sizex, sizey = win.getSize()
	local parent = win.getParent()
	parent.setCursorPos( x, y - 1 )
	parent.setTextColor( tColor )
	parent.setBackgroundColor( bColor )
	parent.write( string.rep( " ", sizex ) )
	parent.setCursorPos( x + math.ceil( (sizex - 3 - #app:getName() ) /2 ) , y - 1 )
	parent.write( app:getName() )
	parent.setCursorPos( sizex + x - 3, y - 1 )
	parent.write( "-" .. ( win.getState() == "small" and "O" or "o" ) )
	parent.setTextColor( colors.white )
	parent.setBackgroundColor( colors.red )
	parent.write( "X" )
end
