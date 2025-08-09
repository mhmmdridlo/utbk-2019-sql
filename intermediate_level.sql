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
