-- Servicios de Roblox
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variables de configuración
_G.AutoFarm = true
_G.AutoATM = true
_G.FlySpeed = 50 -- Velocidad de movimiento (ajusta si es muy lento)

-- Función de movimiento suave (Bypass de teletransporte)
local function smoothMove(targetCFrame)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        local duration = distance / _G.FlySpeed
        
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        
        tween:Play()
        tween.Completed:Wait() -- Espera a llegar al destino
    end
end

-- Función para Agricultura
task.spawn(function()
    while _G.AutoFarm do
        task.wait(0.5)
        local farmFolder = workspace:FindFirstChild("Farms")
        if farmFolder then
            for _, crop in pairs(farmFolder:GetChildren()) do
                if crop:FindFirstChild("Ready") and crop.Ready.Value == true then
                    smoothMove(crop.CFrame)
                    task.wait(0.2)
                    fireproximityprompt(crop:FindFirstChildOfClass("ProximityPrompt"))
                end
            end
        end
    end
end)

-- Función para ATMs
task.spawn(function()
    while _G.AutoATM do
        task.wait(1)
        local atmFolder = workspace:FindFirstChild("ATMs")
        if atmFolder then
            for _, atm in pairs(atmFolder:GetChildren()) do
                smoothMove(atm.CFrame)
                task.wait(0.2)
                fireproximityprompt(atm:FindFirstChildOfClass("ProximityPrompt"))
            end
        end
    end
end)
