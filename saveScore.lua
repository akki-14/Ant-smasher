SaveScore = {	
	new = function(score,grp,playerName)
		local enter_name = ""
		local defaultField
		local min_high_score
		local shareScore
		local insertName
		
		--functions
		local inputListener
		local enter_high_score
		local store_score
		local ok_save
		local postScore

		

	
	 function enter_high_score(score)
			function store_score(name,score)
				if( name == "" ) then
					name = "No-name"
				end
					scoreIce:storeIfHigher( name, score )
					scoreIce:save()
			end



			 function ok_save(name)
				
				--insertName = display.newText(grp,name .. " has scored " .. score ,display.contentCenterX, bufferHeight + 600,"Base 02",35)
				store_score(name,score)
				--grp:removeSelf()
			end
		
		
		
			function inputListener(event)
				local  target = event.target
				
				function postScore(event)	
					ShareApp.score("117188648491159",2,score)
				end
				
				if(event.phase == "began") then
					if(target.text == target.hintText) then
					target.text = ''
					end
					target:setTextColor( 51,51,51)
				elseif(event.phase == "editing") then
					--insertName.text = event.text
				elseif(event.phase == "ended" or event.phase == "submitted") then
					if(target.text == '') then
					target.text = target.hintText 
					end
					target:setTextColor( 0,255,255)
					native.setKeyboardFocus( nil )
					shareScore = display.newImage(grp,"images/share_score.png", display.contentCenterX , bufferHeight + 750 )
					shareScore:addEventListener("tap",postScore)
					ok_save(target.text)
					target:removeSelf()
					target = nil
				end
			
			end
		
		
		
		playerName = native.newTextField(display.contentCenterX, display.contentCenterY, 350, 100 )
		playerName:setReturnKey("done")
		playerName.hintText = "Enter Name"
		playerName.size = 30
		playerName.align = "center"
		native.setKeyboardFocus( playerName )
		
		playerName:addEventListener( "userInput", inputListener )
		
	end	
		
		local function min_score()
			min_high_score = minScore:retrieve("min")
			print(min_high_score,score)
			if(score > min_high_score) then
				enter_high_score(score)
			end
			
		end

		
		min_score()
		
end,
	scoreSort = function()
		
		local scores = ice:loadBox( "scores" )
		local list= scores:getItems()
		local count = 0
		local  names ={}
		local  score_value = {}
		local  score_cpy ={}
		local count = 0
		local bar = {}
		local names_sorted = {}
		local player = {}
		local player_score = {}
		local k = 1
		local toggle = true
		local tempToggle = true
		local tempCount = 1
		
		for k,v in pairs(list) do
				count = count + 1
				--print(k .. "   " .. v)
				names[count] = k
				score_value[count] = v
				score_cpy[count] = v
		end
		
	
		for j = #score_value,1,-1 do
				for i = 1, j - 1 do
					if(score_value[i] < score_value[i+1]) then
						tmp = score_value[i+1]
						score_value[i+1] = score_value [i]
						score_value[i] = tmp
					end
				end
		end


		
		for i =1,#score_cpy do
			tempVal = 0
			for j =1,#score_value do
				if(score_value[i] == score_cpy[j] and toggle) then
					tempVal = tempVal + 1
					if score_value[i] == score_value[i-1] and tempVal <= tempCount then
					elseif score_value[i] == score_value[i-1] then
						tempCount = tempCount + 1
						bar[k] = j
						k=k +1
						toggle = false
					else
						bar[k] = j
						k=k +1
						toggle = false
						tempCount = 1
					end	
				end
			end	
				toggle = true
				--print(bar[i])
		end

		for k =1,#bar do
		names_sorted[k] = names[bar[k]]
		end
			

			
		for i = 1, #score_value do
			
		end
		minScore:store("min",score_value[10])
		minScore:save()
		maxScore:store("max",score_value[1])
		maxScore:save()
		maxScore:print()
		minScore:print()
	
		
	
		return names_sorted,score_value
	end
	,	
		print = function(tempName,tempScore,gp)
			local player = {}
			local player_score = {}
			local srNo = {}
			local y_cor = -display.viewableContentHeight + 300
			local font = "Base 02"
			for i = 1, 10 do
				srNo[i] = display.newText(gp, i .. ". ", 150 , y_cor , font, 40 )
				srNo[i].x = 100
				player[i] = display.newText(gp,tempName[i], 150 , y_cor , font, 40 )
				player[i].anchorX = 0
				player[i].x = 140
				srNo[i]:setFillColor(0,0,0)
				player[i]:setFillColor(1,1,1)
				player_score[i] = display.newText(gp, tempScore[i], 550 , y_cor , font, 40 )
				player_score[i]:setFillColor(0.8,0.3,0.5)
				y_cor = y_cor + 70
			end
		
		
		end,
		getMax = function()
			return maxScore:retrieve("max")
		end
		
}