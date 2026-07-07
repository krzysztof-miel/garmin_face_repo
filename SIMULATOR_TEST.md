# Test tarczy — Forerunner 970

Profil: `fr970`, ekran 454 × 454 px, AMOLED.

## Wynik kompilacji i uruchomienia

- kompilacja SDK 9.2.0: poprawna;
- instalacja pliku `Face3FinalTest.prg` w symulatorze: poprawna;
- nowy wyjątek lub błąd w `CIQ_LOG.YML`: brak;
- testowany klucz deweloperski: RSA 4096.

## Kontrola geometrii 454 × 454

| Element | Środek / obszar | Wynik |
|---|---|---|
| Pierścień zewnętrzny | promień 226 px, margines ok. 1 px | mieści się |
| Kroki | (134, 114), r = 39 px | mieści się |
| Bateria | (227, 101), r = 41 px | mieści się |
| Temperatura | (319, 114), r = 39 px | mieści się |
| Czas | (227, 232), font ok. 123 px | wyśrodkowany |
| Tętno | (164, 337), r = 39 px | mieści się |
| Body Battery | (285, 337), r = 39 px | mieści się |
| Data | środek (227, 398), 83 × 25 px | mieści się |

Dolna krawędź kapsuły daty znajduje się około 42 px nad krawędzią ekranu.
Górne komplikacje kończą się około Y=153, a centralny czas zaczyna się
optycznie poniżej tej linii. Dolne komplikacje zaczynają się około Y=298.

## Always-on

Tryb low power rysuje wyłącznie:

- godzinę bez poświaty;
- datę;
- baterię;
- czarne tło.

Zapytania o kroki, pogodę, tętno i Body Battery nie są wykonywane w tym trybie.
Odświeżenie odbywa się raz na minutę przez standardowe `onUpdate()`.

## Ograniczenie testu

Proces symulatora uruchomiony z terminala nie udostępnił uchwytu okna GUI,
dlatego automatyczny zrzut ekranu nie był dostępny. Kontrola wizualnych granic
została wykonana na rzeczywistych wymiarach profilu FR970 i współrzędnych
używanych przez kod.
