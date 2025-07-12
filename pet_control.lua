local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- store the position the player selects
local selectedPetPosition = nil

-- 🐾 function to move pet to chosen point
local function movePetToSelectedPosition()
    if selectedPetPosition then
        -- Replace below with real RemoteEvent / function to move your pet
        -- game:GetService("ReplicatedStorage").MovePet:FireServer(selectedPetPosition)
        print("[Pet] Moving pet to position:", selectedPetPosition)
    else
        warn("[Pet] No position selected yet!")
    end
end

-- ✨ function to make pet use its ability at current position
local function usePetAbility()
    -- Replace below with real RemoteEvent to trigger pet's ability
    -- game:GetService("ReplicatedStorage").PetAbility:FireServer()
    print("[Pet] Using ability at position:", selectedPetPosition)
end

-- 📍 click somewhere to select where the pet should stop
mouse.Button1Down:Connect(function()
    -- get the 3D point in the world where the player clicked
    local target = mouse.Hit
    if target then
        selectedPetPosition = target.Position
        print("[Pet] Selected new stop position:", selectedPetPosition)

        -- move pet there immediately
        movePetToSelectedPosition()

        -- and optionally use ability right away
        usePetAbility()
    end
end)

-- 🛠 you could also call usePetAbility() repeatedly if you want the pet to keep using ability:
--[[
while true do
    if selectedPetPosition then
        usePetAbility()
    end
    wait(5) -- adjust the delay between abilities
end
]]

print("🌱 Pet control script loaded! Click anywhere to set where your pet will stop & use ability.")
