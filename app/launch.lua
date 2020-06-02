local slackApp = hs.application.get('com.tinyspeck.slackmacgap')
local telegramApp = hs.application.get('ru.keepcoder.Telegram')
local fsNoteApp = hs.application.get('co.fluder.FSNotes')
local emailApp = hs.application.get('com.apple.mail')

function emailOpen()
  if (not emailApp or (not emailApp:isRunning()))
    then
      hs.application.open('com.apple.mail')
      emailApp = hs.application.get('com.apple.mail')
    end
  if emailApp:isHidden()
    then
      hs.application.launchOrFocus('/System/Applications/Mail.app')
    else
      emailApp:hide()
    end
end

function fsNote()
  if (not fsNoteApp or (not fsNoteApp:isRunning()))
    then
      hs.application.open('co.fluder.FSNotes')
      fsNoteApp = hs.application.get('co.fluder.FSNotes')
    end
  if fsNoteApp:isHidden()
    then
      hs.application.launchOrFocus('/Applications/FSNotes.app')
    else
      fsNoteApp:hide()
    end
end

function slack()
  if (not slackApp or (not slackApp:isRunning()))
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
  if (not telegramApp or (not telegramApp:isRunning()))
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
hs.hotkey.bind({"ctrl"}, "`", emailOpen)
hs.hotkey.bind({"ctrl"}, "\\", fsNote)