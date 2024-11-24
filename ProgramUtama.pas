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
        tanggal: string;         // tanggal reservasi
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
    tanggalReservasi: string;
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
    write('Masukkan Tanggal Reservasi (DD-MM-YYYY): '); readln(tanggalReservasi);
    meja[nomorMeja].tanggal := tanggalReservasi;
    write('Catatan Khusus (Opsional): '); readln(meja[nomorMeja].catatan);
    
    writeln('Reservasi Berhasil!');
end;

// Prosedur untuk membatalkan reservasi meja
procedure BatalReservasi;
var
    nomorMeja: integer;
    konfirmasi: char;
begin
    clrscr;
    writeln('============================');
    writeln('    Pembatalan Reservasi');
    writeln('============================');

    // Tampilkan ketersediaan meja terlebih dahulu
    tampilkanKetersediaan;
    
    writeln;
    write('Masukkan Nomor Meja yang Ingin Dibatalkan (1-20): '); 
    readln(nomorMeja);

    if (nomorMeja < 1) or (nomorMeja > 20) then
    begin
        writeln('Nomor meja tidak valid.');
        exit;
    end;

    // Periksa apakah meja sudah dipesan
    if meja[nomorMeja].tersedia then
    begin
        writeln('Meja tersebut belum dipesan.');
        exit;
    end;

    // Konfirmasi pembatalan
    writeln('Apakah Anda yakin ingin membatalkan reservasi meja ', nomorMeja, '? (y/n)');
    readln(konfirmasi);
    if (konfirmasi = 'y') or (konfirmasi = 'Y') then
    begin
        meja[nomorMeja].tersedia := true;
        meja[nomorMeja].nama := '';
        meja[nomorMeja].email := '';
        meja[nomorMeja].no_telepon := '';
        meja[nomorMeja].jumlah_tamu := 0;
        meja[nomorMeja].tanggal := '';
        meja[nomorMeja].catatan := '';
        writeln('Reservasi meja ', nomorMeja, ' berhasil dibatalkan.');
    end
    else
        writeln('Pembatalan reservasi dibatalkan.');
end;

// Prosedur untuk mencari reservasi berdasarkan nama secara rekursif
procedure CariReservasiRekursif(index: integer; keyword: string; var ditemukan: boolean);
begin
    // Jika sudah sampai pada akhir array meja
    if index > 20 then
    begin
        if not ditemukan then
            writeln('Tidak ditemukan reservasi dengan nama "', keyword, '".');
        exit;
    end;

    // Periksa apakah nama pemesan sesuai dengan keyword
    if (not meja[index].tersedia) and (Pos(LowerCase(keyword), LowerCase(meja[index].nama)) > 0) then
    begin
        ditemukan := true;
        writeln('Meja ', meja[index].nomor, ':');
        writeln('  Nama       : ', meja[index].nama);
        writeln('  Email      : ', meja[index].email);
        writeln('  No. Telepon: ', meja[index].no_telepon);
        writeln('  Jumlah Tamu: ', meja[index].jumlah_tamu);
        writeln('  Tanggal    : ', meja[index].tanggal);
        writeln('  Catatan    : ', meja[index].catatan);
        writeln;
    end;

    // Rekursif untuk memeriksa meja berikutnya
    CariReservasiRekursif(index + 1, keyword, ditemukan);
end;

// Prosedur utama untuk mencari reservasi
procedure CariReservasi;
var
    keyword: string;
    ditemukan: boolean;
begin
    clrscr;
    writeln('=========================');
    writeln('     Cari Reservasi');
    writeln('=========================');
    write('Masukkan nama pemesan yang ingin dicari: ');
    readln(keyword);
    ditemukan := false;
    CariReservasiRekursif(1, keyword, ditemukan);
end;

procedure SimpanDataReservasi;
var
    i: integer; // Variabel untuk iterasi melalui array meja
begin
    // Menghubungkan variabel txt dengan file bernama 'data_reservasi.txt'
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
            writeln(txt, '  Tanggal    : ', meja[i].tanggal); //menulis Tanggal reservasi
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
            nomor := StrToInt(Copy(temp, 6, Pos(':', temp) - 6));
            meja[nomor].tersedia := false;
            readln(txt, temp); meja[nomor].nama := Copy(temp, 15, Length(temp));
            readln(txt, temp); meja[nomor].email := Copy(temp, 15, Length(temp));
            readln(txt, temp); meja[nomor].no_telepon := Copy(temp, 15, Length(temp));
            readln(txt, temp); meja[nomor].jumlah_tamu := StrToInt(Copy(temp, 15, Length(temp)));
            readln(txt, temp); meja[nomor].tanggal := Copy(temp, 15, Length(temp));
            readln(txt, temp); meja[nomor].catatan := Copy(temp, 15, Length(temp));
            readln(txt); // Skip baris kosong
        end;
    end;

    close(txt);
end;

// Ini Menu Aatarmuka, nanti menggunakan Repeat dan Case Of
begin
    inisialisasiMeja;
    MuatDataReservasi; // Memuat data reservasi dari file jika ada

    repeat
        clrscr;
        writeln('|================================|');
        writeln('| Menu Sistem Reservasi Restoran |');
        writeln('|================================|');
        writeln('| 1. Tampilkan Ketersediaan      |');
        writeln('| 2. Reservasi Meja              |');
        writeln('| 3. Pembatalan Reservasi Meja   |');
        writeln('| 4. Simpan Data Reservasi       |');
        writeln('| 5. Cari Reservasi              |');
        writeln('| 6. Keluar                      |');
        writeln('|================================|');
        writeln;
        write('Pilih Menu: ');readln(pilihan);
        writeln;

        case pilihan of
            1: tampilkanKetersediaan;
            2: reservasiMeja;
            3: BatalReservasi;
            4: SimpanDataReservasi;
            5: CariReservasi;
            6: writeln('Terima kasih!');
            else
                writeln('Pilihan tidak valid.');
        end;
        if pilihan <> 6 then
        begin
            writeln;
            write('Tekan Enter untuk melanjutkan...');
            readln;
        end;
    until pilihan = 6;
end.
