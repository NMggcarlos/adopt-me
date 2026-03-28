if game.PlaceId ~= 920587237 then
    warn("NM_scripts: Este script está forzado para funcionar solo en Adopt Me.")
    return
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local API = ReplicatedStorage:WaitForChild("API")

local lp = Players.LocalPlayer
local toggleCandy = false

-- Función Anti-AFK Ultra Segura (Bypass moderno)
local function enableAntiAFK()
    lp.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
    pcall(function()
        for _, connection in pairs(getconnections(lp.Idled)) do
            if connection.Disable then connection:Disable()
            elseif connection.Disconnect then connection:Disconnect() end
        end
    end)
    print("🛡️ [Adopt Me Farm] Anti-AFK Ultra Integrado Activado Automáticamente.")
end
enableAntiAFK()

-- Función Auto Cobrar Bonos de Banco (Paycheck automático en ventana gui)
local function autoCobrarBanco()
    task.spawn(function()
        while task.wait(5) do
            pcall(function()
                for _, gui in ipairs(lp.PlayerGui:GetChildren()) do
                    if gui:IsA("ScreenGui") and gui.Enabled then
                        for _, v in ipairs(gui:GetDescendants()) do
                            if v:IsA("TextLabel") or v:IsA("TextButton") then
                                local t = string.lower(v.Text)
                                if string.match(t, "cobrar") or string.match(t, "claim") or t == "cash" then
                                    local btn = v
                                    if not btn:IsA("TextButton") and not btn:IsA("ImageButton") then
                                        if btn.Parent:IsA("TextButton") or btn.Parent:IsA("ImageButton") then
                                            btn = btn.Parent
                                        end
                                    end
                                    if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                                        local cons = getconnections(btn.MouseButton1Click)
                                        if cons then
                                            for _, c in pairs(cons) do
                                                if c.Function then c.Function() else c:Fire() end
                                            end
                                        end
                                        local cons2 = getconnections(btn.MouseButton1Down)
                                        if cons2 then
                                            for _, c in pairs(cons2) do
                                                if c.Function then c.Function() else c:Fire() end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
    print("💸 [Adopt Me Farm] Auto Cobrar Bonos (Paycheck) Activado por defecto.")
end
autoCobrarBanco()

-- ==========================================
-- CREACIÓN DE INTERFAZ "ADOPT ME STYLE"
-- ==========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CandyFarmGui_AM"
screenGui.ResetOnSpawn = false
screenGui.Parent = lp:WaitForChild("PlayerGui")

-- Colores Pastel
local colorPinkBase = Color3.fromRGB(255, 182, 193)    -- Rosa Pastel
local colorWhite = Color3.fromRGB(250, 250, 250)       -- Blanco hueso
local colorSidebar = Color3.fromRGB(255, 230, 235)     -- Rosa muy tenue (Fondo Sidebar)
local colorTextDark = Color3.fromRGB(80, 80, 80)       -- Gris oscuro (Letras)
local colorToggleOff = Color3.fromRGB(220, 220, 225)   -- Gris Toggle Abajo
local colorToggleOn = Color3.fromRGB(150, 230, 150)    -- Verde Pastel Brillante

-- Contenedor Global (Permite Minimizar Fácilmente)
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(0, 420, 0, 260)
Container.Position = UDim2.new(0.5, -210, 0.5, -130)
Container.BackgroundTransparency = 1
Container.Parent = screenGui

-- Sombra simulada oscura de fondo (Borde 3D del menú entero)
local DropShadow = Instance.new("ImageLabel")
DropShadow.Name = "DropShadow"
DropShadow.Size = UDim2.new(1, 14, 1, 18)
DropShadow.Position = UDim2.new(0, -7, 0, 7)
DropShadow.BackgroundTransparency = 1
DropShadow.Image = "rbxassetid://13192801451"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.75
DropShadow.Parent = Container

-- Main Frame (Cuerpo del menú)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = colorWhite
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = Container

-- Borde exterior tipo "Caricatura" (Cartoony Outline)
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(200, 150, 160)
MainStroke.Thickness = 3
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Header (Barra superior rosa pastel)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 45) -- Más alto para el 3D
Header.BackgroundColor3 = colorPinkBase
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

-- Efecto 3D inferior del Header (Borde Caricatura)
local HeaderPatch = Instance.new("Frame")
HeaderPatch.Size = UDim2.new(1, 0, 0, 10)
HeaderPatch.Position = UDim2.new(0, 0, 1, -10)
HeaderPatch.BackgroundColor3 = colorPinkBase
HeaderPatch.BorderSizePixel = 0
HeaderPatch.Parent = Header

local Header3DShadow = Instance.new("Frame")
Header3DShadow.Size = UDim2.new(1, 0, 0, 4)
Header3DShadow.Position = UDim2.new(0, 0, 1, 0)
Header3DShadow.BackgroundColor3 = Color3.fromRGB(230, 150, 165) -- Rosa oscuro 3D
Header3DShadow.BorderSizePixel = 0
Header3DShadow.ZIndex = 2
Header3DShadow.Parent = Header

-- Sombra suave en el texto del Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.6, 0, 1, -4)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌸 NM_scripts"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 21
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = Header

