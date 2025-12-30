-- [ SERVICIOS ]
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- [ VARIABLES DE CONTROL ]
_G.AutoFarm = false
_G.AutoATM = false
_G.FlySpeed = 50

-- [ CREACIÓN DE LA UI ]
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmBtn = Instance.new("TextButton")
local ATMBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Configuración de la Ventana Principal
ScreenGui.Parent = CoreGui
MainFrame.Name = "BlockSpinMenu"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true -- Movible para móviles

local FrameCorner = UICorner:Clone()
FrameCorner.Parent = MainFrame

-- Título
Title.Parent = MainFrame
Title.Text = "BLOCK SPIN 2025"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
UICorner.Parent = Title

-- Botón Auto Farm
FarmBtn.Parent = MainFrame
FarmBtn.Text = "Auto Farm: OFF"
FarmBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
FarmBtn.Size = UDim2.new(0.8, 0, 0, 35)
FarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.Font = Enum.Font.Gotham
local BtnCorner1 = UICorner:Clone()
BtnCorner1.Parent = FarmBtn

-- Botón Auto ATM
ATMBtn.Parent = MainFrame
ATMBtn.Text = "Auto ATM: OFF"
ATMBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
ATMBtn.Size = UDim2.new(0.8, 0, 0, 35)
ATMBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ATMBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ATMBtn.Font = Enum.Font.Gotham
local BtnCorner2 = UICorner:Clone()
BtnCorner2.Parent = ATMBtn

-- [ LÓGICA DE MOVIMIENTO ]
local function smoothMove(targetCFrame)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        local duration = distance / _G.FlySpeed
        
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        
        tween:Play()
        tween.Completed:Wait()
    end
end

-- [ FUNCIONES DE LOS BOTONES ]
FarmBtn.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm
    FarmBtn.Text = "Auto Farm: " .. (_G.AutoFarm and "ON" or "OFF")
    FarmBtn.BackgroundColor3 = _G.AutoFarm and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

ATMBtn.MouseButton1Click:Connect(function()
    _G.AutoATM = not _G.AutoATM
    ATMBtn.Text = "Auto ATM: " .. (_G.AutoATM and "ON" or "OFF")
    ATMBtn.BackgroundColor3 = _G.AutoATM and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

-- [ BUCLES DE EJECUCIÓN ]
task.spawn(function()
    while true do
        task.wait(0.5)
        if _G.AutoFarm then
            local farmFolder = workspace:FindFirstChild("Farms")
            if farmFolder then
                for _, crop in pairs(farmFolder:GetChildren()) do
                    if _G.AutoFarm and crop:FindFirstChild("Ready") and crop.Ready.Value == true then
                        smoothMove(crop.CFrame)
                        task.wait(0.2)
                        fireproximityprompt(crop:FindFirstChildOfClass("ProximityPrompt"))
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if _G.AutoATM then
            local atmFolder = workspace:FindFirstChild("ATMs")
            if atmFolder then
                for _, atm in pairs(atmFolder:GetChildren()) do
                    if _G.AutoATM then
                        smoothMove(atm.CFrame)
                        task.wait(0.2)
                        fireproximityprompt(atm:FindFirstChildOfClass("ProximityPrompt"))
                    end
                end
            end
        end
    end
end)

print("Script Block Spin con UI cargado correctamente.")
