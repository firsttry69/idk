local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local selectedPetPosition = nil

print("🌱 [PetControl] Script loaded! Tap or click anywhere to choose where your pet stops & uses ability.")

-- 🐾 Move pet
local function movePetToSelectedPosition()
    if selectedPetPosition then
        -- 🔧 Replace below with real RemoteEvent to move your pet:
        -- game:GetService("ReplicatedStorage").MovePet:FireServer(selectedPetPosition)
        print("[PetControl] Moving pet to:", selectedPetPosition)
    else
        warn("[PetControl] No position selected yet!")
    end
end

-- ✨ Use pet ability
local function usePetAbility()
    -- 🔧 Replace below with real RemoteEvent:
    -- game:GetService("ReplicatedStorage").PetAbility:FireServer()
    print("[PetControl] Pet using ability at:", selectedPetPosition)
end

-- 📍 Handle PC click
mouse.Button1Down:Connect(function()
    local target = mouse.Hit
    if target then
        selectedPetPosition = target.Position
        print("[PetControl] New position selected (PC):", selectedPetPosition)
        movePetToSelectedPosition()
        usePetAbility()
    end
end)

-- 📱 Handle mobile tap
UIS.TouchTap:Connect(function(touchPositions, isProcessed)
    if isProcessed then return end
    if #touchPositions > 0 then
        -- project tap into 3D space
        local camera = workspace.CurrentCamera
        local viewportPoint = touchPositions[1]
        local unitRay = camera:ViewportPointToRay(viewportPoint.X, viewportPoint.Y)
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {player.Character}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        local raycastResult = workspace:Raycast(unitRay.Origin, unitRay.Direction * 500, raycastParams)
        if raycastResult then
            selectedPetPosition = raycastResult.Position
            print("[PetControl] New position selected (Mobile):", selectedPetPosition)
            movePetToSelectedPosition()
            usePetAbility()
        end
    end
end)

-- ✅ Optional: auto use ability every X seconds
--[[
while true do
    if selectedPetPosition then
        usePetAbility()
    end
    wait(5)
end
]]
