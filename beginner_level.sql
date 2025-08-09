--- Level Beginner

-- Tampilkan semua program studi dengan kapasitas lebih dari 60
select nama_prodi "Nama Program Studi", kapasitas "Kapasitas"
from program_studi
where kapasitas > 60

-- Tampilkan nama universitas yang mengandung kata MALIK
select nama_universitas "Nama Universitas"
from universitas
where nama_universitas like '%MALIK%'

-- Berapa banyak program studi yang dimiliki oleh setiap universitas?
select u.nama_universitas "Nama Universitas", count(ps.id_prodi) "Jumlah Program Studi"
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas
group by u.nama_universitas 
order by u.nama_universitas

-- Tampilkan universitas yang memiliki jumlah program studi lebih dari 10
select u.nama_universitas 'Nama Universitas', count(ps.id_prodi) "Jumlah Program Studi"
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas
group by u.nama_universitas
having count(ps.id_prodi) > 10
order by "Jumlah Program Studi" DESC

-- Tampilkan 5 universitas pertama berdasarkan urutan nama universitas (A-Z)
select nama_universitas "Nama Universitas"
from universitas
order by nama_universitas 
limit 5

-- Tampilkan semua program studi dari universitas yang memiliki id_universitas 111, 112, atau 113
select id_universitas "ID Universitas", nama_prodi "Nama Prodi" 
from program_studi
where id_universitas in(111,112,113)

-- Tampilkan semua pengguna yang memilih universitas bukan 521 atau 355 sebagai pilihan kedua
select id_pil2_universitas "ID Pilihan Kedua", id_user "ID Pengguna"
from skor_saintek 
where id_pil2_universitas not in(521,355)

-- Tampilkan 10 pengguna dengan nilai matematika tertinggi 
select id_user "ID Pengguna", score_mat "Score Matematika"
from skor_saintek
order by score_mat desc
limit 10

-- Berapa rata-rata nilai matematika (score_mat) untuk setiap universitas pilihan pertama (id_pil1_universitas)
select sa.id_pi1_universitas "ID Pilihan Pertama", u.nama_universitas "Nama Universitas", round(avg(sa.score_mat)) "Nilai Rata-Rata Matematika"
from skor_saintek sa join universitas u on sa.id_pi1_universitas = u.id_universitas 
group by sa.id_pi1_universitas, u.nama_universitas 

-- Tampilkan id_pil1_universitas yang memiliki rata-rata nilai matematika (score_mat) lebih dari 600
select sa.id_pi1_universitas "ID Pilihan Pertama", u.nama_universitas "Nama Universitas", round(avg(sa.score_mat)) "Nilai Rata-Rata Matematika > 600"
from skor_saintek sa join universitas u on sa.id_pi1_universitas = u.id_universitas 
group by sa.id_pi1_universitas, u.nama_universitas 
having round(avg(sa.score_mat)) > 600


--- Level Intermediate

-- Tampilkan 3 universitas yang memiliki jumlah program studi paling banyak
select u.nama_universitas "Nama Universitas", count(ps.id_prodi) "Jumlah Prodi"
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas
group by u.nama_universitas
order by count(ps.id_prodi) desc
limit 3

-- Tampilkan semua program studi yang memiliki kapasitas antara 40 sampai 60, dan termasuk dalam kelompok science
select nama_prodi "Nama Prodi", kapasitas "Kapasitas"
from program_studi
where kelompok='saintek' and (kapasitas between 40 and 60)

-- Tampilkan nama universitas yang memiliki rata-rata kapasitas prodi di bawah 50, urut dari yang paling kecil
select u.nama_universitas "Nama Universitas", round(avg(kapasitas)) "Rata-Rata Kapasitas"
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas 
group by u.nama_universitas
having avg(kapasitas) < 50
order by 2

-- Tampilkan 5 program studi saintek dengan kapasitas terbanyak, dan sertakan juga nama universitas-nya
select u.nama_universitas "Nama Universitas", ps.kapasitas "Kapasitas"
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas
where kelompok='saintek'
order by ps.kapasitas desc
limit 5

-- Tampilkan jumlah pengguna (id_user) yang memiliki nilai matematika (score_mat) antara 600 dan 800, dan nilai biologi (score_bio) lebih dari 500
select count(id_user) "Jumlah Pengguna"
from skor_saintek 
where score_bio > 500 and (score_mat between 600 and 800)

-- Tampilkan universitas pilihan kedua (id_pil2_universitas) yang memiliki rata-rata nilai kimia (score_kim) di bawah 550, urutkan dari rata-rata terkecil ke terbesar
select u.nama_universitas "Universitas Pilihan Kedua", round(avg(sa.score_kim)) "Rata-Rata Nilai Kimia"
from universitas u join skor_saintek sa on u.id_universitas = sa.id_pil2_universitas
group by u.nama_universitas
having avg(sa.score_kim) < 500
order by 2

  
--- Level Advanced

-- Tampilkan 3 program studi saintek yang memiliki rata-rata skor matematika tertinggi dari para pengguna yang memilihnya sebagai pilihan pertama
select ps.nama_prodi "Nama Program Studi", round(avg(sa.score_mat)) "Rata-Rata Skor Matematika"
from program_studi ps join skor_saintek sa on ps.id_prodi = sa.id_pil1_prodi
where ps.kelompok='saintek'
group by ps.nama_prodi
order by 2 desc
limit 3

-- Tampilkan daftar universitas yang memiliki lebih dari 5 program studi dan rata-rata kapasitasnya lebih dari 45, urutkan dari rata-rata kapasitas tertinggi ke terendah
select u.nama_universitas "Nama Universitas", count(ps.id_prodi) "Jumlah Prodi", round(avg(ps.kapasitas)) "Rata-Rata Kapasitas"
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas
group by u.nama_universitas 
having round(avg(ps.kapasitas)) > 45 and count(ps.id_prodi) > 5
order by 2 desc

-- Tampilkan 3 prodi saintek dengan rata-rata nilai biologi tertinggi dari pilihan ke-2 (id_pil2_prodi) beserta nama universitasnya
select u.nama_universitas "Nama Universitas", ps.nama_prodi "Nama Program Studi", round(avg(sa.score_bio))
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas join skor_saintek sa on ps.id_prodi = sa.id_pil2_prodi 
group by u.nama_universitas, ps.nama_prodi
order by 3 desc
limit 3

-- Tampilkan nama universitas dan jumlah prodi saintek & soshum masing-masing (dua kolom berbeda) — urutkan berdasarkan jumlah prodi saintek terbanyak
select u.nama_universitas,
sum(case when kelompok='saintek' then 1 else 0 end) "Jumlah Prodi Saintek",
sum(case when kelompok='soshun' then 1 else 0 end) "Jumlah Prodi Soshum"
from universitas u join program_studi ps on u.id_universitas = ps.id_universitas 
group by u.nama_universitas 
order by 2 desc
