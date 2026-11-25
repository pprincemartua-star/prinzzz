-- ==========================================
-- PRINZZ MACRO V4
-- Android GUI
-- ==========================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Config = {
    Active = false,
    Firing = false,
    Delay = 0.12,
    PressDuration = 0.04,
    FixedMode = false
}

local Gui = Instance.new("ScreenGui")
Gui.Name = "PRINZZ_V4"
Gui.ResetOnSpawn = false

local ok = pcall(function()
    Gui.Parent = game:GetService("CoreGui")
end)

if not ok or not Gui.Parent then
    Gui.Parent = Player:WaitForChild("PlayerGui")
end

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(250, 310)
Frame.Position = UDim2.new(0.5, -125, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,25)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = Gui

local function corner(obj)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,8)
    c.Parent = obj
end

corner(Frame)

local function makeLabel(text, y, height)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-20,0,height)
    l.Position = UDim2.fromOffset(10,y)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(230,230,230)
    l.TextSize = 13
    l.Parent = Frame
    return l
end

local function makeButton(text,y,color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-20,0,36)
    b.Position = UDim2.fromOffset(10,y)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 14
    b.Font = Enum.Font.GothamBold
    b.Parent = Frame
    corner(b)
    return b
end

makeLabel("PRINZZ MACRO V4",5,30)

local Start = makeButton(
    "START",
    40,
    Color3.fromRGB(0,130,0)
)

local Stop = makeButton(
    "STOP",
    82,
    Color3.fromRGB(150,30,30)
)

local Fire = makeButton(
    "TEMBAK (TAHAN)",
    124,
    Color3.fromRGB(40,80,170)
)

local DelayLabel = makeLabel(
    "Jeda: 0.12s",
    169,
    20
)

local DelayMinus = makeButton(
    "JEDA -",
    192,
    Color3.fromRGB(60,60,70)
)

local DelayPlus = makeButton(
    "JEDA +",
    232,
    Color3.fromRGB(60,60,70)
)

local Mode = makeButton(
    "MODE: KURSOR BEBAS",
    272,
    Color3.fromRGB(60,60,70)
)

local function update()
    DelayLabel.Text = string.format(
        "Jeda: %.2fs | Durasi: %.2fs",
        Config.Delay,
        Config.PressDuration
    )
end

Start.MouseButton1Click:Connect(function()
    Config.Active = true
    Start.Text = "MACRO AKTIF"
end)

Stop.MouseButton1Click:Connect(function()
    Config.Active = false
    Config.Firing = false
    Start.Text = "START"
    Fire.Text = "TEMBAK (TAHAN)"
end)

local function beginFire()
    if Config.Active then
        Config.Firing = true
        Fire.Text = "SEDANG DITEKAN"
    end
end

local function endFire()
    Config.Firing = false
    Fire.Text = "TEMBAK (TAHAN)"
end

Fire.MouseButton1Down:Connect(beginFire)
Fire.MouseButton1Up:Connect(endFire)

DelayMinus.MouseButton1Click:Connect(function()
    Config.Delay = math.max(0.02, Config.Delay - 0.02)
    update()
end)

DelayPlus.MouseButton1Click:Connect(function()
    Config.Delay = math.min(0.50, Config.Delay + 0.02)
    update()
end)

Mode.MouseButton1Click:Connect(function()
    Config.FixedMode = not Config.FixedMode

    Mode.Text = Config.FixedMode
        and "MODE: TITIK TENGAH"
        or "MODE: KURSOR BEBAS"
end)

update()