local TitleShadow = Instance.new("UIStroke")
TitleShadow.Color = Color3.fromRGB(210, 130, 145)
TitleShadow.Thickness = 2
TitleShadow.Parent = Title

-- Botones Chubby (Con efecto botón real 3D)
local function createChubbyButton(name, color, colorDark, text, posX, parent)
    local Btn = Instance.new("TextButton")
    Btn.Name = name
    Btn.Size = UDim2.new(0, 26, 0, 26)
    Btn.Position = UDim2.new(1, posX, 0.5, -13)
    Btn.BackgroundColor3 = color
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.FredokaOne
    Btn.TextSize = 14
    Btn.AutoButtonColor = false
    Btn.ZIndex = 4
    Btn.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = Btn
    
    local Outline = Instance.new("UIStroke")
    Outline.Color = colorDark
    Outline.Thickness = 2
    Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Outline.Parent = Btn
    
    -- El fondo para simular profundidad
    local Depth = Instance.new("Frame")
    Depth.Size = UDim2.new(1, 0, 1, 3)
    Depth.Position = UDim2.new(0, 0, 0, 0)
    Depth.BackgroundColor3 = colorDark
    Depth.ZIndex = 3
    Depth.Parent = Btn
    
    local DepthCor = Instance.new("UICorner")
    DepthCor.CornerRadius = UDim.new(1, 0)
    DepthCor.Parent = Depth
    
    Btn.MouseButton1Down:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.05), {Position = UDim2.new(1, posX, 0.5, -10)}):Play()
    end)
    Btn.MouseButton1Up:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {Position = UDim2.new(1, posX, 0.5, -13)}):Play()
    end)
    
    return Btn
end

local MinButton = createChubbyButton("MinButton", Color3.fromRGB(250, 210, 110), Color3.fromRGB(210, 160, 80), "-", -70, Header)
local CloseButton = createChubbyButton("CloseButton", Color3.fromRGB(255, 120, 120), Color3.fromRGB(200, 80, 80), "✖", -37, Header)

-- Botón Redondo NM Minimizado
local MinimizedFab = Instance.new("TextButton")
MinimizedFab.Name = "MinimizedFab"
MinimizedFab.Size = UDim2.new(0, 50, 0, 50)
MinimizedFab.Position = UDim2.new(0.5, -25, 0, 10)
MinimizedFab.BackgroundColor3 = colorWhite
MinimizedFab.Text = "NM"
MinimizedFab.TextColor3 = colorPinkBase
MinimizedFab.Font = Enum.Font.FredokaOne
MinimizedFab.TextSize = 22
MinimizedFab.Visible = false
MinimizedFab.Parent = screenGui

