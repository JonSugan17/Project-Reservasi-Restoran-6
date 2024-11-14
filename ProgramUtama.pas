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
    meja: array[1..20] of Tmeja;        // penyimpanan sementara data meja
    txt: text                           // file untuk menyimpan data
    pilihan: integer                    // pilihan menu yang akan dipilih


// procedure untuk menetapkan nilai default attribut meja
procedure inisialisasiMeja;
var
    i : integer
begin
    // menetapkan nilai attribut meja menggunakan perulangan
    for i := 1 to 20 do
    begin
        meja[i].nomor := i,
        meja[i].tersedia := true;
        meja[i].nama := '';`
        meja[i].email := '';
        meja[i].no_telepon := '';
        meja[i].jumlah_tamu := '';
        meja[i].catatan := '';
    end;
end;


// procedure untuk mengecek apakah terdapat meja yang tersedia
procedure tampilkanKetersediaan;
var
    i : integer
begin
    writeln('Data Meja Yang Masih Tersedia');
    for i := 1 to 20 do             // perulangan dilakukan sebanyak 20 kali 
    begin
        if meja[i].tersedia then
            // Jika meja tersedia                                
            writeln('Meja ', meja[i].nomor, ' - Tersedia')
        else
            // Jika meja sudah dipesan
            writeln('Meja ', meja[i].nomor, ' - Dipesan Oleh ', meja[i].nama);
    end;
end;




// Ini Menu Aatarmuka, nanti menggunakan Repeat dan Case Of
begin
    clrscr;
    writeln('Menu Sistem Reservasi Restoran');
    writeln('1. Tampilakan Ketersediaan');
    writeln('2. Reservasi Meja');
    writeln('3. simpan Data Reservasi');
    writeln('4. Cari Reservasi');
    writeln('5. Keluar');
    writeln('Pilih Menu: '); readln();
end.
