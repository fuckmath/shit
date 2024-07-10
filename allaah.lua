local requireModule = assert(getrenv().shared.require, "Script wasn't ran on actor!")
local weaponController = requireModule("WeaponControllerInterface")

print(weaponController)
