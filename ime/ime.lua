local function Chinese()
    hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Rime")
    -- hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.Shuangpin")
end

local function English()
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

local function Hlly()
    hs.keycodes.currentSourceID("github.dongyuwei.inputmethod.hallelujahInputMethod")
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
    {'/Applications/Fork.app', 'English'},
    {'/Applications/wechatwebdevtools.app', 'English'},
    {'/Applications/Sketch.app', 'English'},
    {'/Applications/Visual Studio Code.app', 'English'},
    {'/Applications/TablePlus.app', 'English'},
    {'/Applications/GitUp.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/AppCode/ch-0/212.5284.45/AppCode.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/PhpStorm/ch-0/203.7717.64/PhpStorm.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/WebStorm/ch-0/211.6693.108/WebStorm.app', 'English'},
    {'/Applications/Xcode12.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/AndroidStudio/ch-0/203.7678000/Android Studio.app', 'English'},
    {'/Applications/eDEX-UI.app', 'English'},
    {'/Applications/QQ.app', 'Chinese'},
    {'/Applications/Fork.app', 'English'},
    {'/Applications/iTerm.app', 'English'},
    {'/Applications/Unity/Hub/Editor/2019.4.14f1c1/Unity.app', 'English'},
    {'/Applications/Visual Studio.app', 'English'},
    {'/Applications/Sublime Text.app', 'English'},
}

function updateFocusAppInputMethod()
    local focusAppPath = hs.window.frontmostWindow():application():path()
    for index, app in pairs(app2Ime) do
        local appPath = app[1]
        local expectedIme = app[2]

        if focusAppPath == appPath then
            hs.alert.closeAll()
            if expectedIme == 'English' then
                English()
                -- hs.alert.show('English', {}, 0.5)
            else
                Chinese()
                -- hs.alert.show('中文', {}, 0.5)
            end
            break
        end
    end
end

function killHLLL() 
    local hlll = hs.application.get('hallelujah')
    if hlll ~= nil then
        hs.application.get('hallelujah'):kill9()
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
    -- hs.pasteboard.setContents(hs.keycodes.currentSourceID())
end)

hs.hotkey.bind({'cmd', 'shift'}, "0", function()
    Hlly()
end)

hs.hotkey.bind({'cmd', 'shift'}, "9", function()
    English()
end)

hs.hotkey.bind({'cmd', 'shift'}, "8", function()
    Chinese()
end)

hs.hotkey.bind({'cmd', 'shift'}, "7", function()
    killHLLL()
end)

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        updateFocusAppInputMethod()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
