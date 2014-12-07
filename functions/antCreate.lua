require("spriteAnim")

CreateAnt = {
		new = function(grp)
			
			local ant = SpriteAnim.new()
			ant:setSequence("boom")
			ant:play()
			--ant:addEventListener( "sprite", spriteListener )
			
			transition.to(ant,{y = 1280,time=10000, onComplete = function() ant:removeSelf(); ant = nil end })
			
			
		end


}