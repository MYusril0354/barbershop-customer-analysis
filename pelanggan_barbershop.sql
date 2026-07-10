
-- Total Pelanggan Unik
SELECT COUNT(DISTINCT nama) as TotalPelangganUnik FROM pelanggan;

-- Berapa Kunjungan Per Bulan dan Prosentase kenaikan dan penuruan dari bulan sebelumnya
SELECT strftime('%Y-%m', tanggal_kunjungan) AS bulan,
       COUNT(*) AS total_kunjungan,
       ROUND((COUNT(*)-LAG(COUNT(*),1) OVER(ORDER BY strftime('%Y-%m', tanggal_kunjungan)))*100.00/LAG(COUNT(*),1) OVER(ORDER BY strftime('%Y-%m', tanggal_kunjungan)),2)|| '%'[Prosentase]
FROM pelanggan
GROUP BY bulan
ORDER BY bulan;

-- Perbandingan gender
SELECT gender,COUNT (*) AS jumlah, ROUND(COUNT(*)*100.00/SUM(COUNT(*)) OVER(),2)|| '%' as prosentase FROM pelanggan 
GROUP BY gender;

-- Perbandingan layanan
SELECT layanan,
COUNT(*) as jumlah,
ROUND(COUNT(*)*100.00/SUM(COUNT(*)) OVER(),2)||'%' as Prosentase 
FROM pelanggan
GROUP BY layanan
ORDER BY jumlah DESC;

-- Mencari Hari mana yang paling sering ada pelanggan
SELECT CASE strftime('%w', tanggal_kunjungan)
          WHEN '0' THEN 'Minggu'
          WHEN '1' THEN 'Senin'
          WHEN '2' THEN 'Selasa'
          WHEN '3' THEN 'Rabu'
          WHEN '4' THEN 'Kamis'
          WHEN '5' THEN 'Jumat'
          WHEN '6' THEN 'Sabtu'
          END AS Hari,
       COUNT(*) AS total,
       ROUND(COUNT(*)*100.00 /SUM(COUNT(*)) OVER(),2) || '%' as Prosentase
FROM pelanggan
GROUP BY Hari
ORDER BY Total DESC;

-- Mencari Estimasi Pendapatan dengan custom harga
SELECT layanan,
       COUNT(*)[Jumlah],
       CASE layanan
            WHEN 'Potong Rambut' THEN COUNT(*) * 30000
            WHEN 'Cuci Rambut'   THEN COUNT(*) * 20000
            WHEN 'Kreambath'     THEN COUNT(*) * 50000
            ELSE COUNT(*) * 25000
       END AS estimasi_revenue
FROM pelanggan
GROUP BY layanan
ORDER BY estimasi_revenue DESC;


-- Mencari Pelanggan yang terlama
SELECT nama,COUNT(*)[Qty],MIN(tanggal_kunjungan)[tanggal_pertama],ROUND(julianday('now','localtime')-julianday(MIN(tanggal_kunjungan)))[hari_sejak_pertama_kunjungan]
FROM pelanggan
GROUP BY nama
ORDER BY hari_sejak_pertama_kunjungan DESC;

-- Mencari Pelanggan berapa hari kunjungan terakhir dengan kunjungan sebelumnya
SELECT 
       nama,
       MAX(tanggal_kunjungan)[kunjungan_terakhir],
       LAG(tanggal_kunjungan) OVER (ORDER BY tanggal_kunjungan)[kunjungan_sebelumnya],
       julianday(MAX(tanggal_kunjungan))-julianday(LAG(tanggal_kunjungan) OVER(ORDER BY tanggal_kunjungan))[hari]
FROM pelanggan
GROUP BY nama
ORDER BY hari DESC;

-- Mencari Pelanggan sudah berapa hari tidak datang lagi
SELECT nama,
       MAX(tanggal_kunjungan)[kunjungan_terakhir],
       COUNT(*)[qty],
       ROUND(julianday('now','localtime')-julianday(MAX(tanggal_kunjungan)),0)[hari]
FROM pelanggan
GROUP BY nama
HAVING hari>500
ORDER BY hari DESC;

-- Mencari Berapa Kunjungan Pelanggan dan Rankingnya
SELECT nama,
       COUNT(*)[qty],
       RANK() OVER(ORDER BY COUNT(*) DESC)[rank]
FROM pelanggan
GROUP BY nama
ORDER BY rank ASC
LIMIT 10;

SELECT * FROM pelanggan ORDER BY tanggal_kunjungan DESC LIMIT 10;