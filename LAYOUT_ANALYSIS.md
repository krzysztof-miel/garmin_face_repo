# Analiza layoutu tarczy

## Założenia układu

Główną referencją geometrii jest `source/call_k2mi9uN6xX44nNI4RGH3QSSL.png`.
Drugi obraz służy do określenia położenia wartości i hierarchii typografii.
Oba obrazy mają rozmiar 1254 × 1254 px.

Współrzędne projektu są opisane względem środka ekranu:

```text
D  = min(dc.getWidth(), dc.getHeight())
CX = dc.getWidth() / 2
CY = dc.getHeight() / 2
x  = CX + nx * D
y  = CY + ny * D
r  = nr * D
```

Takie podejście zachowuje proporcje również wtedy, gdy obszar rysowania nie jest
idealnym kwadratem. Wszystkie wartości `nx`, `ny` i `nr` poniżej są
znormalizowane względem średnicy `D`.

## Główne punkty i obszary

| Element | `nx` | `ny` | Rozmiar / promień | Dla 454 × 454 |
|---|---:|---:|---:|---:|
| Środek ekranu | 0.000 | 0.000 | — | (227, 227) |
| Główny czas | 0.000 | 0.010 | pole ok. 0.68D × 0.23D | środek (227, 232) |
| Kroki — okrąg | -0.204 | -0.249 | r = 0.086D | (134, 114), r 39 |
| Bateria — środek | 0.000 | -0.278 | r = 0.091D | (227, 101), r 41 |
| Temperatura — okrąg | 0.203 | -0.249 | r = 0.086D | (319, 114), r 39 |
| Tętno — okrąg | -0.139 | 0.242 | r = 0.086D | (164, 337), r 39 |
| Body Battery — okrąg | 0.127 | 0.242 | r = 0.086D | (285, 337), r 39 |
| Kapsuła daty | 0.000 | 0.377 | 0.183D × 0.056D | środek (227, 398), 83 × 25 |
| Napis GARMIN | 0.000 | 0.442 | pole ok. 0.18D × 0.035D | środek (227, 428) |

Niewielka asymetria dolnych okręgów występuje już w referencji. W implementacji
można ją zachować dla wierności albo ustawić oba na `nx = ±0.133`, jeżeli
ważniejsza będzie idealna symetria.

## Położenie zawartości komplikacji

Pozycje tekstu należy liczyć od środka odpowiadającego mu okręgu:

| Zawartość | Przesunięcie względem środka komplikacji |
|---|---:|
| Ikona kroków | `dy = -0.030D` |
| Wartość kroków | `dy = +0.043D` |
| Ikona baterii | `dy = -0.017D` |
| Wartość baterii | `dy = +0.057D` |
| Ikona temperatury | `dy = -0.028D` |
| Wartość temperatury | `dy = +0.043D` |
| Ikona tętna | `dy = -0.038D` |
| Wartość tętna | `dy = +0.003D` |
| Etykieta `bpm` | `dy = +0.040D` |
| Ikona Body Battery | `dy = -0.037D` |
| Wartość Body Battery | `dy = +0.017D` |

Teksty powinny być wyrównane centralnie (`Graphics.TEXT_JUSTIFY_CENTER`).
Godzina ma dominować: jej wizualna wysokość to około `0.22D`, a szerokość
powinna mieścić się w `0.68D`. Dwukropek jest wyraźnie mniejszy od cyfr.

## Dekoracje

### Pierścień zewnętrzny

- środek: `(CX, CY)`;
- promień: `0.497D`;
- linia: około `0.001D`, minimum 1 px;
- kolor: neutralny jasny szary.

### Górny łuk

- końce: `(-0.208D, -0.358D)` i `(0.208D, -0.358D)`;
- najwyższy punkt: około `(0, -0.427D)`;
- kropki końcowe: promień `0.0045D`;
- pionowy znacznik na godzinie 12: od `ny = -0.438` do `ny = -0.416`;
- łuk jest przerwany przy pionowym znaczniku.

W Monkey C najlepiej narysować go jako dwa odcinki łuku o wspólnym promieniu,
z małą przerwą na osi pionowej.

### Boczne łuki

- lewy: od `(-0.392D, -0.102D)` do `(-0.380D, 0.125D)`;
- prawy: lustrzane odbicie;
- promień konstrukcyjny: około `0.405D`;
- kropki na obu końcach: promień `0.0045D`;
- łuki mają delikatnie wypukły kształt zgodny z obwodem ekranu.

### Dolne linie

- oś Y: `ny = 0.374`;
- lewa: od `nx = -0.187` do `nx = -0.102`;
- prawa: od `nx = 0.100` do `nx = 0.183`;
- zewnętrzne końce zakończone kropką o promieniu `0.0045D`;
- między liniami znajduje się kapsuła daty.

## Kolorystyka

Rekomendowana neutralna paleta bez fioletowego zafarbu:

```text
tło                 #000000
tekst główny         #F2F2F2
tekst pomocniczy     #D4D4D4
obrysy               #B8B8B8
obrysy drugorzędne   #666666
nieaktywny pierścień #303030
```

Na ekranie AMOLED warto unikać dużych powierzchni czystej bieli. Czysta czerń
pozostaje tłem, a główne cyfry mogą używać `#F2F2F2`.

## Uwagi implementacyjne

- Referencje są wizualizacjami, nie zrzutami ekranu urządzenia, więc ich
  perspektywa i grubości linii nie są całkowicie spójne pikselowo.
- Pusta referencja obejmuje całą powierzchnię projektu; obraz z danymi zawiera
  dodatkowo bezel zegarka, dlatego jego pozycje tekstów należy przeliczać na
  wewnętrzny obszar tarczy, a nie kopiować bezpośrednio w pikselach.
- Ikony najlepiej narysować prostymi prymitywami lub dostarczyć jako
  jednokolorowe zasoby, aby zachować ostrość i łatwo zmieniać neutralny kolor.
- Napis `GARMIN` jest znakiem towarowym. Technicznie może być dekoracją, ale
  bezpiecznym wariantem publikacyjnym jest jego pominięcie lub zastąpienie
  własnym napisem.
