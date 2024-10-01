local obj = {}
obj.__index = obj

-- Metadata
obj.name = "CustomKeys"
obj.version = "1.0"
obj.author = "Daniel Cordova <danesc87@gmail.com>"
obj.homepage = "https://github.com/dcdaz/spoons"
obj.license = "GPL3"

obj.positions = {
    top = {x=0, y=0, w=1, h=0.5},
    bottom = {x=0, y=0.5, w=1, h=0.5},
    leftTop = {x=0, y=0, w=0.5, h=0.5},
    leftBottom = {x=0, y=0.5, w=0.5, h=0.5},
    rightTop = {x=0.5, y=0, w=0.5, h=0.5},
    rightBottom = {x=0.5, y=0.5, w=0.5, h=0.5}
}

local debug = false

local functionKeys = nil
local appRemapKeys = nil
local osRemapKeys = nil

local modalTable = {}
local osModalTable = {}
local functionModalTable = {}

-- App Remap Keys

-- {
--     {
--         appNames = {'Firefox', 'Firefox Developer Edition'},
--         remapKeys = {
--             {
--                 delay = 0,
--                 from = {
--                     modifiers = {'cmd'},
--                     character = 'Left'
--                 },
--                 to = {
--                     modifiers = {'ctrl'},
--                     character = 'home'
--                 }
--             }
--         }
--     },
-- }

-- OS Remap Keys

-- {
--     {
--         delay = 0,
--         from = {
--             modifiers = {'cmd'},
--         },
--         to = {
--             modifiers = {'ctrl'},
--             character = 'a'
--         }
--     },
-- }

-- Function Map Keys

-- {
--     {
--         modifiers = {'alt'},
--         character = 'Left',
--         fn = function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end,
--     },
-- }


local function bindModalFromKey(key, modal)
    if key.from.modifiers then
        local keyDelay = 0
        local fromChar = nil

        if key.delay then
            keyDelay = key.delay
        end

        if key.from.character then
            fromChar = key.from.character
        else
            fromChar = key.to.character
        end
        modal:bind(key.to.modifiers, key.to.character, nil, function() hs.eventtap.keyStroke(key.from.modifiers, fromChar, keyDelay) end)
    end
end

local function buildOSModal()
    local modal = hs.hotkey.modal.new()
    for _,v in pairs(osRemapKeys) do
        bindModalFromKey(v, modal)
        table.insert(osModalTable, modal)
    end
    return modal
end

local function buildAppModal()
    for _,v in pairs(appRemapKeys) do
        local modal = hs.hotkey.modal.new()
        for _,key in pairs(v.remapKeys) do
            bindModalFromKey(key, modal)
        end
        table.insert(modalTable, { appNames = v.appNames, modal = modal })
    end

end

local function buildFunctionModal()
    local modal = hs.hotkey.modal.new()
    for _,v in pairs(functionKeys) do
        if v.modifiers and v.character then
            local keyDelay = 0

            if v.delay then
                keyDelay = v.delay
            end
            modal:bind(v.modifiers, v.character, nil, v.fn)
        end
    end
    return modal
end

local function containsName(appName, possibleNames)
    for _,v in pairs(possibleNames) do
        if v == appName then
            return true
        end
    end
    return false
end

local function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if debug then
            print('App Name is: ', appName)
        end
        
        for _,v in pairs(modalTable) do
            if containsName(appName, v.appNames) then
                v.modal:enter()
                break
            end
        end
    end
    if (eventType == hs.application.watcher.deactivated) then
        for _,v in pairs(modalTable) do 
            if containsName(appName, v.appNames) then
                v.modal:exit()
                break
            end
        end
    end
end

local appWatcher = hs.application.watcher.new(applicationWatcher)

function obj:bindFunctionKeys(shortcuts)
    functionKeys = shortcuts
end

function obj:bindAppRemapKeys(shortcuts)
    appRemapKeys = shortcuts
end

function obj:bindOSRemapKeys(shortcuts)
    osRemapKeys = shortcuts
end

function obj:setDebugMode(dbg)
    debug = dbg
end

function obj:start(maps)
    buildOSModal():enter()
    buildFunctionModal():enter()
    buildAppModal()
    appWatcher:start()
end

return obj
