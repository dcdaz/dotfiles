local obj = {}
obj.__index = obj

-- Metadata
obj.name = "AltTab"
obj.version = "1.0"
obj.author = "Daniel Cordova <danesc87@gmail.com>"
obj.homepage = "https://github.com/dcdaz/spoons"
obj.license = "GPL3"

local altTabSwitcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})

local cfg = {
    showThumbnails = false,
    showSelectedThumbnail = true,
    showTitles = false,
    highlightColor = {0.2,0.4,0.9,0.7},
    backgroundColor = {0.2,0.2,0.2,0.9},
    onlyActiveApplication = false,
    modifier = 'cmd'
}

local function configAltTabSwitcher()
    altTabSwitcher.ui.showThumbnails = cfg.showThumbnails
    altTabSwitcher.ui.showSelectedThumbnail = cfg.showSelectedThumbnail
    altTabSwitcher.ui.showTitles = cfg.showTitles
    altTabSwitcher.ui.highlightColor = cfg.highlightColor
    altTabSwitcher.ui.backgroundColor = cfg.backgroundColor
    altTabSwitcher.ui.onlyActiveApplication = cfg.onlyActiveApplication
end

local function altTab(event)
    local flags = event:getFlags()
    local chars = event:getCharacters()

    if chars == '\t' and flags:containExactly{cfg.modifier} then
        altTabSwitcher:next()
        return true
    elseif chars == string.char(25) and flags:containExactly{cfg.modifier,'shift'} then
        altTabSwitcher:previous()
        return true
    end
end

function obj:bindConfiguration(config)
    cfg = config
end

function obj:start()
    configAltTabSwitcher()
    startAltTab = hs.eventtap.new({hs.eventtap.event.types.keyDown}, altTab)
    startAltTab:start()
end

return obj
