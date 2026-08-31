local target_apps = {
    "Ferdium",
    "ferdium",
    "thunderbird"
}

local current_app = get_window_class()

for _, app in ipairs(target_apps) do
    if current_app == app then
        set_window_workspace(2)
        break
    end
end