local FabCorner = Instance.new("UICorner")
FabCorner.CornerRadius = UDim.new(1, 0)
FabCorner.Parent = MinimizedFab

local FabStroke = Instance.new("UIStroke")
FabStroke.Color = Color3.fromRGB(220, 150, 165)
FabStroke.Thickness = 3
FabStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FabStroke.Parent = MinimizedFab

local FabShadow = Instance.new("ImageLabel")
FabShadow.Size = UDim2.new(1, 14, 1, 18)
FabShadow.Position = UDim2.new(0, -7, 0, 7)
FabShadow.BackgroundTransparency = 1
FabShadow.Image = "rbxassetid://13192801451"
FabShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
FabShadow.ImageTransparency = 0.75
FabShadow.ZIndex = -1
FabShadow.Parent = MinimizedFab

local f_dragging, f_startPos, f_dragStart
MinimizedFab.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        f_dragging = true
        f_dragStart = input.Position
        f_startPos = MinimizedFab.Position
        local c = nil
        c = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                f_dragging = false
                c:Disconnect()
            end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if f_dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - f_dragStart
        MinimizedFab.Position = UDim2.new(f_startPos.X.Scale, f_startPos.X.Offset + delta.X, f_startPos.Y.Scale, f_startPos.Y.Offset + delta.Y)
    end
end)

MinButton.MouseButton1Click:Connect(function()
    Container.Visible = false
    MinimizedFab.Visible = true
    MinimizedFab.Position = UDim2.new(0, Container.AbsolutePosition.X + Container.AbsoluteSize.X/2 - 25, 0, Container.AbsolutePosition.Y)
end)

MinimizedFab.MouseButton1Click:Connect(function()
    Container.Visible = true
    MinimizedFab.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
    toggleCandy = false
    screenGui:Destroy()
end)

-- Sidebar (Panel Izquierdo con pestañas)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 120, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = colorSidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 16)
SidebarCorner.Parent = Sidebar

-- Borde separador 3D para el sidebar (Puesto afuera de la lista para no romper los botones)
local SidebarBorder = Instance.new("Frame")
SidebarBorder.Size = UDim2.new(0, 2, 1, -45)
SidebarBorder.Position = UDim2.new(0, 118, 0, 45)
SidebarBorder.BackgroundColor3 = Color3.fromRGB(240, 210, 220)
SidebarBorder.BorderSizePixel = 0
SidebarBorder.Parent = MainFrame

local TabsList = Instance.new("UIListLayout")
TabsList.Padding = UDim.new(0, 5)
TabsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabsList.SortOrder = Enum.SortOrder.LayoutOrder
TabsList.Parent = Sidebar

local TabsPadding = Instance.new("UIPadding")
TabsPadding.PaddingTop = UDim.new(0, 10)
TabsPadding.PaddingBottom = UDim.new(0, 10)
TabsPadding.Parent = Sidebar

-- Espacio vacío para rellenar la barra lateral (así "Info" se va abajo)
local Spacer = Instance.new("Frame")
Spacer.Size = UDim2.new(1, 0, 1, -120) -- Adapta dinámicamente el tamaño
Spacer.BackgroundTransparency = 1
Spacer.LayoutOrder = 10
Spacer.Parent = Sidebar

-- Area de contenido (Páginas)
local Pages = Instance.new("Frame")
Pages.Name = "Pages"
Pages.Size = UDim2.new(1, -120, 1, -40)
Pages.Position = UDim2.new(0, 120, 0, 40)
Pages.BackgroundTransparency = 1
Pages.ZIndex = 2
Pages.Parent = MainFrame

local activeTabBtn = nil
local activePage = nil

