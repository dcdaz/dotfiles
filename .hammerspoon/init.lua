------------
-- AltTab --
------------

local altTab = hs.loadSpoon('AltTab')

local cfg = {
    showThumbnails = false,
    showSelectedThumbnail = false,
    showTitles = false,
    highlightColor = {0.2,0.4,0.9,0.7},
    backgroundColor = {0.2,0.2,0.2,0.9},
    onlyActiveApplication = false,
    modifier = 'cmd'
}

altTab:bindConfiguration(cfg)
altTab:start()

-----------------
-- Custom Keys --
-----------------

local keys = hs.loadSpoon('CustomKeys')
local optionKey = {'alt'}
local controlKey = {'ctrl'}
local commandKey = {'cmd'}
local shiftKey = {'shift'}
local optcmdKey = {'alt', 'cmd'}
local ctrloptKey = {'ctrl', 'alt'}
local ctrlshiftKey = {'ctrl', 'shift'}
local optshiftKey = {'alt', 'shift'}
local cmdshiftKey = {'cmd', 'shift'}
local hyperKey = {'ctr', 'alt', 'cmd'}

local function openAppWithParams(appName, params)
    local task = hs.task.new(
        appName, 
        nil,
        function() return false end,
        params
    )
    task:start()
  end

local osRemapKeys = {
    {from = {modifiers = commandKey, character = 'q'}, to = {modifiers = commandKey, character = 'F4'}},
    {from = {modifiers = commandKey, character = 'Up'}, to = {modifiers = controlKey, character = 'home'}},
    {from = {modifiers = commandKey, character = 'Down'}, to = {modifiers = controlKey, character = 'end'}},
    {from = {modifiers = commandKey, character = 'Left'}, to = {character = 'home'}},
    {from = {modifiers = commandKey, character = 'Right' }, to = {character = 'end'}},
    {from = {modifiers = cmdshiftKey, character = 'Left'}, to = {modifiers = shiftKey, character = 'home'}},
    {from = {modifiers = cmdshiftKey, character = 'Right' }, to = {modifiers= shiftKey, character = 'end'}},
}

local functionMapKeys = {
    -- Moving Windows
    {modifiers = optionKey, character = 'Left', fn = function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end},
    {modifiers = optionKey, character = 'Right', fn = function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end},
    {modifiers = optionKey, character = 'Up', fn = function() hs.window.focusedWindow():moveToUnit(hs.layout.maximized) end},
    {modifiers = optcmdKey, character = 'Left', fn = function() hs.window.focusedWindow():moveToUnit(keys.positions.leftBottom) end},
    {modifiers = optcmdKey, character = 'Right', fn = function() hs.window.focusedWindow():moveToUnit(keys.positions.rightBottom) end},
    {modifiers = ctrloptKey, character = 'Up', fn = function() hs.window.focusedWindow():moveToUnit(keys.positions.top) end},
    {modifiers = ctrloptKey, character = 'Down', fn = function() hs.window.focusedWindow():moveToUnit(keys.positions.bottom) end},
    {modifiers = ctrloptKey, character = 'Left', fn = function() hs.window.focusedWindow():moveToUnit(keys.positions.leftTop) end},
    {modifiers = ctrloptKey, character = 'Right', fn = function() hs.window.focusedWindow():moveToUnit(keys.positions.rightTop) end},

    -- Reload Hammerspoon Config
    {modifiers = ctrloptKey, character = 'r', fn = hs.reload},

    -- Desktop manage
    {modifiers = optionKey, character = '`', fn = function() hs.spaces.toggleMissionControl() end},
    {modifiers = optionKey, character = 'd', fn = function() hs.spaces.toggleShowDesktop() end},
    {modifiers = optionKey, character = 'l', fn = function() hs.caffeinate.lockScreen() end},

    -- Apps
    {modifiers = optionKey, character = 't', fn = function() hs.application.launchOrFocus('Alacritty') end},
    {modifiers = optionKey, character = 'v', fn = function() hs.application.launchOrFocus('VSCodium') end},
    {modifiers = optionKey, character = 'f', fn = function() hs.application.launchOrFocus('Firefox') end},
    -- {modifiers = optshiftKey, character = 'f', fn = function() hs.application.open('~/.local/bin/wolf') end},
    {modifiers = optshiftKey, character = 'f', fn = function() openAppWithParams('/Applications/LibreWolf.app/Contents/MacOS/librewolf', {'--private-window'}) end},
    {modifiers = optshiftKey, character = 'd', fn = function() openAppWithParams('/usr/bin/open', {'~/Downloads'}) end},
}

local textHandleKeys = {
    {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'c'}},
    {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'v'}},
    {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'x'}},
    {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'a'}},
    -- {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'f'}},
    {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 's'}},
    {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'z'}},
    {from = {modifiers = cmdshiftKey,}, to = {modifiers = ctrlshiftKey, character = 'z'}},
}

local appRemapKeys = {
    {
        appNames = {'Firefox', 'LibreWolf'},
        remapKeys = {
            -- Linux Management
            {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 't'}},
            {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'w'}},
            {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'n'}},
            {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'k'}},
            {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'l'}},
            {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'f'}},
            {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'd'}},
            {from = {modifiers = cmdshiftKey,}, to = {modifiers = ctrlshiftKey, character = 'p'}},
            {from = {modifiers = cmdshiftKey,}, to = {modifiers = ctrlshiftKey, character = 't'}},
        }
    },
    {
        appNames = {
            'Firefox',
            'LibreWolf',
            'VSCodium',
            'MacVim',
            'Finder',
            'zoom.us',
            'Insomnium',
            'DBeaver Community',
            'Ferdium',
            'Microsoft Outlook'
        },
        remapKeys = {
            table.unpack(textHandleKeys),
        }
    },
    {
        appNames = {'VSCodium', 'MacVim'},
        remapKeys = {
            {from = {modifiers = commandKey}, to = {modifiers = controlKey, character = '/'}},
            {from = {modifiers = cmdshiftKey,}, to = {modifiers = ctrlshiftKey, character = 'f'}},
            {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'f'}},
        }
    },
    {
        appNames = {'Alacritty'},
        remapKeys = {
            {from = {modifiers = commandKey,}, to = {modifiers = ctrlshiftKey, character = 'v'}},
        }
    },
    {
        appNames = {'Ferdium'},
        remapKeys = {
            {from = {modifiers = commandKey,}, to = {modifiers = controlKey, character = 'u'}},
        }
    },
}

keys:bindOSRemapKeys(osRemapKeys)
keys:bindFunctionKeys(functionMapKeys)
keys:bindAppRemapKeys(appRemapKeys)
-- keys:setDebugMode(true)
keys:start()
