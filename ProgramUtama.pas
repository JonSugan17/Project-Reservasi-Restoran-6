program SistemReservasiRestoran;
uses crt;

// Attribut dari meja yang dipesan 
type
    Tmeja = record
    nomor: integer;          // nomor meja
    tersedia: boolean;       // ketersediaan meja, jika tersedia maka nilainya true
    nama: string;            // nama pemesan meja
    email: string;           // email pemesan meja
    no_telepon: string;      // nomor telepon pemesan meja
    jumlah_tamu: integer;    // jumlah tamu pada meja tersebut
    catatan: string;         // catatan pemesan meja

var


begin
//Nambah Code dari sini jangan dibawah Menu









// Ini Menu Aatarmuka, nanti menggunakan Repeat dan Case Of
    clrscr;
    writeln('Menu Sistem Reservasi Restoran');
    writeln('1. Tampilakan Ketersediaan');
    writeln('2. Reservasi Meja');
    writeln('3. simpan Data Reservasi');
    writeln('4. Cari Reservasi');
    writeln('5. Keluar');
    writeln('Pilih Menu: '); readln();

end.
