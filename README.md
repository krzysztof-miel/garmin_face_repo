# FR970 Minimal — tarcza Garmin Connect IQ

Monochromatyczna tarcza dla Garmin Forerunner 970, odtworzona na podstawie
referencyjnego projektu. Interfejs jest rysowany w Monkey C i skaluje się
względem średnicy ekranu.

## Wygląd

- czarne tło i neutralne szarości;
- duża centralna godzina `HH:MM`;
- kroki, bateria i temperatura w górnym łuku;
- tętno i Body Battery w dolnych okręgach;
- polska data w kapsule;
- cienkie pierścienie, łuki, linie i kropki;
- uproszczony ekran always-on.

Ikony są rysowane prymitywami Monkey C w `source/Icons.mc`. Projekt nie
potrzebuje zewnętrznych bitmap ikon.

## Struktura

```text
manifest.xml
monkey.jungle
resources/
  drawables/       ikona programu
  fonts/           miejsce na opcjonalny font bitmapowy
  strings/         nazwa aplikacji
resources-pol/
  strings/
source/
  WatchFaceApp.mc  punkt wejścia aplikacji
  WatchFaceView.mc cykl życia i składanie widoku
  DataProvider.mc  bezpieczny dostęp do danych Garmin
  Layout.mc        znormalizowane pozycje i rozmiary
  Complications.mc układ komplikacji
  Decorations.mc  pierścienie, łuki i linie
  Drawing.mc       wspólne funkcje rysujące
  Icons.mc         skalowane ikony
  Theme.mc         paleta monochromatyczna
```

## Dane

| Pole | Źródło | Zachowanie bez danych |
|---|---|---|
| Czas | `System.getClockTime()` | `--:--` |
| Data | `Time.Gregorian` | `--` |
| Kroki | `ActivityMonitor.getInfo().steps` | `--` |
| Bateria | `System.getSystemStats().battery` | `--` i pusty łuk |
| Temperatura | `Weather.getCurrentConditions().temperature` | `--°C` |
| Tętno | `Activity.getActivityInfo().currentHeartRate` | `--` |
| Body Battery | `SensorHistory.getBodyBatteryHistory()` | `--` |

Temperatura wymaga aktualnych danych pogodowych dostarczonych zegarkowi przez
Garmin Connect. Tętno zależy od dostępności bieżącego odczytu sensora. Body
Battery korzysta z najnowszej próbki historii i wymaga uprawnienia
`SensorHistory`, które znajduje się w manifeście.

Wszystkie gettery obsługują `null` oraz wyjątki w `source/DataProvider.mc`.

## Uruchomienie w Visual Studio Code

1. Zainstaluj Garmin Connect IQ SDK Manager i rozszerzenie Monkey C.
2. W SDK Manager pobierz profil Forerunner 970.
3. Otwórz ten katalog w Visual Studio Code.
4. Wybierz polecenie `Monkey C: Set Products by Product Category` lub
   `Monkey C: Edit Products` i upewnij się, że aktywny jest `fr970`.
5. Wygeneruj klucz poleceniem `Monkey C: Generate a Developer Key`, jeśli
   jeszcze go nie masz.
6. Uruchom `Monkey C: Run Project` i wybierz Forerunner 970.

## Kompilacja z terminala

PowerShell:

```powershell
$sdk = (Get-Content "$env:APPDATA\Garmin\ConnectIQ\current-sdk.cfg").Trim()
& "$sdk\bin\monkeyc.bat" `
  -f .\monkey.jungle `
  -d fr970 `
  -o .\bin\FR970Minimal.prg `
  -y C:\sciezka\do\developer_key.der `
  -w
```

Uruchom najpierw Connect IQ Simulator, a następnie:

```powershell
& "$sdk\bin\monkeydo.bat" .\bin\FR970Minimal.prg fr970
```

## Always-on

Po `onEnterSleep()` tarcza rysuje tylko czas, datę i baterię. Nie odpytuje
wtedy kroków, pogody, tętna ani historii Body Battery. Pełny widok wraca po
`onExitSleep()`.

## Dalsze dopasowanie

Współrzędne odpowiadają referencji i są zebrane w `source/Layout.mc`.
Opcjonalny własny font można dodać zgodnie z
`resources/fonts/README.md`, bez zmiany pozostałej geometrii.