-- Función maestra creadora de Pestañas ("Tabs")
local function createTab(name, titleText, layoutOrder)
    local Btn = Instance.new("TextButton")
    Btn.Name = name.."Tab"
    Btn.Size = UDim2.new(0.85, 0, 0, 35)
    Btn.BackgroundColor3 = colorSidebar
    Btn.Text = titleText
    Btn.TextColor3 = colorTextDark
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.AutoButtonColor = false
    Btn.LayoutOrder = layoutOrder
    Btn.Parent = Sidebar
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    
    -- Efecto de botón deseleccionado 3D
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(240, 210, 220)
    Stroke.Thickness = 1
    Stroke.Parent = Btn
    
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name.."Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 5
    Page.ScrollBarImageColor3 = colorPinkBase
    Page.Visible = false
    Page.Parent = Pages
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Parent = Page
    
    local PagePadding = Instance.new("UIPadding")
    PagePadding.PaddingTop = UDim.new(0, 15)
    PagePadding.Parent = Page
    
    Btn.MouseButton1Click:Connect(function()
        if activeTabBtn then
            TweenService:Create(activeTabBtn, TweenInfo.new(0.2), {BackgroundColor3 = colorSidebar}):Play()
            activeTabBtn:FindFirstChild("UIStroke").Color = Color3.fromRGB(240, 210, 220)
            activeTabBtn:FindFirstChild("UIStroke").Thickness = 1
            activePage.Visible = false
        end
        activeTabBtn = Btn
        activePage = Page
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = colorWhite}):Play()
        Btn:FindFirstChild("UIStroke").Color = colorPinkBase
        Btn:FindFirstChild("UIStroke").Thickness = 2
        Page.Visible = true
    end)
    
    return Btn, Page
end

local TabAdoptMe, PageAdoptMe = createTab("AdoptMe", "🐾 Adopt Me", 1)
local TabPlayer, PagePlayer = createTab("Player", "👤 Player", 2)
local TabInfo, PageInfo = createTab("Info", "ℹ️ Info", 11) -- N° 11 para que quede debajo del spacer

-- Encender pestaña base
TabAdoptMe.BackgroundColor3 = colorWhite
PageAdoptMe.Visible = true
activeTabBtn = TabAdoptMe
activePage = PageAdoptMe

-- ==========================================
-- CREACIÓN DE TOGGLES TIPO TELEFÓNO (Con Sombra 3D)
-- ==========================================
local function createToggleSwitch(page, titleText, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.9, 0, 0, 48)
    Frame.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    Frame.Parent = page
    
    -- Marco 3D simulado de AdoptMe
    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Color3.fromRGB(230, 230, 230)
    FrameStroke.Thickness = 2
    FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    FrameStroke.Parent = Frame
    
    local FrameDepth = Instance.new("Frame")
    FrameDepth.Size = UDim2.new(1, 0, 1, 3)
    FrameDepth.Position = UDim2.new(0, 0, 0, 0)
    FrameDepth.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    FrameDepth.ZIndex = 0
    FrameDepth.Parent = Frame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Frame
    
    local CornerDepth = Instance.new("UICorner")
    CornerDepth.CornerRadius = UDim.new(0, 12)
    CornerDepth.Parent = FrameDepth
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = titleText
    Label.TextColor3 = colorTextDark
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    -- El Switch interactivo (Píldora grisesita Cartoony)
    local Track = Instance.new("TextButton")
    Track.Size = UDim2.new(0, 48, 0, 26)
    Track.Position = UDim2.new(1, -60, 0.5, -13)
    Track.BackgroundColor3 = colorToggleOff
    Track.Text = ""
    Track.AutoButtonColor = false
    Track.Parent = Frame
    
    local TrackStroke = Instance.new("UIStroke")
    TrackStroke.Color = Color3.fromRGB(200, 200, 200)
    TrackStroke.Thickness = 2
    TrackStroke.Parent = Track
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = Track
    
    -- El Círculo interior
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 22, 0, 22)
    Knob.Position = UDim2.new(0, 2, 0.5, -11)
    Knob.BackgroundColor3 = colorWhite
    Knob.Parent = Track
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local state = false
    Track.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(Track, TweenInfo.new(0.25), {BackgroundColor3 = colorToggleOn}):Play()
            TrackStroke.Color = Color3.fromRGB(120, 200, 120)
            TweenService:Create(Knob, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -24, 0.5, -11)}):Play()
        else
            TweenService:Create(Track, TweenInfo.new(0.25), {BackgroundColor3 = colorToggleOff}):Play()
            TrackStroke.Color = Color3.fromRGB(200, 200, 200)
            TweenService:Create(Knob, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 2, 0.5, -11)}):Play()
        end
        if callback then callback(state) end
    end)
    
    -- Sombra 3D interna del Switch
    local KnobShadow = Instance.new("Frame")
    KnobShadow.Size = UDim2.new(1, 0, 1, 2)
    KnobShadow.Position = UDim2.new(0, 0, 0, 0)
    KnobShadow.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    KnobShadow.ZIndex = Track.ZIndex - 1
    KnobShadow.Parent = Knob
    
    local KS_Corner = Instance.new("UICorner")
    KS_Corner.CornerRadius = UDim.new(1, 0)
    KS_Corner.Parent = KnobShadow
