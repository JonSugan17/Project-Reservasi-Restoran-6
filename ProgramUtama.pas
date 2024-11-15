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

// Procedure untuk melakukan reservasi meja
procedure reservasiMeja;
var
    nomorMeja: integer;
begin
    writeln('Reservasi Meja');
    writeln('=====================');
    
    // Tampilkan ketersediaan meja terlebih dahulu
    tampilkanKetersediaan;
    
    writeln;
    write('Masukkan Nomor Meja yang Ingin Dipesan (1-20): '); 
    readln(nomorMeja);
    
    if (nomorMeja < 1) or (nomorMeja > 20) then
    begin
        writeln('Nomor meja tidak valid.');
        exit;
    end;

    // Untuk mengecek apakah meja sudah dipesan atau belum
    if not meja[nomorMeja].tersedia then
    begin
        writeln('Meja tersebut sudah dipesan oleh ', meja[nomorMeja].nama);
        exit;
    end;
    
    // Memasukkan data reservasi
    meja[nomorMeja].tersedia := false;
    write('Masukkan Nama Pemesan: '); readln(meja[nomorMeja].nama);
    write('Masukkan Email: '); readln(meja[nomorMeja].email);
    write('Masukkan Nomor Telepon: '); readln(meja[nomorMeja].no_telepon);
    write('Masukkan Jumlah Tamu: '); readln(meja[nomorMeja].jumlah_tamu);
    write('Catatan Khusus (Opsional): '); readln(meja[nomorMeja].catatan);
    
    writeln('Reservasi Berhasil!');
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
