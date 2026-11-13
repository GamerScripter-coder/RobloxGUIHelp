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

function Help:CreateBurst(parent)
local Img = Instance.new("ImageLabel")
Img.Name = "Burst"
Img.BackgroundTransparency = 1
Img.ZIndex = 0
Img.Image = "rbxassetid://84880292033466"
Img.Parent = parent

local uiElement = parent
local velocitaRotazione = 45

RunService.RenderStepped:Connect(function(deltaTime)
	uiElement.Rotation = uiElement.Rotation + (velocitaRotazione * deltaTime)
end)
end

function Help:CreateImageFall(parent, iconId)
	if not parent then return end
	if not iconId then return end
local parentUI = parent

local IMAGE_ID = iconId -- Sostituisci con il tuo ID immagine
local FREQUENZA_SPAWN = 0.3 -- Ogni quanti secondi spawna una cometa
local VELOCITA_CADUTA = 1.5 -- Quanto tempo (in secondi) ci mette a scendere
local DIMENSIONE_COMETA = UDim2.new(0, 40, 0, 40) -- Larghezza e altezza in pixel

local ultimoSpawn = 0

-- Funzione per creare una cometa
local function creaCometa()
	local cometa = Instance.new("ImageLabel")
	cometa.Image = IMAGE_ID
	cometa.Size = DIMENSIONE_COMETA
	cometa.BackgroundTransparency = 1
	cometa.AnchorPoint = Vector2.new(0.5, 0.5)

	-- Posizione iniziale X casuale (tra 0% e 100% del parent), in alto fuori dallo schermo (Y = -0.1)
	local coordinataXCasuale = math.random()
	cometa.Position = UDim2.new(coordinataXCasuale, 0, -0.1, 0)
	cometa.Parent = parentUI

	-- Configura il movimento verso il basso e la sparizione (Fade Out)
	local posizioneFinale = UDim2.new(coordinataXCasuale + 0.1, 0, 1.1, 0) -- Scende diagonale
	local infoTween = TweenInfo.new(VELOCITA_CADUTA, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

	local tweenMovimento = TweenService:Create(cometa, infoTween, {
		Position = posizioneFinale,
		ImageTransparency = 1 -- Scompare gradualmente
	})

	-- Avvia l'animazione e distrugge l'oggetto alla fine per non intasare la memoria
	tweenMovimento:Play()
	tweenMovimento.Completed:Connect(function()
		cometa:Destroy()
	end)
end

-- Ciclo di controllo temporale fluido
RunService.RenderStepped:Connect(function()
	local tempoAttuale = os.clock()
	if tempoAttuale - ultimoSpawn >= FREQUENZA_SPAWN then
		ultimoSpawn = tempoAttuale
		creaCometa()
	end
end)
end

function Help:CreateTextSmooth(label)
if not label then return end
local textLabel = label
textLabel.RichText = true

-- Configurazione dell'animazione
local TEMPO_PER_LETTERA = 0.35 -- Tempo (in secondi) di permanenza della luce su ogni carattere
local LARGHEZZA_SCIA = 1.5       -- Ampiezza della sfumatura luminosa
local PAUSA_INIZIALE = 0.4     -- Tempo extra (in secondi) in cui la luce si ferma sulla PRIMA lettera prima di muoversi

-- Colori di base (RGB)
local R_BASE, G_BASE, B_BASE = 198, 198, 198   -- Lettere spente (Grigio)
local R_LUCE, G_LUCE, B_LUCE = 255, 255, 255   -- Lettera illuminata (Bianco)

-- Prende il testo della TextLabel
local testoOriginale = textLabel.Text
local lunghezzaTesto = utf8.len(testoOriginale)
local tempoIniziale = os.clock()

local function aggiornaOndaSmooth()
	local tempoTrascorso = os.clock() - tempoIniziale

	-- La durata totale include il tempo per scorrere il testo + la pausa sulla prima lettera
	local durataMovimento = lunghezzaTesto * TEMPO_PER_LETTERA
	local durataTotaleCiclo = durataMovimento + PAUSA_INIZIALE

	-- Ricomincia istantaneamente da capo senza delay esterni
	local tempoCorrenteCiclo = tempoTrascorso % durataTotaleCiclo

	local posizioneLuce
	if tempoCorrenteCiclo < PAUSA_INIZIALE then
		-- Durante la pausa iniziale, la luce resta bloccata esattamente sulla prima lettera (indice 1)
		posizioneLuce = 1
	else
		-- Finita la pausa, la luce inizia a scorrere normalmente lungo il testo
		local tempoEffettivoMovimento = tempoCorrenteCiclo - PAUSA_INIZIALE
		posizioneLuce = (tempoEffettivoMovimento / TEMPO_PER_LETTERA) + 1
	end

	local testoFormattato = ""

	for i = 1, lunghezzaTesto do
		local offset = utf8.offset(testoOriginale, i)
		local prossimoOffset = utf8.offset(testoOriginale, i + 1)
		local carattere = string.sub(testoOriginale, offset, prossimoOffset and (prossimoOffset - 1) or #testoOriginale)

		if carattere == " " then
			testoFormattato = testoFormattato .. " "
		else
			-- Calcola la distanza tra la lettera corrente e il centro della luce
			local distanza = math.abs(i - posizioneLuce)

			-- Fattore di interpolazione (0.0 a 1.0)
			local fattoreLuce = math.clamp(1 - (distanza / LARGHEZZA_SCIA), 0, 1)

			-- Smoothstep per rendere la transizione morbida
			fattoreLuce = fattoreLuce * fattoreLuce * (3 - 2 * fattoreLuce)

			-- Sfuma linearmente i valori RGB
			local r = math.round(R_BASE + (R_LUCE - R_BASE) * fattoreLuce)
			local g = math.round(G_BASE + (G_LUCE - G_BASE) * fattoreLuce)
			local b = math.round(B_BASE + (B_LUCE - B_BASE) * fattoreLuce)

			-- Aggiunge il carattere formattato
			testoFormattato = testoFormattato .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, carattere)
		end
	end

	textLabel.Text = testoFormattato
end

RunService.RenderStepped:Connect(aggiornaOndaSmooth)
end

function Help:CreateBigEffect(parent)
	if not parent then return end

local ImageButton = script.Parent

-- Aggiungi un UIScale se non esiste già
local uiScale = ImageButton:FindFirstChildOfClass("UIScale")
if not uiScale then
	uiScale = Instance.new("UIScale")
	uiScale.Parent = ImageButton
end

-- Parametri dell'animazione (durata e stile)
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Dimensioni: 1 è la grandezza normale, 1.2 è il 20% più grande (puoi modificarlo)
local scaleNormal = {Scale = 1}
local scaleBig = {Scale = 1.05}

-- Quando il mouse entra sopra l'ImageButton
ImageButton.MouseEnter:Connect(function()
	TweenService:Create(uiScale, tweenInfo, scaleBig):Play()
end)

-- Quando il mouse esce dall'ImageButton
ImageButton.MouseLeave:Connect(function()
	TweenService:Create(uiScale, tweenInfo, scaleNormal):Play()
end)
end

function Help:CreateTurnEffect(parent)
	if not parent then return end
local Btn = parent

-- Configurazione del Tween (durata di 0.2 secondi, stile fluido)
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local originalRot = Btn.Rotation
local targetRot = -45

-- Creazione delle animazioni
local tweenEnter = TweenService:Create(Btn, tweenInfo, {Rotation = targetRot})
local tweenLeave = TweenService:Create(Btn, tweenInfo, {Rotation = originalRot})

-- Collegamento degli eventi
Btn.MouseEnter:Connect(function()
	tweenLeave:Cancel() -- Interrompe l'animazione di ritorno se attiva
	tweenEnter:Play()
end)

Btn.MouseLeave:Connect(function()
	tweenEnter:Cancel() -- Interrompe l'animazione di andata se attiva
	tweenLeave:Play()
end)
end

function Help:CreateUpEffect(parent)
if not parent then return end
-- LocalScript posizionato dentro l'ImageButton
local button = script.Parent

-- IMPOSTAZIONI: Modifica questi valori come desideri
local ALTEZZA_AGGIUNTIVA = 20 -- Di quanti pixel vuoi far alzare il pulsante
local VELOCITA_TWEEN = 0.15   -- La durata dell'animazione in secondi

-- Salva la posizione originale del pulsante
local posizioneOriginale = button.Position

-- Calcola la posizione sollevata (sottrae sull'asse Y per andare verso l'alto)
local posizioneSollevata = UDim2.new(
	posizioneOriginale.X.Scale,
	posizioneOriginale.X.Offset,
	posizioneOriginale.Y.Scale,
	posizioneOriginale.Y.Offset - ALTEZZA_AGGIUNTIVA
)

-- Servizio per gestire le animazioni fluide (Tween)
local infoAnimazione = TweenInfo.new(VELOCITA_TWEEN, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Funzione per muovere il pulsante
local function muoviPulsante(posizioneTarget)
	local tween = TweenService:Create(button, infoAnimazione, {Position = posizioneTarget})
	tween:Play()
end

-- Rileva quando il mouse entra nel pulsante (si alza)
button.MouseEnter:Connect(function()
	muoviPulsante(posizioneSollevata)
end)

-- Rileva quando il mouse esce dal pulsante (torna giù)
button.MouseLeave:Connect(function()
	muoviPulsante(posizioneOriginale)
end)
end

function Help:CreateShakeLoop(parent)
if not parent then return end
local uiElement = script.Parent -- L'elemento UI su cui è applicato lo script

-- Configurazione dell'animazione
local gradiOscillazione = 15 -- Gradi massimi di inclinazione a destra e sinistra
local durataFase = 0.2 -- Quanto ci mette a fare ogni singolo movimento (più basso = più veloce)

-- Creiamo le informazioni del Tween
local infoTween = TweenInfo.new(durataFase, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

-- Calcoliamo le rotazioni (le UI usano gradi singoli per la proprietà Rotation)
local rotazioneIniziale = uiElement.Rotation
local rotazioneDestra = rotazioneIniziale + gradiOscillazione
local rotazioneSinistra = rotazioneIniziale - gradiOscillazione

-- Definiamo i movimenti fluidi
local tweenDestra = TweenService:Create(uiElement, infoTween, {Rotation = rotazioneDestra})
local tweenSinistra = TweenService:Create(uiElement, infoTween, {Rotation = rotazioneSinistra})
local tweenRitorno = TweenService:Create(uiElement, infoTween, {Rotation = rotazioneIniziale})

local function Two2LeftRight()
	tweenDestra:Play()
	tweenDestra.Completed:Wait()

	-- Oscilla a sinistra
	tweenSinistra:Play()
	tweenSinistra.Completed:Wait()
	
	tweenDestra:Play()
	tweenDestra.Completed:Wait()

	-- Oscilla a sinistra
	tweenSinistra:Play()
	tweenSinistra.Completed:Wait()
end

-- Ciclo infinito (Loop) dell'effetto
while true do
	-- Oscilla a destra
	Two2LeftRight()

	-- Ritorna dritto alla rotazione iniziale
	tweenRitorno:Play()
	tweenRitorno.Completed:Wait()

	-- Piccola pausa opzionale prima di rifarlo (impostata a 0.5 secondi)
	task.wait(0.5) 
end
end

function Help:CreateClickMini(parent)
-- Riferimento al bottone (il Parent diretto dello script)
local bottone = parent

-- === IMPOSTAZIONI PERSONALIZZABILI ===
local FATTORE_SCALA = 0.9       -- Quanto si rimpiccioliscono (0.85 = 85% della grandezza originale)
local TEMPO_ATTESA = 0.12         -- Quanti secondi rimangono piccoli prima di tornare normali
local DURATA_ANIMAZIONE = 0.12   -- Velocità dell'effetto di rimpicciolimento/ingrandimento
-- =====================================

local infoAnimazione = TweenInfo.new(
	DURATA_ANIMAZIONE,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out
)

-- Funzione per creare facilmente i due tween (rimpicciolisci e ripristina) per un oggetto
local function creaTweenPerOggetto(oggetto)
	local dimOriginale = oggetto.Size
	local dimPiccola = UDim2.new(
		dimOriginale.X.Scale * FATTORE_SCALA,
		dimOriginale.X.Offset * FATTORE_SCALA,
		dimOriginale.Y.Scale * FATTORE_SCALA,
		dimOriginale.Y.Offset * FATTORE_SCALA
	)

	local tPiccolo = TweenService:Create(oggetto, infoAnimazione, {Size = dimPiccola})
	local tOriginale = TweenService:Create(oggetto, infoAnimazione, {Size = dimOriginale})

	return tPiccolo, tOriginale
end

-- Crea i tween per il bottone
local tweenBottonePiccolo, tweenBottoneOriginale = creaTweenPerOggetto(bottone)

-- Crea i tween anche per il Frame genitore, se esiste
local tweenFramePiccolo, tweenFrameOriginale = nil, nil
if bottone.Parent and bottone.Parent:IsA("Frame") then
	tweenFramePiccolo, tweenFrameOriginale = creaTweenPerOggetto(bottone.Parent)
end

local inAnimazione = false

bottone.MouseButton1Click:Connect(function()
	if inAnimazione then return end
	inAnimazione = true

	-- 1. Rimpicciolisce entrambi contemporaneamente
	tweenBottonePiccolo:Play()
	if tweenFramePiccolo then
		tweenFramePiccolo:Play()
	end
	tweenBottonePiccolo.Completed:Wait()

	-- 2. Aspetta il numero di secondi scelto
	task.wait(TEMPO_ATTESA)

	-- 3. Riporta entrambi alla grandezza originale contemporaneamente
	tweenBottoneOriginale:Play()
	if tweenFrameOriginale then
		tweenFrameOriginale:Play()
	end
	tweenBottoneOriginale.Completed:Wait()

	inAnimazione = false
end)
end

function Help:CreateWant(parent, CrTab, iconId, nicon)
	if not parent then return end
	if not Tab then return end

	if CrTab.Shake == true then
	H:CreateShake(parent)
	end
	if CrTab.ClickEffect == true then
	if not iconId then return end
	if not nicon then return end
	H:CreateClickEffect(parent, iconId, nicon)
	end
	if CrTab.Burst == true then
	H:CreateBurst(parent)
	end
	if CrTab.TextSmooth == true then
	if not parent:FindFirstChildOfClass("TextLabel") then return end
	local Label = parent:FindFirstChildOfClass("TextLabel")
	H:CreateTextSmooth(Label)
	end
	if CrTab.ImageFall == true then
	if not iconId then return end
	H:CreateImageFall(parent, iconId)
	end
	if CrTab.BigEffect == true then
	H:CreateBigEffect(parent)
	end
	if CrTab.UpEffect == true then
	H:CreateUpEffect(parent)
	end
end

function Help:CoolImgBtn(parent, imgId, iconId, nicon, txt, CrTab)
	if not parent then return end
	if not imgId then return end
	if not iconId then return end
	if not txt then txt = "Label" end
	CrTab = CrTab or {
		Shake = true,
		ClickEffect = true,
		Burst = true,
		TextSmooth = true,
		ImageFall = true,
		BigEffect = true,
		UpEffect = true,
		ClickMini = true
	}
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
	Label.FontFace = Font.new([[rbxasset://fonts/families/PressStart2P.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Label.TextColor3 = Color3.fromRGB(198, 198, 198)
	Label.BackgroundTransparency = 1
	Label.Size = UDim2.new(1, 0, 1, 0)
	Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Label.Text = txt
	Label.Parent = ImgBtn

	local SquareLbl = Instance.new("UIAspectRatioConstraint")
	SquareLbl.Parent = Label

	local StrokeLbl = Instance.new("UIStroke")
	StrokeLbl.Thickness = 2
	StrokeLbl.Parent = Label

	H:CreateWant(ImgBtn, CrTab, iconId, nicon)
end

function Help:CoolFrameImgBtn(parent, imgId, iconId, nicon, txt, CrTab, rt)
	if not parent then return end
	if not imgId then return end
	if not txt then return end
	CrTab = CrTab or {
		Shake = true,
		ClickEffect = true,
		Burst = true,
		TextSmooth = true,
		ImageFall = true,
		BigEffect = true,
		UpEffect = true,
		ClickMini = true
	}
	local SendTabFr = nil
	local SendTabBt = nil
	
	local Frame = Instance.new("Frame")
	Frame.BackgroundColor3 = Color3.fromRGB(52, 94, 142)
	Frame.Size = UDim2.new(0, 103, 0, 107)
	Frame.Position = UDim2.new(0.90092, 0, 0.02516, 0)
	Frame.Parent = parent

	local Gradient = Instance.new("UIGradient")
	Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(0, 171, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 171, 255))}
	Gradient.Parent = Frame

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 5
	Stroke.Parent = Frame

	if CrTab.Shake == true and CrTab.BigEffect == true and CrTab.UpEffect == true then
		SendTabFr = {
			Shake = true,
			BigEffect = true,
			UpEffect = true,
			ClickEffect = false,
			Burst = false,
			TextSmooth = false,
			ImageFall = false,
			ClickMini = false
		}
	else
		SendTabFr = {
			Shake = false,
			BigEffect = false,
			UpEffect = false,
			ClickEffect = false,
			Burst = false,
			TextSmooth = false,
			ImageFall = false,
			ClickMini = false
		}

		SendTabBt = {
			Shake = false,
			BigEffect = false,
			UpEffect = false,
			ClickEffect = CrTab.ClickEffect,
			Burst = CrTab.Burst,
			TextSmooth = CrTab.TextSmooth,
			ImageFall = CrTab.ImageFall,
			ClickMini = CrTab.ClickMini
		}
	end

	H:CreateWant(Frame, SendTabFr, nil, nil)

	H:CoolImgBtn(Frame, imgId, iconId, nicon, txt, SendTabBtn)

	if rt == true then
		return Frame
	end
end

function Help:CoolImgBtnWithImg(parent, imgId, iconId, nicon, txt, CrTab)
	if not parent then return end
	if not imgId then return end
	if not txt then txt = "Label" end
	CrTab = CrTab or {
		Shake = true,
		ClickEffect = true,
		Burst = true,
		TextSmooth = true,
		ImageFall = true,
		BigEffect = true,
		UpEffect = true,
		ClickMini = true
	}
	local frame = H:CoolFrameImgBtn(parent, imgId, iconId, nicon, txt, CrTab)
	if frame then
	local btn = frame:FindFirstChild("ImageButton")
	if btn then
		local ImgLabel = Instance.new("ImageLabel")
		ImgLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImgLabel.Image = "rbxassetid://103092378330251"
		ImgLabel.Size = UDim2.new(0.80612, 0, 0.85714, 0);
		ImgLabel.BackgroundTransparency = 1
		ImgLabel.Parent = btn
	end
	end
end
-- contiue tomorrow
return Help
