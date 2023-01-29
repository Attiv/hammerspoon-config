-- local hyper = {'ctrl', 'cmd'}
-- hs.hotkey.bind({"cmd"}, "L", hs.caffeinate.systemSleep)
-- -- show front activated app infos
-- hs.hotkey.bind(
--     hyper, ".",
--     function()
--         hs.alert.show(string.format("App path:        %s\nApp name:      %s\nIM source id:  %s",
--                                     hs.window.focusedWindow():application():path(),
--                                     hs.window.focusedWindow():application():name(),
--                                     hs.keycodes.currentSourceID()))
--     end)

hs.hotkey.bind({"cmd", "shift"}, ",", function()
    hs.http.asyncGet("https://api.shadiao.pro/chp", nil, function(status, body, headers)
        if status == 200 then
            local data = hs.json.decode(body)
            hs.pasteboard.setContents(data.data.text)
            hs.alert.show("Copied to clipboard: " .. data.data.text)
        else
            hs.alert("Error: " .. status)
        end
    end)
end)

hs.hotkey.bind({"cmd", "shift"}, ".", function()
    hs.http.asyncGet("https://api.shadiao.pro/pyq", nil, function(status, body, headers)
        if status == 200 then
            local data = hs.json.decode(body)
            hs.pasteboard.setContents(data.data.text)
            hs.alert.show("Copied to clipboard: " .. data.data.text)
        else
            hs.alert("Error: " .. status)
        end
    end)
end)

hs.hotkey.bind({"cmd", "shift"}, "/", function()
    hs.http.asyncGet("https://api.shadiao.pro/du", nil, function(status, body, headers)
        if status == 200 then
            local data = hs.json.decode(body)
            hs.pasteboard.setContents(data.data.text)
            hs.alert.show("Copied to clipboard: " .. data.data.text)
        else
            hs.alert("Error: " .. status)
        end
    end)
end)
