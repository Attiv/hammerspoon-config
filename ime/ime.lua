-- 中文输入法
local function Chinese()
    -- rime输入法
    hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Hant")

    -- 系统默认中文双拼输入法
    -- hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.Shuangpin")
    -- 系统默认中文拼音
    -- hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
end

-- 英文输入法
local function English()
    -- 系统默认英文输入法
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

-- 哈利路亚英文输入法
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
    {'/Applications/Raycast.app', 'English'},
    {'/Applications/wechatwebdevtools.app', 'English'},
    {'/Applications/Sketch.app', 'English'},
    {'/Applications/Visual Studio Code.app', 'English'},
    {'/Applications/TablePlus.app', 'English'},
    {'/Applications/GitUp.app', 'English'},
    {'/Applications/Xcode12.app', 'English'},
    -- IDE 是使用 JetBrains Toolbox 安装的，app 路径不在 Application/ 下，有些自动切换输入法的工具会失效，所以使用全路径
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/AppCode/ch-0/223.8617.49/AppCode.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/WebStorm/ch-0/222.3345.108/WebStorm.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/PhpStorm/ch-0/223.8214.64/PhpStorm.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/Fleet/ch-0/1.9.231/Fleet.app', 'English'},
    {'/Users/wanglikun/Library/Application Support/JetBrains/Toolbox/apps/AndroidStudio/ch-0/223.7571.182.2231.9523943/Android Studio Preview.app', 'English'},
    {'/Applications/uTools.app', 'English'},
    {'/Applications/Telegram.app', 'Chinese'},
    {'/Applications/Xcode12.app', 'English'},
    {'/Applications/eDEX-UI.app', 'English'},
    {'/Applications/QQ.app', 'Chinese'},
    {'/Applications/Fork.app', 'English'},
    {'/Applications/iTerm.app', 'English'},
    {'/Applications/Warp.app', 'English'},
    {'/var/folders/43/zmk0vm9d6z119nxn2cfl8hwm0000gn/T/AppTranslocation/D111B232-26EF-4E16-9D71-93F18A03C6BC/d/iTerm.app', 'English'},
    {'/Users/wanglikun/Applications/iTerm.app', 'English'},
    {'/Applications/Unity/Hub/Editor/2019.4.14f1c1/Unity.app', 'English'},
    {'/Applications/Visual Studio.app', 'English'},
    {'/Applications/Sublime Text.app', 'English'},
}

-- 切换输入法
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

-- 杀掉哈利路亚输入法进程，因为使用哈利路亚输入法时切换桌面的时候会有一个黑色弹窗显示1秒才消失，官方回复是系统bug，杀掉进程就不会显示了
-- 此处有bug，杀掉进程有延时，偶尔杀掉还显示黑色弹窗
function killHLLL() 
    local hlll = hs.application.get('hallelujah')
    if hlll ~= nil then
        hs.application.get('hallelujah'):kill9()
    end
end

-- helper hotkey to figure out the app path and name of current focused window
-- 绑定快捷键，获取当前app的路径和输入Source ID，并自动添加到粘贴板
hs.hotkey.bind({'ctrl', 'option'}, ".", function()
    hs.alert.show("App path:        "
    ..hs.window.focusedWindow():application():path()
    .."\n"
    .."App name:      "
    ..hs.window.focusedWindow():application():name()
    .."\n"
    .."Bundle ID:     "
    ..hs.window.focusedWindow():application():bundleID()
    .."\n"
    .."IM source id:  "
    ..hs.keycodes.currentSourceID())
    hs.pasteboard.setContents('{\'' .. hs.window.focusedWindow():application():path() .. '\', \'\'},')
    -- hs.pasteboard.setContents(hs.keycodes.currentSourceID())
end)

-- 绑定快捷键，切换当前输入法为哈利路亚输入法(这里是想要手动切换输入法的时候用的)
hs.hotkey.bind({'cmd', 'shift'}, "0", function()
    Hlly()
end)

-- 绑定快捷键，切换当前输入法为英文输入法(这里是想要手动切换输入法的时候用的)
hs.hotkey.bind({'cmd', 'shift'}, "9", function()
    English()
end)

-- 绑定快捷键，切换当前输入法为中文输入法(这里是想要手动切换输入法的时候用的)
hs.hotkey.bind({'cmd', 'shift'}, "8", function()
    Chinese()
end)

-- 绑定快捷键，杀掉哈利路亚输入法进程
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