end

local function createSlider(page, titleText, minVal, maxVal, defaultVal, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.9, 0, 0, 55)
    Frame.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    Frame.Parent = page
    
    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Color3.fromRGB(230, 230, 230)
    FrameStroke.Thickness = 2
    FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    FrameStroke.Parent = Frame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -30, 0, 20)
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = titleText .. " : " .. tostring(defaultVal)
    Label.TextColor3 = colorTextDark
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local Track = Instance.new("TextButton")
    Track.Size = UDim2.new(1, -30, 0, 12)
    Track.Position = UDim2.new(0, 15, 0, 32)
    Track.BackgroundColor3 = colorToggleOff
    Track.Text = ""
    Track.AutoButtonColor = false
    Track.Parent = Frame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    local pct = (defaultVal - minVal) / (maxVal - minVal)
    Fill.Size = UDim2.new(pct, 0, 1, 0)
    Fill.BackgroundColor3 = colorToggleOn
    Fill.Parent = Track
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill
    
    local function updateSlider(input)
        local relativeX = math.clamp(input.Position.X - Track.AbsolutePosition.X, 0, Track.AbsoluteSize.X)
        local percentage = relativeX / Track.AbsoluteSize.X
        Fill.Size = UDim2.new(percentage, 0, 1, 0)
        local val = math.floor(minVal + ((maxVal - minVal) * percentage))
        Label.Text = titleText .. " : " .. tostring(val)
        if callback then callback(val) end
    end
    
    local dragging = false
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
end

-- ==========================================
-- ESTRUCTURA DEL CONTENIDO
-- ==========================================

-- Pestaña: Adopt Me
createToggleSwitch(PageAdoptMe, "🍬 Farm Candy Egg", function(state)
    toggleCandy = state
end)

local toggleAutoCobrar = true
-- Auto Cobrar activado por defecto (como el Anti-AFK)

local ProxLabelAM = Instance.new("TextLabel")
ProxLabelAM.Size = UDim2.new(0.9, 0, 0, 30)
ProxLabelAM.BackgroundTransparency = 1
ProxLabelAM.Text = "+ Minijuegos próximamente..."
ProxLabelAM.TextColor3 = Color3.fromRGB(160, 160, 160)
ProxLabelAM.Font = Enum.Font.Gotham
ProxLabelAM.TextSize = 11
ProxLabelAM.TextYAlignment = Enum.TextYAlignment.Center
ProxLabelAM.Parent = PageAdoptMe

-- Pestaña: Player
local toggleNoclip = false
local toggleFly = false
local toggleFreecam = false

createToggleSwitch(PagePlayer, "👻 No Clip", function(state)
    toggleNoclip = state
end)

createToggleSwitch(PagePlayer, "🕊️ Fly", function(state)
    toggleFly = state
end)

-- Global settings for Free Cam
local TargetCFrame = CFrame.new()

