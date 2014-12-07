local scene = storyboard.newScene()

storyboard.purgeOnSceneChange = true



function scene:createScene(event)
	
end

function scene:enterScene(event)
	print("destroy")
end


function scene:exitScene(event)
	
	
end

function scene:destroyScene(event)
	print("destroy")
end



scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )


return scene