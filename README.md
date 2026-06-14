# Install-Apps.ps1 (PL)

Skrypt PowerShell instalujący zestaw popularnych aplikacji za pomocą [winget](https://learn.microsoft.com/pl-pl/windows/package-manager/winget/) (Windows Package Manager).

## Lista aplikacji

| Aplikacja | ID w winget |
|---|---|
| Discord | `Discord.Discord` |
| Zen Browser | `Zen-Team.Zen-Browser` |
| Steam | `Valve.Steam` |
| ShareX | `ShareX.ShareX` |
| PowerToys | `Microsoft.PowerToys` |
| Notepad++ | `Notepad++.Notepad++` |
| Windhawk | `RamenSoftware.Windhawk` |
| 7-Zip | `7zip.7zip` |
| CPU-Z | `CPUID.CPU-Z` |
| VS Code | `Microsoft.VisualStudioCode` |

## Wymagania

- Windows 10/11 z zainstalowanym **winget** (App Installer ze sklepu Microsoft Store)
- PowerShell 5.1 lub nowszy
- Połączenie z internetem

## Użycie

### 1. Pobierz skrypt

Zapisz plik `Install-Apps.ps1` w wybranym folderze, np. `C:\Users\<Nazwa>\Documents\winget-apps-install\`.

### 2. Uruchom PowerShell jako Administrator

Start → wpisz `PowerShell` → **Uruchom jako administrator**.

> Uprawnienia administratora są wymagane do instalacji większości aplikacji z listy.

### 3. Odblokuj wykonywanie skryptów (jednorazowo, na czas sesji)

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### 4. Przejdź do folderu ze skryptem i uruchom go

```powershell
cd C:\Users\<Nazwa>\Documents\winget-apps-install
.\Install-Apps.ps1
```

## Co robi skrypt

1. Sprawdza, czy winget jest dostępny w systemie.
2. Dla każdej aplikacji z listy uruchamia `winget install` w trybie cichym (`--silent`), automatycznie akceptując umowy licencyjne.
3. Wypisuje status każdej instalacji: `OK`, `JUZ ZAINSTALOWANA` lub `BLAD`.
4. Na końcu wyświetla tabelę podsumowującą z liczbą nowo zainstalowanych aplikacji, już obecnych i błędów.

## Statusy

| Status | Znaczenie |
|---|---|
| `OK` | Zainstalowano pomyślnie |
| `JUZ ZAINSTALOWANA` | Aplikacja była już na systemie, pominięto |
| `BLAD (kod)` | Instalacja nie powiodła się — sprawdź kod błędu w dokumentacji winget |

## Uwagi

- Identyfikatory pakietów (`Id`) mogą się zmieniać — jeśli któraś z instalacji zwraca błąd, zweryfikuj aktualne ID poleceniem:

  ```powershell
  winget search <nazwa-aplikacji>
  ```

- Aby dodać własną aplikację do listy, dopisz nowy wiersz w tablicy `$apps` na początku skryptu:

  ```powershell
  [PSCustomObject]@{ Name = "Nazwa aplikacji"; Id = "Wydawca.Aplikacja" }
  ```

## Licencja

Użyj i modyfikuj swobodnie na własne potrzeby.

---

# Install-Apps.ps1 (EN)

A PowerShell script that installs a set of common applications using [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/) (Windows Package Manager).

## App list

| Application | Winget ID |
|---|---|
| Discord | `Discord.Discord` |
| Zen Browser | `Zen-Team.Zen-Browser` |
| Steam | `Valve.Steam` |
| ShareX | `ShareX.ShareX` |
| PowerToys | `Microsoft.PowerToys` |
| Notepad++ | `Notepad++.Notepad++` |
| Windhawk | `RamenSoftware.Windhawk` |
| 7-Zip | `7zip.7zip` |
| CPU-Z | `CPUID.CPU-Z` |
| VS Code | `Microsoft.VisualStudioCode` |

## Requirements

- Windows 10/11 with **winget** installed (App Installer from the Microsoft Store)
- PowerShell 5.1 or newer
- Internet connection

## Usage

### 1. Download the script

Save `Install-Apps.ps1` to a folder of your choice, e.g. `C:\Users\<Name>\Documents\winget-apps-install\`.

### 2. Run PowerShell as Administrator

Start menu → type `PowerShell` → **Run as administrator**.

> Administrator privileges are required to install most apps on the list.

### 3. Allow script execution (one-time, for this session)

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### 4. Navigate to the script folder and run it

```powershell
cd C:\Users\<Name>\Documents\winget-apps-install
.\Install-Apps.ps1
```

## What the script does

1. Checks whether winget is available on the system.
2. For each app on the list, runs `winget install` in silent mode (`--silent`), automatically accepting license agreements.
3. Prints the status of each installation: `OK`, `ALREADY INSTALLED`, or `ERROR`.
4. At the end, displays a summary table with the number of newly installed apps, already-present apps, and errors.

## Statuses

| Status | Meaning |
|---|---|
| `OK` | Successfully installed |
| `JUZ ZAINSTALOWANA` | App was already installed, skipped |
| `BLAD (code)` | Installation failed — check the error code in winget's documentation |

> Note: status labels are printed in Polish in the script output (`OK`, `JUZ ZAINSTALOWANA`, `BLAD`). You can translate them in the source if you prefer English output.

## Notes

- Package IDs (`Id`) can change over time — if an installation returns an error, verify the current ID with:

  ```powershell
  winget search <app-name>
  ```

- To add your own app to the list, append a new entry to the `$apps` array at the top of the script:

  ```powershell
  [PSCustomObject]@{ Name = "App Name"; Id = "Publisher.App" }
  ```

## License

Use and modify freely for your own purposes.