createToggleSwitch(PagePlayer, "🎥 Free Cam", function(state)
    toggleFreecam = state
    local cam = workspace.CurrentCamera
    if not state then
        cam.CameraType = Enum.CameraType.Custom
        local char = Players.LocalPlayer.Character
        if char then cam.CameraSubject = char:FindFirstChild("Humanoid") end
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    else
        cam.CameraType = Enum.CameraType.Scriptable
        TargetCFrame = cam.CFrame
    end
end)

local toggleESP = false
createToggleSwitch(PagePlayer, "👁️ ESP (Jugadores)", function(state)
    toggleESP = state
    if not state then
        -- Limpiar
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "ESP_Highlight_NM" or v.Name == "ESP_Billboard_NM" then
                v.Enabled = false
            end
        end
    end
end)

local hitboxSize = 2
createSlider(PagePlayer, "📦 Hitbox Size", 2, 50, 2, function(val)
    hitboxSize = val
    if val <= 2 then
        -- Restaurar
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
            end
        end
    end
end)

createSlider(PagePlayer, "⚡ Velocidad", 16, 200, 16, function(val)
    local char = lp.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = val
    end
end)

createSlider(PagePlayer, "⬆️ Salto (JumpPower)", 50, 500, 50, function(val)
    local char = lp.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.UseJumpPower = true
        char.Humanoid.JumpPower = val
    end
end)

-- Pestaña: Info (Creditos y estado)
local InfoCard = Instance.new("Frame")
InfoCard.Size = UDim2.new(0.9, 0, 0, 100)
InfoCard.BackgroundColor3 = colorWhite
InfoCard.Parent = PageInfo

local IC_Corner = Instance.new("UICorner")
IC_Corner.CornerRadius = UDim.new(0, 12)
IC_Corner.Parent = InfoCard

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Color3.fromRGB(230, 230, 230)
CardStroke.Thickness = 2
CardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CardStroke.Parent = InfoCard

local CardDepth = Instance.new("Frame")
CardDepth.Size = UDim2.new(1, 0, 1, 3)
CardDepth.Position = UDim2.new(0, 0, 0, 0)
CardDepth.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
CardDepth.ZIndex = 0
CardDepth.Parent = InfoCard

local CD_Cor = Instance.new("UICorner")
CD_Cor.CornerRadius = UDim.new(0, 12)
CD_Cor.Parent = CardDepth

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -20, 1, -20)
InfoText.Position = UDim2.new(0, 10, 0, 10)
InfoText.BackgroundTransparency = 1
InfoText.Text = "Creador: @nmaster\n\n🛡️ Anti-AFK Bypassed\n\nVersión: 3.5 (UI Pro 3D)"
InfoText.TextColor3 = colorTextDark
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 13
InfoText.TextXAlignment = Enum.TextXAlignment.Center
InfoText.TextYAlignment = Enum.TextYAlignment.Center
InfoText.Parent = InfoCard

-- ==========================================
-- MARCAS DE AGUA (Watermarks "Cute")
-- ==========================================
local WatermarkContainer = Instance.new("Frame")
WatermarkContainer.Size = UDim2.new(1, 0, 1, 0)
WatermarkContainer.BackgroundTransparency = 1
WatermarkContainer.ZIndex = -10
WatermarkContainer.Parent = Pages -- Detrás de absolutamente todo el contenido de las páginas

