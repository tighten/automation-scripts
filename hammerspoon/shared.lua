bear = 'net.shinyfrog.bear'
chrome = 'com.google.Chrome'
discord = 'com.hnc.Discord'
finder = 'com.apple.finder'
firefox = 'org.mozilla.firefoxdeveloperedition'
fork = 'com.DanPristupov.Fork'
iterm = 'com.googlecode.iterm2'
messages = 'com.apple.iChat'
omnifocus = 'com.omnigroup.OmniFocus3'
phpstorm = 'com.jetbrains.PhpStorm'
preview = 'com.apple.Preview'
simulator = 'com.apple.iphonesimulator'
slack = 'com.tinyspeck.slackmacgap'
spotify = 'com.spotify.client' 
tableplus = 'com.tinyapp.TablePlus'
vscode = 'com.microsoft.VSCode'

-- Re-load Hammerspoon config when file is modified
hs.loadSpoon('ReloadConfiguration')
spoon.ReloadConfiguration:start()
hs.notify.new({title = 'Hammerspoon', informativeText = 'Config loaded'}):send()

-- Common functions
function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function appIs(bundle)
    return getBundleId() == bundle
end

function appIncludes(bundles)
    return has_value(bundles, getBundleId())
end

function getBundleId()
    return hs.application.frontmostApplication():bundleID();
end

-- Triggers

--- Open Anything
hs.urlevent.bind('openAnything', function()
    if appIncludes({vscode, tableplus, fork}) then
        hs.eventtap.keyStroke({'cmd'}, 'p')
    elseif appIs(simulator) then
        hs.eventtap.keyStroke({'ctrl, shift, cmd'}, 'h')
    elseif appIncludes({slack, discord}) then
        hs.eventtap.keyStroke({'cmd'}, 'k')
    elseif appIs(phpstorm) then
        hs.eventtap.keyStroke({'cmd, shift'}, 'o')
    elseif appIs(finder) then
        triggerAlfredSearch('o')
    elseif appIncludes({chrome, firefox}) then
        triggerAlfredSearch('bm')
    elseif appIs(omnifocus) then
        hs.eventtap.keyStroke({'cmd'}, 'o')
    elseif appIs(bear) then
        hs.eventtap.keyStroke({'cmd', 'shift'}, 'f')
    elseif true then
        bundleId = getBundleId();
        hs.notify.new(
            function() hs.pasteboard.setContents(bundleId) end,
            {
                title = 'Hammerspoon',
                informativeText = 'Open Anything not set up',
                actionButtonTitle = 'Copy Bundle ID',
                alwaysShowAdditionalActions = true,
                hasActionButton = true
            }):send()
    end
end)
