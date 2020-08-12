--- === ReloadConfiguration ===
---
--- Adds a hotkey to reload the hammerspoon configuration, and a pathwatcher to automatically reload on changes.
---
--- Download original, non-better version: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/ReloadConfiguration.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/ReloadConfiguration.spoon.zip)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "BetterReloadConfiguration"
obj.version = "1.1"
obj.author = "Jon Lorusso <jonlorusso@gmail.com>, Better by Matt Stauffer <matt@tighten.co>"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"


--- ReloadConfiguration.watch_paths
--- Variable
--- List of directories to watch for changes, defaults to hs.configdir
obj.watch_paths = { hs.configdir }

--- ReloadConfiguration:bindHotkeys(mapping)
--- Method
--- Binds hotkeys for ReloadConfiguration
---
--- Parameters:
---  * mapping - A table containing hotkey modifier/key details for the following items:
---   * reloadConfiguration - This will cause the configuration to be reloaded
function obj:bindHotkeys(mapping)
   local def = { reloadConfiguration = hs.fnutils.partial(hs.reload, self) }
   hs.spoons.bindHotkeysToSpec(def, mapping)
end

--- ReloadConfiguration:reloadConfig(files)
--- Method
--- Only triggers reload if modified files end in .lua; stolen from Hammerspoon docs
---
--- Parameters:
---  * files - An (array?) containing all of the modified files? Maybe?
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

--- ReloadConfiguration:start()
--- Method
--- Start ReloadConfiguration
---
--- Parameters:
---  * None
function obj:start()
    self.watchers = {}
    for _,dir in pairs(self.watch_paths) do
        self.watchers[dir] = hs.pathwatcher.new(dir, reloadConfig):start()
    end
    return self
end

return obj
