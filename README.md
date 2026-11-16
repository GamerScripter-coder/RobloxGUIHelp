# 🚀 RobloxGUIHelp & HelpStudio

Un toolkit avanzato per sviluppatori e scripter di Roblox, progettato per generare GUI di grande impatto visivo, animazioni fluide ed effetti particellari avanzati sia tramite **Plugin per Roblox Studio** sia tramite **Script per Executor**.

---

## 📥 Download del Plugin per Roblox Studio
Puoi scaricare l'ultima versione del plugin ufficiale direttamente dal link sottostante:
👉 **[Scarica RobloxGUIHelp Plugin da MEGA](https://mega.nz/file/xf4RzC5C#FH886XQvMw2LGmuFme-EEjFRn0KJ91nbPf6fX2Ozl14)**

---

## 📂 Contenuto del Repository

Questo repository contiene due script principali:

1. **`HelpStudio.lua`** (Modulo per Executor / Scripting)
   - Un modulo completo e leggero che gestisce una vasta gamma di effetti visivi, oscillazioni, particelle a scoppio, comete cadenti e animazioni di testo dinamiche.
   - Progettato per essere eseguito tramite executor o caricato dinamicamente via `loadstring`.

2. **Plugin per Roblox Studio** (Scaricabile dal link MEGA)
   - Un plugin integrato per Roblox Studio dotato di interfaccia grafica split-screen.
   - Include un **Code Viewer live a righe multiple** (senza limiti di altezza) che scarica e sincronizza automaticamente gli aggiornamenti del modulo direttamente da GitHub.
   - Permette di selezionare qualsiasi `ScreenGui` o `Frame` e generare istantaneamente i bottoni personalizzati con un solo click.

---

## ✨ Effetti e Funzioni Disponibili (`HelpStudio`)

Il modulo mette a disposizione una serie di funzioni pronte all'uso:

* **`CreateShake`**: Effetto di oscillazione dinamica del bottone basato sulla vicinanza del mouse.
* **`CreateClickEffect`**: Genera un'esplosione di icone particellari personalizzabili intorno al cursore/pulsante al click.
* **`CreateBurst`**: Sfondo rotante continuo con effetto visivo dinamico.
* **`CreateImageFall`**: Pioggia/caduta fluida di comete o icone dall'alto dello schermo.
* **`CreateTextSmooth`**: Effetto onda luminosa scorrevole e gradiente sui testi (`RichText`).
* **`CreateBigEffect` / `CreateUpEffect`**: Animazioni di ingrandimento e sollevamento al passaggio del mouse (`MouseEnter` / `MouseLeave`).
* **`CreateShakeLoop`**: Oscillazione continua automatica in loop.
* **`CreateClickMini`**: Effetto "squish" (rimpicciolimento rapido e ritorno alla dimensione originale) al click.
* **`CoolImgBtn` / `CoolFrameImgBtn` / `CoolImgBtnWithImg`**: Template completi di pulsanti stilosi dotati di bordi, gradienti, font retro personalizzati e pacchetti di effetti pre-configurati.

---

## 🛠️ Tutorial: Come Installare e Usare il Plugin in Roblox Studio

### 📍 Dove si deve mettere il plugin?
I file dei plugin in Roblox Studio (`.rbxmx` o `.lua`) devono essere inseriti nella cartella locale dei plugin di Roblox sul tuo computer, oppure installati tramite il pannello di gestione. 

**Metodo Consigliato (Cartella Plugins Locale):**
1. Scarica il file del plugin dal link MEGA.
2. Apri Roblox Studio.
3. Vai nella scheda **Plugins** in alto e clicca su **Plugins Folder** (Cartella dei Plugin). Questo aprirà la cartella ufficiale sul tuo PC (solitamente situata in `AppData\Local\Roblox\Plugins`).
4. Sposta o incolla il file del plugin scaricato all'interno di quella cartella.
5. Riavvia Roblox Studio: il plugin comparirà automaticamente nella barra degli strumenti!

### 🎮 Come si usa il plugin:
1. Apri il tuo progetto in **Roblox Studio**.
2. Clicca sul pulsante del plugin **"HelpStudio"** nella barra degli strumenti (Toolbar).
3. Si aprirà la finestra principale divisa in due colonne: a sinistra trovi i controlli e i pulsanti di creazione, a destra il **Code Viewer Live** sincronizzato con GitHub.
4. Seleziona una `ScreenGui` o un `Frame` nella finestra di Esplorazione (`Explorer`) del tuo gioco.
5. Inserisci gli ID delle immagini desiderate (`imgId` e `iconId`), il numero di particelle (`nicon`) e il testo del bottone (`txt`).
6. Clicca sui pulsanti di generazione (es. *Crea CoolImgBtn*) per creare istantaneamente la GUI stilizzata con tutti gli effetti applicati!
