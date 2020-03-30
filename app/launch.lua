local slackApp = hs.application.get('com.tinyspeck.slackmacgap')
local telegramApp = hs.application.get('ru.keepcoder.Telegram')

function slack()
  if not slackApp
    then
      hs.application.open('com.tinyspeck.slackmacgap')
      slackApp = hs.application.get('com.tinyspeck.slackmacgap')
    end
  if slackApp:isHidden()
    then 
      hs.application.launchOrFocus('/Applications/Slack.app')
    else
      slackApp:hide() 
    end
end

function telegram()
  if not telegramApp
    then 
      hs.application.open('ru.keepcoder.Telegram')
      telegramApp = hs.application.get('ru.keepcoder.Telegram')
    end
  if telegramApp:isHidden()
    then
      hs.application.launchOrFocus('/Applications/Telegram.app')
    else
      telegramApp:hide()
    end
end


hs.hotkey.bind({"cmd"}, "`", telegram)
hs.hotkey.bind({"alt"}, "`", slack)