local function createBubblesWatermark()
    local c = Instance.new("CanvasGroup")
    c.Name = "AdoptMeUI"
    c.Size = UDim2.new(0, 100, 0, 100)
    c.Position = UDim2.new(1, -100, 1, -100)
    c.BackgroundTransparency = 1
    c.GroupTransparency = 0.65
    c.ZIndex = -10
    c.Visible = true
    c.Parent = WatermarkContainer
    
    local color = Color3.fromRGB(150, 220, 255)
    
    local b1 = Instance.new("Frame")
    b1.Size = UDim2.new(0, 50, 0, 50)
    b1.Position = UDim2.new(1, -50, 1, -50)
    b1.BackgroundColor3 = color
    b1.BorderSizePixel = 0
    b1.Parent = c
    Instance.new("UICorner", b1).CornerRadius = UDim.new(1,0)
    
    local b2 = Instance.new("Frame")
    b2.Size = UDim2.new(0, 30, 0, 30)
    b2.Position = UDim2.new(1, -25, 0, 15)
    b2.BackgroundColor3 = color
    b2.BorderSizePixel = 0
    b2.Parent = c
    Instance.new("UICorner", b2).CornerRadius = UDim.new(1,0)
    
    local b3 = Instance.new("Frame")
    b3.Size = UDim2.new(0, 20, 0, 20)
    b3.Position = UDim2.new(0, 15, 1, -20)
    b3.BackgroundColor3 = color
    b3.BorderSizePixel = 0
    b3.Parent = c
    Instance.new("UICorner", b3).CornerRadius = UDim.new(1,0)
end

createBubblesWatermark()

-- Trigger para cambiar de marca de agua
TabAdoptMe.MouseButton1Click:Connect(function()
    WatermarkContainer.AdoptMeUI.Visible = true
end)
TabPlayer.MouseButton1Click:Connect(function()
    WatermarkContainer.AdoptMeUI.Visible = false
end)
TabInfo.MouseButton1Click:Connect(function()
    WatermarkContainer.AdoptMeUI.Visible = false
end)

-- ==========================================
-- Sistema de Arrastre (Drag)
-- Solo se puede arrastrar desde el Header (típico de PC/Móvil)
-- ==========================================
local dragging, dragInput, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Container.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- FUNCIONALIDAD DEL SCRIPT Y FARMEOS
-- ==========================================
local function safeTeleport(hrp, targetCFrame)
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    
    hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
    task.wait(0.05)
    
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    hrp.CFrame = targetCFrame
end

task.spawn(function()
    while task.wait(0.1) do
        if toggleCandy then
            local char = lp.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if hrp then
                local children = workspace:GetChildren()
                local foundEgg = false
                
                for i = 1, #children do
                    if not toggleCandy then break end
                    local v = children[i]
                    if v.Name == "CandyEgg" then
                        local target = nil
                        if v:IsA("Model") then
                            target = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
                        elseif v:IsA("BasePart") then
                            target = v
                        end
                        
                        if target then
                            foundEgg = true
                            safeTeleport(hrp, target.CFrame)
                            task.wait(0.4) 
                        end
                    end
                end
                
                if toggleCandy and not foundEgg then
                    safeTeleport(hrp, CFrame.new(-308, 26, -1600))
                    task.wait(1)
                end
            end
        end
    end
end)


-- ==========================================
-- LÓGICA DE PLAYER Y EVENTOS GLOBALES
-- ==========================================
local RunService = game:GetService("RunService")

-- 1. Auto Cobrar Banco (Botón en UI)
task.spawn(function()
    while task.wait(1) do
        if toggleAutoCobrar then
            local pGui = lp:FindFirstChild("PlayerGui")
            if pGui then
                for _, ui in ipairs(pGui:GetDescendants()) do
                    if ui:IsA("TextButton") and ui.Visible and string.match(string.lower(ui.Text), "cobrar") then
                        local cx = getconnections and getconnections(ui.MouseButton1Click)
                        if cx and cx[1] then
                            cx[1]:Fire()
                        else
                            VirtualUser:ClickButton1(Vector2.new(ui.AbsolutePosition.X + 10, ui.AbsolutePosition.Y + 10))
                        end
                        task.wait(2)
                    end
                end
            end
        end
    end
end)

-- 2. Noclip
RunService.Stepped:Connect(function()
    if toggleNoclip then
        local char = lp.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
    end
end)

-- 3. Fly & Freecam
local flyBV, flyBG
local cam = workspace.CurrentCamera

