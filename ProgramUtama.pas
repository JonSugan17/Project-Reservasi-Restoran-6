program SistemReservasiRestoran;
uses crt, SysUtils;
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
    end;

var
    meja: array[1..20] of Tmeja;        // penyimpanan sementara data meja
    txt: text;                          // file untuk menyimpan data
    pilihan: integer;                    // pilihan menu yang akan dipilih


// procedure untuk menetapkan nilai default attribut meja
procedure inisialisasiMeja;
var
    i : integer;
begin
    // menetapkan nilai attribut meja menggunakan perulangan
    for i := 1 to 20 do
    begin
        meja[i].nomor := i;
        meja[i].tersedia := true;
        meja[i].nama := '';
        meja[i].email := '';
        meja[i].no_telepon := '';
        meja[i].jumlah_tamu := 0;
        meja[i].catatan := '';
    end;
end;


// procedure untuk mengecek apakah terdapat meja yang tersedia
procedure tampilkanKetersediaan;
var
    i : integer;
begin
    writeln('Data Meja Yang Masih Tersedia:');
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
    writeln('=====================');
    writeln('   Reservasi Meja');
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

procedure CariReservasi();
begin
    writeln('wlee');
    // buat pencarian memakai rekursif
end;


procedure SimpanDataReservasi;
var
    i: integer; // Variabel untuk iterasi melalui array meja
begin
    // Menghubungkan variabel `txt` dengan file bernama 'data_reservasi.txt'
    assign(txt, 'data_reservasi.txt');
    // Membuka file untuk ditulis ulang, file sebelumnya akan dihapus jika ada
    rewrite(txt);
    // Looping untuk memproses semua meja dari nomor 1 hingga 20
    for i := 1 to 20 do
    begin
        // Memeriksa apakah meja telah dipesan (tidak tersedia)
        if not meja[i].tersedia then
        begin
            // Menulis data meja yang telah dipesan ke dalam file
            writeln(txt, 'Meja ', meja[i].nomor, ':'); // Menulis nomor meja
            writeln(txt, '  Nama       : ', meja[i].nama); // Menulis nama pemesan
            writeln(txt, '  Email      : ', meja[i].email); // Menulis email pemesan
            writeln(txt, '  No. Telepon: ', meja[i].no_telepon); // Menulis nomor telepon
            writeln(txt, '  Jumlah Tamu: ', meja[i].jumlah_tamu); // Menulis jumlah tamu
            writeln(txt, '  Catatan    : ', meja[i].catatan); // Menulis catatan tambahan
            writeln(txt); // Menulis baris kosong untuk memisahkan setiap meja
        end;
    end;
    // Menutup file setelah selesai menulis
    close(txt);
    // Memberikan konfirmasi kepada pengguna bahwa data telah disimpan
    writeln('Data reservasi telah disimpan ke file data_reservasi.txt');
end;

procedure MuatDataReservasi;
var
    i, nomor: integer;
    temp: string;
begin
    assign(txt, 'data_reservasi.txt');
    {$I-} // Nonaktifkan error I/O agar tidak berhenti jika file tidak ditemukan
    reset(txt);
    {$I+} // Aktifkan kembali error I/O

    if IOResult <> 0 then
    begin
        writeln('File data_reservasi.txt tidak ditemukan. Data akan diinisialisasi ulang.');
        exit;
    end;

    while not eof(txt) do
    begin
        readln(txt, temp); // Baca baris pertama (Meja X:)
        if Pos('Meja ', temp) = 1 then
        begin
            // Ambil nomor meja dari teks, misalnya dari "Meja 1:" -> ambil 1
            nomor := StrToInt(Copy(temp, 6, Pos(':', temp) - 6));
            meja[nomor].nomor := nomor;
            meja[nomor].tersedia := false; // Meja otomatis tidak tersedia

            // Baca data pemesan berikutnya
            readln(txt, temp); meja[nomor].nama := Copy(temp, 15, Length(temp));
            readln(txt, temp); meja[nomor].email := Copy(temp, 15, Length(temp));
            readln(txt, temp); meja[nomor].no_telepon := Copy(temp, 15, Length(temp));
            readln(txt, temp); meja[nomor].jumlah_tamu := StrToInt(Copy(temp, 15, Length(temp)));
            readln(txt, temp); meja[nomor].catatan := Copy(temp, 15, Length(temp));
            readln(txt); // Skip baris kosong
        end;
    end;

    close(txt);
end;

// Ini Menu Aatarmuka, menggunakan Repeat dan Case Of
begin
    inisialisasiMeja;

    repeat
        clrscr;
        writeln('|===============================|');
        writeln('|Menu Sistem Reservasi Restoran |');
        writeln('|===============================|');
        writeln('| 1. Tampilkan Ketersediaan     |');
        writeln('| 2. Reservasi Meja             |');
        writeln('| 3. Simpan Data Reservasi      |');
        writeln('| 4. Cari Reservasi             |');
        writeln('| 5. Keluar                     |');
        writeln('|===============================|');
        writeln;
        write('Pilih Menu: ');readln(pilihan);
        writeln;

        case pilihan of
            1: tampilkanKetersediaan;
            2: reservasiMeja;
            3: SimpanDataReservasi;
            4: CariReservasi;
            5: writeln('Terima kasih!');
            else
                writeln('Pilihan tidak valid.');
        end;
        if pilihan <> 5 then
        begin
            writeln;
            write('Tekan Enter untuk melanjutkan...');
            readln;
        end;
    until pilihan = 5;
end.
