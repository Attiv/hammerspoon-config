local function Chinese()
    hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Rime")
end

local function English()
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

-- app to expected ime config
local app2Ime = {
    {'/Applications/Xcode.app', 'English'},
    -- {'/Applications/Google Chrome.app', 'Chinese'},
    -- {'/System/Library/CoreServices/Finder.app', 'English'},
    {'/Applications/DingTalk.app', 'Chinese'},
    -- {'/Applications/Kindle.app', 'English'},
    {'/Applications/NeteaseMusic.app', 'Chinese'},
    {'/Applications/WeChat.app', 'Chinese'},
    {'/Applications/System Preferences.app', 'English'},
    {'/Applications/Dash.app', 'English'},
    -- {'/Applications/MindNode.app', 'Chinese'},
    -- {'/Applications/Preview.app', 'Chinese'},
    {'/Applications/wechatwebdevtools.app', 'English'},
    {'/Applications/Sketch.app', 'English'},
    {'/Applications/Visual Studio Code.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/PhpStorm/ch-0/202.7319.77/PhpStorm.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/WebStorm/ch-0/202.7660.23/WebStorm.app', 'English'},
    {'/Applications/QQ.app', 'Chinese'},
    {'/Applications/Fork.app', 'English'},
    {'/Applications/iTerm.app', 'English'},
}

function updateFocusAppInputMethod()
    local focusAppPath = hs.window.frontmostWindow():application():path()
    for index, app in pairs(app2Ime) do
        local appPath = app[1]
        local expectedIme = app[2]

        if focusAppPath == appPath then
            if expectedIme == 'English' then
                English()
            else
                Chinese()
            end
            break
        end
    end
end

-- helper hotkey to figure out the app path and name of current focused window
hs.hotkey.bind({'ctrl', 'option'}, ".", function()
    hs.alert.show("App path:        "
    ..hs.window.focusedWindow():application():path()
    .."\n"
    .."App name:      "
    ..hs.window.focusedWindow():application():name()
    .."\n"
    .."IM source id:  "
    ..hs.keycodes.currentSourceID())
    hs.pasteboard.setContents('{\'' .. hs.window.focusedWindow():application():path() .. '\', \'\'},')
end)

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        updateFocusAppInputMethod()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
