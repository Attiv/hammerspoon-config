local slackApp = hs.application.get('com.tinyspeck.slackmacgap')
local telegramApp = hs.application.get('ru.keepcoder.Telegram')
local fsNoteApp = hs.application.get('com.ulyssesapp.mac')
-- local fsNoteApp = hs.application.get('co.fluder.FSNotes')
-- local emailApp = hs.application.get('com.apple.mail')

-- local emailApp = hs.application.get('com.edisonmail.edisonmail')
local emailApp = hs.application.get('it.bloop.airmail2')

function emailOpen()
  if (not emailApp or (not emailApp:isRunning()))
    then
      -- hs.application.open('com.apple.mail')
      hs.application.open('it.bloop.airmail2')
      -- emailApp = hs.application.get('com.apple.mail')
      emailApp = hs.application.get('it.bloop.airmail2')
    end
  if emailApp:isHidden()
    then
      -- hs.application.launchOrFocus('/System/Applications/Mail.app')
      -- hs.application.launchOrFocus('/Applications/Edison Mail.app')
      hs.application.launchOrFocus('/Applications/Airmail.app')
    else
      emailApp:hide()
    end
end

function fsNote()
  if (not fsNoteApp or (not fsNoteApp:isRunning()))
    then
      hs.application.open('com.ulyssesapp.mac')
      fsNoteApp = hs.application.get('com.ulyssesapp.mac')
    end
  if fsNoteApp:isHidden()
    then
      hs.application.launchOrFocus('/Applications/UlyssesMac.app')
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