RunService.RenderStepped:Connect(function()
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    -- Fly Logica
    if toggleFly and hrp and hum then
        if not flyBV then
            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            flyBV.Parent = hrp
            flyBG = Instance.new("BodyGyro")
            flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            flyBG.CFrame = hrp.CFrame
            flyBG.Parent = hrp
        end
        hum.PlatformStand = true
        local camCFrame = cam.CFrame
        local moveVec = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + camCFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - camCFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + camCFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - camCFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVec = moveVec - Vector3.new(0, 1, 0) end
        
        flyBG.CFrame = camCFrame
        flyBV.Velocity = moveVec * 60
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
        if hum and not toggleFreecam then hum.PlatformStand = false end
    end
    
    -- Freecam Basica Logica
    if toggleFreecam then
        local lookVector = TargetCFrame.LookVector
        local rightVector = TargetCFrame.RightVector
        
        local moveVec = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + lookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - lookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + rightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - rightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) or UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) or UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveVec = moveVec - Vector3.new(0, 1, 0) end
        
        if moveVec.Magnitude > 0 then
            TargetCFrame = TargetCFrame + (moveVec.Unit * 3)
        end
        cam.CFrame = cam.CFrame:Lerp(TargetCFrame, 0.3)
    end
end)

-- Freecam Mouse Look Fix
local rightDown = false
UserInputService.InputBegan:Connect(function(input, gpe)
    if toggleFreecam and input.UserInputType == Enum.UserInputType.MouseButton2 then
        rightDown = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if toggleFreecam and input.UserInputType == Enum.UserInputType.MouseButton2 then
        rightDown = false
        if toggleFreecam then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
    end
end)

UserInputService.InputChanged:Connect(function(input, gpe)
    if toggleFreecam and rightDown and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Delta
        local x, y, z = TargetCFrame:ToOrientation()
        local newPitch = math.clamp(math.deg(x) - delta.Y * 0.4, -85, 85)
        local newYaw = math.deg(y) - delta.X * 0.4
        
        TargetCFrame = CFrame.new(TargetCFrame.Position) * CFrame.Angles(0, math.rad(newYaw), 0) * CFrame.Angles(math.rad(newPitch), 0, 0)
    end
end)

-- 4. ESP (Jugadores) Info
task.spawn(function()
    while task.wait(1) do
        if toggleESP then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local char = player.Character
                    
                    -- Highlight Body
                    local hl = char:FindFirstChild("ESP_Highlight_NM")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "ESP_Highlight_NM"
                        hl.FillColor = Color3.fromRGB(255, 100, 100)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.5
                        hl.Parent = char
                    end
                    hl.Enabled = true
                    
                    -- Text BillBoard
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local bb = hrp:FindFirstChild("ESP_Billboard_NM")
                    if not bb then
                        bb = Instance.new("BillboardGui")
                        bb.Name = "ESP_Billboard_NM"
                        bb.Size = UDim2.new(0, 200, 0, 50)
                        bb.StudsOffset = Vector3.new(0, 3.5, 0)
                        bb.AlwaysOnTop = true
                        
                        local txt = Instance.new("TextLabel")
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.TextSize = 13
                        txt.Font = Enum.Font.GothamBold
                        txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                        txt.Parent = bb
                        
                        local stk = Instance.new("UIStroke")
                        stk.Thickness = 1.5
                        stk.Parent = txt
                        
                        bb.Parent = hrp
                    end
                    bb.Enabled = true
                    
                    if bb:FindFirstChild("TextLabel") then
                        -- Nota: Roblox no dice siempre el 'dispositivo', simulamos uno genérico.
                        bb.TextLabel.Text = "[" .. player.Name .. "]\n(Jugador Móvil/PC)"
                    end
                end
            end
        end
    end
end)

-- 5. Hitboxes (Agrandar Slider)
task.spawn(function()
    while task.wait(0.5) do
        if hitboxSize > 2 then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    hrp.Transparency = 0.5
                    hrp.Color = Color3.fromRGB(0, 200, 255)
                    hrp.Material = Enum.Material.Neon
                    hrp.CanCollide = false
                end
            end
        end
    end
end)
