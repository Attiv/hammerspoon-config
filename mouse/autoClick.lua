function autoClick() 
  local currentPoint = hs.mouse.getAbsolutePosition()
  hs.eventtap.leftClick(currentPoint)
end

function start() 
  timer = hs.timer.doEvery(0.1, autoClick)
end

function stop() 
  timer:stop()
end


hs.hotkey.bind({"ctrl", "cmd"}, ",", "Start Click", start)
hs.hotkey.bind({"ctrl", "cmd"}, ".", "End Click", stop)