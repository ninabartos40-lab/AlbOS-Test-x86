# AlbOS Test x86

**Acum există un flux real de pornire într-un VM**, nu doar interfața HTML. Pe Windows, scriptul de configurare descarcă ISO-ul oficial Android-x86 9.0-r2, creează un VM VirtualBox numit `AlbOS Test` și îl pornește.

## Pornire pe Windows

1. Instalează [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads) și asigură-te că virtualizarea hardware (Intel VT-x/AMD-V) este activată.
2. Descarcă ZIP-ul acestui repository și extrage-l într-un folder cu suficient spațiu liber (cel puțin 2 GB pentru ISO și 25 GB pentru discul virtual).
3. Dublu-click pe `setup-albos-test.bat`.
4. Așteaptă descărcarea ISO-ului. Scriptul creează un VM cu 4 GB RAM, 2 procesoare virtuale și un disc virtual de 24 GB, apoi îl pornește.
5. În meniul Android-x86, alege **Live CD - Run Android-x86 without installation** pentru a-l testa. Pentru instalare în discul virtual, alege opțiunea de instalare Android-x86 din meniul de boot și urmează programul de instalare.

La prima pornire este necesară conexiune la internet pentru descărcarea ISO-ului de la proiectul Android-x86. ISO-ul este mare. Verifică sursa și licențele componentelor upstream.

## Ce este și ce nu este

- Acesta pornește un **sistem Android-x86 real, bootabil, într-un VM VirtualBox**.
- VM-ul se numește `AlbOS Test`, dar sistemul de bază este Android-x86 9.0-r2. **Nu este încă un build Android personalizat AlbOS**; nu pretindem că am creat un ROM nou.
- `index.html` rămâne doar o machetă de interfață, nu sistemul de operare.
- Scriptul nu modifică Windows și nu instalează sistemul pe discul fizic. Instalarea selectată în meniul Android-x86 este către discul virtual al VM-ului.

## Fișiere

- `setup-albos-test.bat` — pornitor Windows pentru configurare.
- `setup-albos-test.ps1` — descarcă ISO-ul upstream, creează VM-ul și îl pornește.
- `index.html` — machetă de interfață web, opțională.

ISO-ul și discul virtual sunt descărcate/generate local și excluse din Git; repository-ul nu conține fișierele binare mari.

## Probleme obișnuite

- **VirtualBox nu este găsit:** instalează VirtualBox și rulează din nou scriptul.
- **Virtualizare dezactivată:** activează Intel VT-x/AMD-V în BIOS/UEFI și verifică setările Windows/Hyper-V.
- **VM-ul există deja:** șterge VM-ul `AlbOS Test` din VirtualBox (inclusiv fișierele VM, dacă nu mai ai nevoie de ele) înainte de a rula scriptul din nou.
- Pentru a relua doar ISO-ul, șterge `android-x86_64-9.0-r2.iso` și pornește scriptul din nou.

## Sursă

- Pagina oficială de descărcare Android-x86: https://www.android-x86.org/download
- ISO utilizat de script: Android-x86 9.0-r2, găzduit pe SourceForge: https://sourceforge.net/projects/android-x86/files/Release%209.0/android-x86_64-9.0-r2.iso/download

Acesta este un prototip experimental. Compatibilitatea grafică, audio și de rețea depinde de PC și de VirtualBox.
