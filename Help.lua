local Help = {}
local H = Help

--Services
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
-- if you're using it for a script that can run a executor that's no problem

function Help:CreateShake(parent)
  if not parent then return end
  local button = parent
  local MAX_DISTANCE = 80 -- Distanza massima (in pixel) per attivare l'oscillazione
  local MAX_ROTATION = 15 -- Gradi massimi di rotazione dell'oscillazione

  local targetRotation = 0
  local currentRotation = 0
  local speed = 15 -- Velocità di ritorno elastico

  RunService.RenderStepped:Connect(function(dt)
	  local mousePos = UIS:GetMouseLocation()

	  -- Calcola il centro dell'ImageButton sullo schermo
	  local buttonCenter = button.AbsolutePosition + (button.AbsoluteSize / 2)

	  -- Calcola la distanza tra il mouse e il centro del pulsante
	  local distanceVector = mousePos - buttonCenter
	  local distance = distanceVector.Magnitude

	  if distance < MAX_DISTANCE then
		  -- Più il mouse è vicino, più l'effetto è forte
		  local intensity = 1 - (distance / MAX_DISTANCE)

		  -- Oscilla in base al movimento del mouse e al tempo
		  targetRotation = math.sin(tick() * 10) * (MAX_ROTATION * intensity)
	  else
		  -- Se il mouse è lontano, torna dritto
		  targetRotation = 0
	  end

	  -- Effetto elastico / Interpolazione fluida
	  currentRotation = currentRotation + (targetRotation - currentRotation) * (speed * dt)
	  button.Rotation = currentRotation
  end)
end

function Help:CreateClickEffect(parent, iconId, nicon)
  if not parent then return end
  if not iconId then return end

local pulsante = parent
local TweenService = game:GetService("TweenService")
local rng = Random.new()

-- IMPOSTAZIONI PERSONALIZZABILI
local ID_ICONA = iconId -- Sostituisci con il tuo ID Asset
local NUMERO_ICONE = nicon                    -- Quante icone generare a ogni click
local DIMENSIONE_ICONA = UDim2.new(0, 45, 0, 45) -- Dimensione finale dell'icona
local TEMPO_ANIMAZIONE_APRI = 0.7          -- Durata dello spargimento iniziale
local TEMPO_ANIMAZIONE_CHIUDI = 0.7        -- Durata della dissolvenza finale
local DoingEffect = false

-- 🛠️ IMPOSTAZIONI DEL RAGGIO (IN PIXEL)
local RAGGIO_MINIMO = 95                   -- Distanza minima dal pulsante
local RAGGIO_MASSIMO = 95                 -- Distanza massima dal pulsante
-- NOTA: Se vuoi che vadano tutte alla STESSA identica distanza, 
-- imposta sia RAGGIO_MINIMO che RAGGIO_MASSIMO allo stesso numero (es. 120 e 120).

pulsante.MouseButton1Click:Connect(function()
	if DoingEffect == true then return end
	DoingEffect = true
	-- Calcola il centro attuale del pulsante sullo schermo
	local centroX = pulsante.AbsolutePosition.X + (pulsante.AbsoluteSize.X / 2)
	local centroY = pulsante.AbsolutePosition.Y + (pulsante.AbsoluteSize.Y / 2)
	local posizioneCentro = UDim2.new(0, centroX, 0, centroY)

	local gruppoIcone = {}

	-- Genera le icone
	for i = 1, NUMERO_ICONE do
		-- Sceglie un angolo casuale a 360 gradi
		local angoloCasuale = rng:NextNumber(0, 2 * math.pi)

		-- 🎯 Calcola il raggio casuale compreso tra il minimo e il massimo che hai scelto
		local raggioCasuale = rng:NextNumber(RAGGIO_MINIMO, RAGGIO_MASSIMO) 

		local offsetX = math.cos(angoloCasuale) * raggioCasuale
		local offsetY = math.sin(angoloCasuale) * raggioCasuale
		local posizioneFinale = UDim2.new(0, centroX + offsetX, 0, centroY + offsetY)

		-- Crea l'icona
		local icona = Instance.new("ImageLabel")
		icona.Name = "IconaRaggio_" .. tick() .. "_" .. i
		icona.AnchorPoint = Vector2.new(0.5, 0.5)
		icona.Size = UDim2.new(0, 0, 0, 0)
		icona.Position = posizioneCentro
		icona.Image = ID_ICONA
		icona.BackgroundTransparency = 1
		icona.ImageTransparency = 0
		icona.ZIndex = pulsante.ZIndex + 1
		icona.Parent = pulsante.Parent

		table.insert(gruppoIcone, icona)

		-- Avvia l'animazione di spargimento nel raggio deciso
		local infoApri = TweenInfo.new(TEMPO_ANIMAZIONE_APRI, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		local apriTween = TweenService:Create(icona, infoApri, {
			Position = posizioneFinale,
			Size = DIMENSIONE_ICONA
		})
		apriTween:Play()
		local infoChiudi = TweenInfo.new(TEMPO_ANIMAZIONE_CHIUDI, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local chiudiTween = TweenService:Create(icona, infoChiudi, {
			ImageTransparency = 1,
		})
		chiudiTween:Play()
		task.delay(TEMPO_ANIMAZIONE_CHIUDI, function()
			icona:Destroy()
			DoingEffect = false
		end)
	end
end)
end

function Help:CreateCoolImgBtn(parent, imgId, iconId, nicon, txt)
	if not parent then return end
	if not imgId then return end
	if not iconId then return end
	if not txt then txt = "Label" end
	local ImgBtn = Instance.new("ImageButton")
	ImgBtn.ScaleType = Enum.ScaleType.Tile
	ImgBtn.BackgroundColor3 = Color3.fromRGB(94, 167, 255)
	ImgBtn.Image = imgId
	ImgBtn.TileSize = UDim2.new(0, 100, 0, 100)
	ImgBtn.Size = UDim2.new(0, 98, 0, 107)
	ImgBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImgBtn.Parent = parent

	local SquareBtn = Instance.new("UIAspectRatioConstraint")
	SquareBtn.Parent = ImgBtn

	local GradientBtn = Instance.new("UIGradient")
	GradientBtn.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 171, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 171, 255))}
	GradientBtn.Parent = ImgBtn

	local StrokeBtn = Instance.new("UIStroke")
	StrokeBtn.Thickness = 5
	StrokeBtn.Parent = ImgBtn

	local Label = Instance.new("TextLabel")
	Label.TextWrapped = true
	Label.TextSize = 33
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.FontFace = Font.new([[rbxasset://fonts/families/PressStart2P.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.BackgroundTransparency = 1
	Label.Size = UDim2.new(1, 0, 1, 0)
	Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Label.Parent = ImgBtn

	local SquareLbl = Instance.new("UIAspectRatioConstraint")
	SquareLbl.Parent = Label

	local StrokeLbl = Instance.new("UIStroke")
	StrokeLbl.Thickness = 2
	StrokeLbl.Parent = Label

	H:CreateShake(ImgBtn)
	H:CreateClickEffect(ImgBtn, iconId, nicon)
end

-- contiue tomorrow
return Help
